//
//  DianpingDealTool.h
//  tuan
//
//  Created by zerd on 14-12-16.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  请求大众点评数据工具类

#import <Foundation/Foundation.h>
#import "Singleton.h"

@class DealModel;

typedef void (^SuccessBlock)(NSArray *deals, int totalCount);
typedef void (^FailureBlock)(NSError *error);

@interface DianpingDealTool : NSObject

singleton_interface(DianpingDealTool)

#pragma mark 获取指定页数的团购信息
- (void)dealsWithPage:(int)page success:(SuccessBlock)success failure:(FailureBlock)failure;

#pragma mark 获取指定团购的详细信息
- (void)dealWithID:(NSString *)ID success:(void (^)(DealModel *deal))success failure:(FailureBlock)failure;

@end
