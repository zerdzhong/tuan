//
//  CollectDealTool.h
//  tuan
//
//  Created by zerd on 15-1-5.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DealModel.h"
#import "Singleton.h"

@interface CollectDealTool : NSObject

singleton_interface(CollectDealTool)

@property (nonatomic, strong, readonly) NSArray *collectDeals;

- (BOOL)isDealCollected:(DealModel *)deal;
//收藏团购
- (void)collectDeal:(DealModel *)deal;
//取消收藏团购
- (void)disCollectDeal:(DealModel *)deal;

@end
