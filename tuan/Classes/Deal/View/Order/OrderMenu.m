//
//  OrderMenu.m
//  tuan
//
//  Created by zerd on 14-12-9.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "OrderMenu.h"
#import "OrderMenuItem.h"
#import "MetaDataTool.h"
#import "Common.h"

@implementation OrderMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *orderArray = [MetaDataTool sharedMetaDataTool].totalOrders;
        for (int i = 0; i < orderArray.count; i++) {
            OrderMenuItem *item = [[OrderMenuItem alloc]init];
            item.order = orderArray[i];
            item.frame = CGRectMake(i * kDropDownItemWidth, 0, 0, 0);
            [self.scrollView addSubview:item];
        }
        self.scrollView.contentSize = CGSizeMake(orderArray.count * kDropDownItemWidth, kDropDownItemHeight);
    }
    return self;
}

@end
