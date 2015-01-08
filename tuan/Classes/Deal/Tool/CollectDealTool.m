//
//  CollectDealTool.m
//  tuan
//
//  Created by zerd on 15-1-5.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "CollectDealTool.h"
#import "Common.h"

#define kFilePath         [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"collect.data"]

@interface CollectDealTool ()
{
    NSMutableArray *_collectDeals;
}

@end

@implementation CollectDealTool

singleton_implementation(CollectDealTool)


- (instancetype)init
{
    self = [super init];
    if (self) {
        //加载沙盒数据
        _collectDeals = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        if (_collectDeals == nil) {
            _collectDeals = [[NSMutableArray alloc]init];
        }
    }
    return self;
}

- (BOOL)isDealCollected:(DealModel *)deal{
    deal.collected = [_collectDeals containsObject:deal];
    return deal.collected;
}

//收藏团购
- (void)collectDeal:(DealModel *)deal{
    [_collectDeals insertObject:deal atIndex:0];
    [NSKeyedArchiver archiveRootObject:_collectDeals toFile:kFilePath];
    deal.collected = YES;
    [[NSNotificationCenter defaultCenter]postNotificationName:kCollectChanged object:nil];
}
//取消收藏团购
- (void)disCollectDeal:(DealModel *)deal{
    [_collectDeals removeObject:deal];
    [NSKeyedArchiver archiveRootObject:_collectDeals toFile:kFilePath];
    deal.collected = NO;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kCollectChanged object:nil];
}

@end
