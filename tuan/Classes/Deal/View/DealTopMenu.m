//
//  DealTopMenu.m
//  tuan
//
//  Created by zerd on 14-12-5.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  团购顶部菜单

#import "DealTopMenu.h"
#import "DealTopMenuItem.h"
#import "Common.h"

#define kItemMargin 10

@implementation DealTopMenu

- (instancetype)init
{
    self = [super init];
    if (self) {
        DealTopMenuItem *categoryItem = [[DealTopMenuItem alloc]init];
        categoryItem.title = @"全部分类";
        categoryItem.frame = CGRectMake(0, 0, 0, 0);
        [self addSubview:categoryItem];
        DealTopMenuItem *districtItem = [[DealTopMenuItem alloc]init];
        districtItem.title = @"全部商区";
        districtItem.frame = CGRectMake(kTopMenuItemWidth + kItemMargin, 0, 0, 0);
        [self addSubview:districtItem];
        DealTopMenuItem *orderItem = [[DealTopMenuItem alloc]init];
        orderItem.title = @"默认排序";
        orderItem.frame = CGRectMake((kTopMenuItemWidth + kItemMargin) * 2, 0, 0, 0);
        [self addSubview:orderItem];
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    frame.size = CGSizeMake(3*kTopMenuItemWidth, kTopMenuItemHeight);
    [super setFrame:frame];
}

@end
