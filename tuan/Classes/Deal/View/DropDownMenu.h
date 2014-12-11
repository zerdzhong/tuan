//
//  DropDownMenu.h
//  tuan
//
//  Created by zerd on 14-12-8.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  底部菜单(基类)

#import <UIKit/UIKit.h>

@interface DropDownMenu : UIView

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, copy) void(^hiddenBlock)();

//通过动画显示出来
- (void)showWithAnimation;
//通过动画隐藏出来
- (void)hideWithAnimation;

@end
