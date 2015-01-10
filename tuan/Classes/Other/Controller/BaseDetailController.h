//
//  BaseDetailController.h
//  tuan
//
//  Created by zerd on 15-1-10.
//  Copyright (c) 2015年 zerd. All rights reserved.
//  需要显示团购详情 继承这个类就好啦

#import <UIKit/UIKit.h>

@class CoverView;
@class DealModel;

@interface BaseDetailController : UIViewController{
        CoverView *_cover;
}

- (void)showDealDetailController:(DealModel *)deal;
- (void)hideDealDetailController;

@end
