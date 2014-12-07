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

@interface DealTopMenu ()

@property (nonatomic, strong)DealTopMenuItem *selectedItem;

@end

@implementation DealTopMenu

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addItem:@"全部分类" index:0];
        [self addItem:@"全部商区" index:1];
        [self addItem:@"默认排序" index:2];
    }
    return self;
}

- (void)addItem:(NSString *)title index:(int)index{
    DealTopMenuItem *item = [[DealTopMenuItem alloc]init];
    item.title = title;
    item.frame = CGRectMake((kTopMenuItemWidth + kItemMargin) * index, 0, 0, 0);
    
    [item addTarget:self
                     action:@selector(onItemClicked:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:item];
}

- (void)onItemClicked:(DealTopMenuItem *)item{
    _selectedItem.selected = NO;
    if (_selectedItem == item) {
        _selectedItem = nil;
    }else{
        _selectedItem = item;
    }
    _selectedItem.selected = YES;
}

-(void)setFrame:(CGRect)frame{
    frame.size = CGSizeMake(3*kTopMenuItemWidth, kTopMenuItemHeight);
    [super setFrame:frame];
}

@end
