//
//  SlideBar.m
//  tuan
//
//  Created by zerd on 14-11-26.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "SlideBar.h"
#import "Common.h"
#import "SlideBarMoreItem.h"
#import "SlideBarLocationItem.h"
#import "SlideBarTabItem.h"

@interface SlideBar ()

@property (nonatomic, strong)SlideBarTabItem *selectedItem;

@end

@implementation SlideBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //自动伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
        //设置背景
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tabbar.png"]];
        //添加logo
        [self addLogo];
        //添加选项
        [self addTabs];
        //添加更多
        [self addMore];
        //添加定位按钮
        [self addLocation];

    }
    return self;
}

#pragma mark- 添加logo
- (void)addLogo{
    UIImageView *logo = [[UIImageView alloc]init];
    [logo setImage:[UIImage imageNamed:@"ic_logo.png"]];
    //设置尺寸
    CGFloat logoW = logo.image.size.width * 0.65;
    CGFloat logoH = logo.image.size.height * 0.65;
    logo.bounds = CGRectMake(0, 0, logoW, logoH);
    //设置位置
    logo.center = CGPointMake(kItemWidth * 0.5, kItemHeight * 0.5);
    [self addSubview:logo];
}

#pragma mark- 添加选项
- (void)addTabs{
    //1.团购
    [self addOneTab: @"ic_deal.png" index:1];
    //2.地图
    [self addOneTab: @"ic_map.png" index:2];
    //3.收藏
    [self addOneTab: @"ic_collect.png" index:3];
    //4.我的
    [self addOneTab: @"ic_mine.png" index:4];
    
    //添加底部分割线
    UIImageView *divider = [[UIImageView alloc]init];
    divider.image = [UIImage imageNamed:@"separator_tabbar_item.png"];
    divider.frame = CGRectMake(0, kItemHeight * 5, kItemWidth, 2);
    [self addSubview:divider];
}

- (void)addOneTab:(NSString *)icon index:(int)index{
    SlideBarTabItem *tab = [[SlideBarTabItem alloc]init];
    tab.frame = CGRectMake(0, kItemHeight * index, 0, 0);
    [tab addTarget:self action:@selector(onTabClicked:) forControlEvents:UIControlEventTouchDown];
    [tab setIcon:icon];
    [tab setTag:index-1];
    [self addSubview:tab];
    if (index == 1) {
        [self onTabClicked:tab];
    }
}

- (void)onTabClicked:(SlideBarTabItem *)item{
    //控制状态
    [_selectedItem setEnabled:YES];
    
    if ([_delegate respondsToSelector:@selector(slideBarItem:tabFrom:to:)]) {
        [_delegate slideBarItem:self tabFrom:(int)_selectedItem.tag to:(int)item.tag];
    }
    
    _selectedItem = item;
    [_selectedItem setEnabled:NO];
}

#pragma mark- 添加定位按钮
- (void)addLocation{
    SlideBarLocationItem *locationItem = [[SlideBarLocationItem alloc]init];
    CGFloat y = self.frame.size.height - 2 * kItemHeight;
    locationItem.frame = CGRectMake(0, y, 0, 0);
    [self addSubview:locationItem];
}

#pragma mark- 添加更多
- (void)addMore{
    
    SlideBarMoreItem *moreItem = [[SlideBarMoreItem alloc]init];
    CGFloat y = self.frame.size.height - kItemHeight;
    moreItem.frame = CGRectMake(0, y, 0, 0);
    [self addSubview:moreItem];
}

#pragma mark- 重写setFrame 防止宽高被修改
-(void)setFrame:(CGRect)frame{
    frame.size.width = kItemWidth;
    [super setFrame:frame];
}

@end
