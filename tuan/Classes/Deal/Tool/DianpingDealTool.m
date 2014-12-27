//
//  DianpingDealTool.m
//  tuan
//
//  Created by zerd on 14-12-16.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  请求大众点评数据工具类

#import "DianpingDealTool.h"
#import "DPAPI.h"
#import "MetaDataTool.h"
#import "DealModel.h"
#import "NSObject+Value.h"
#import "Common.h"

typedef void (^RequestCompletion)(id result, NSError *error);

@interface DianpingDealTool ()<DPRequestDelegate>

@property (nonatomic, strong) NSMutableDictionary *blocks;

@end

@implementation DianpingDealTool

- (instancetype)init
{
    self = [super init];
    if (self) {
        _blocks = [[NSMutableDictionary alloc]init];
    }
    return self;
}

singleton_implementation(DianpingDealTool)

#pragma mark 获取指定页数的团购信息
- (void)dealsWithPage:(int)page success:(SuccessBlock)success failure:(FailureBlock)failure{

    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@"15" forKey:@"limit"];
    [params setValue:@(page) forKey:@"page"];
    //添加城市参数
    NSString *city = [MetaDataTool sharedMetaDataTool].currentCity.name;
    if (city != nil) {
        [params setValue:city forKey:@"city"];
    }else{
        failure([NSError errorWithDomain:@"没有城市信息" code:0 userInfo:nil]);
        return;
    }
    
    //添加区域参数
    NSString *region = [MetaDataTool sharedMetaDataTool].currentDistrict;
    if (region != nil && ![region isEqualToString:kAllDistrict]) {
        [params setValue:region forKey:@"region"];
    }

    //添加分类参数
    NSString *category = [MetaDataTool sharedMetaDataTool].currentCategory;
    if (category != nil && ![category isEqualToString:kAllCategory]) {
        [params setValue:category forKey:@"category"];
    }

    //添加分类参数
    OrderModel *order = [MetaDataTool sharedMetaDataTool].currentOrder;
    if (order != nil) {
        [params setValue:@(order.index) forKey:@"sort"];
    }
    
    //请求数据
    [self requestUrl:@"v1/deal/find_deals" params:params block:^(id result, NSError *error) {
        if (success != nil && result != nil ) { //请求成功
            //转换成数据Model
            NSArray *array = result[@"deals"];
            
            NSMutableArray *dealArray = [[NSMutableArray alloc]init];
            for (NSDictionary *deal in array) {
                DealModel *dealModel = [[DealModel alloc]init];
                [dealModel setValues:deal];
                [dealArray addObject:dealModel];
            }
            success(dealArray,[result[@"total_count"] intValue]);
        }
        
        if (failure != nil && error != nil) {   //请求失败
            failure(error);
        }
        
    }];
}

#pragma mark 获取指定团购的详细信息
- (void)dealWithID:(NSString *)ID success:(void (^)(DealModel *deal))success failure:(FailureBlock)failure{
    [self requestUrl:@"v1/deal/get_single_deal" params:@{@"deal_id":ID} block:^(id result, NSError *error) {
        if (success != nil && result != nil ) {
            //成功了
            DealModel *deal = [[DealModel alloc]init];
            [deal setValues:result[@"deals"][0]];
            success(deal);
        }else{
            //失败了
            failure(error);
        }
    }];
}

#pragma mark- 封装点评请求

- (void)requestUrl:(NSString *)url params:(NSDictionary *)params block:(RequestCompletion)block{
    
    DPAPI *api = [DPAPI sharedDPAPI];
    DPRequest *request = [api requestWithURL:url params:params delegate:self];
    
    //一次请求 对应一个block
    [_blocks setObject:block forKey:request.description];
}

#pragma mark- 点评delegate
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    
    RequestCompletion block = [_blocks objectForKey:request.description];
    if (block != nil) {
        block(result,nil);
        [_blocks removeObjectForKey:request.description];
    }
    
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error{
    RequestCompletion block = [_blocks objectForKey:request.description];
    if (block != nil) {
        block(nil,error);
        [_blocks removeObjectForKey:request.description];
    }
}

@end
