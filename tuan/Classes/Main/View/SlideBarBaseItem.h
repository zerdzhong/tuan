//
//  SlideBarItem.h
//  tuan
//
//  Created by zerd on 14-11-26.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  slidebar上所有item的父类

#import <UIKit/UIKit.h>

@interface SlideBarBaseItem : UIButton

@property (nonatomic,strong) UIImageView *divider;
@property (nonatomic,copy) NSString *icon;

@end
