//
//  UIBarButtonItem+ZD.h
//  微博
//
//  Created by zerd on 14-10-18.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZD)

//修改自定义button 的图片
- (void)setCustomButtonImage:(NSString *)image forState:(UIControlState)state;

//初始化方法
- (id)initWithImage:(NSString *)imgString highlightedImage:(NSString *)highlightedImgString target:(id)target action:(SEL)action;

+ (id)itemWithImage:(NSString *)imgString highlightedImage:(NSString *)highlightedImgString target:(id)target action:(SEL)action;

@end
