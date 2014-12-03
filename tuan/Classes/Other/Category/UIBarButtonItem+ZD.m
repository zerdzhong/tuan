//
//  UIBarButtonItem+ZD.m
//  微博
//
//  Created by zerd on 14-10-18.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "UIBarButtonItem+ZD.h"

@implementation UIBarButtonItem (ZD)

- (id)initWithImage:(NSString *)imgString highlightedImage:(NSString *)highlightedImgString target:(id)target action:(SEL)action{

    //创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *img = [UIImage imageNamed:imgString];
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highlightedImgString] forState:UIControlStateHighlighted];
    
    //设置尺寸
    btn.bounds = (CGRect){CGPointZero,img.size};
    
    //设置响应事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [self initWithCustomView:btn];
}

+ (id)itemWithImage:(NSString *)imgString highlightedImage:(NSString *)highlightedImgString target:(id)target action:(SEL)action{
    return [[self alloc]initWithImage:imgString highlightedImage:highlightedImgString target:target action:action];
}

@end
