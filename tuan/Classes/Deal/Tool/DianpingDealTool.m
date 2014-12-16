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

- (void)dealsWithPage:(int)page success:(SuccessBlock)success failure:(FailureBlock)failure{

    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
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
    if (region != nil) {
        [params setValue:region forKey:@"region"];
    }

    //添加分类参数
    NSString *category = [MetaDataTool sharedMetaDataTool].currentCategory;
    if (category != nil) {
        [params setValue:category forKey:@"category"];
    }

    //添加分类参数
    OrderModel *order = [MetaDataTool sharedMetaDataTool].currentOrder;
    if (order != nil) {
        [params setValue:@(order.index) forKey:@"sort"];
    }
    
    //请求数据
    [self requestUrl:@"v1/deal/find_deals" params:params block:^(id result, NSError *error) {
        if (success != nil && result != nil ) {
            //转换成数据Model
            NSArray *array = result[@"deals"];
            
            NSMutableArray *dealArray = [[NSMutableArray alloc]init];
            for (NSDictionary *deal in array) {
                DealModel *dealModel = [[DealModel alloc]init];
                [dealModel setValues:deal];
                [dealArray addObject:dealModel];
            }
            success(dealArray);
        }
        
        if (failure != nil && error != nil) {
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
//        [_blocks removeObjectForKey:request.description];
    }
    
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error{
    RequestCompletion block = [_blocks objectForKey:request.description];
    if (block != nil) {
        block(nil,error);
//        [_blocks removeObjectForKey:request.description];
    }
}

@end
