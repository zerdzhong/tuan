//
//  DropDownSubTitle.h
//  tuan
//
//  Created by zerd on 14-12-12.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  展示菜单子标题

#import <UIKit/UIKit.h>

@interface DropDownSubTitle : UIImageView

//所有子标题
@property (nonatomic, strong) NSArray *titles;

//通过动画显示出来
- (void)showWithAnimation;
//通过动画隐藏出来
- (void)hideWithAnimation;

@end
