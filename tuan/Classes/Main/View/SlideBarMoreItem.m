//
//  SlideBarMoreItem.m
//  tuan
//
//  Created by zerd on 14-11-26.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  『更多』业务逻辑

#import "SlideBarMoreItem.h"
#import "MoreController.h"
#import "BaseNavigationController.h"

@implementation SlideBarMoreItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置自动伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        //设置图片
        [self setIcon:@"ic_more.png"];
        
        //设置监听
        [self addTarget:self action:@selector(onMoreClicked) forControlEvents:UIControlEventTouchDown];
        
    }
    return self;
}

- (void)onMoreClicked{
    //弹出more控制器
    self.enabled = NO;
    MoreController *moreController = [[MoreController alloc]init];
    moreController.moreItem = self;
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:moreController];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
}

@end
