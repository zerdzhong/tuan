//
//  UIBarButtonItem+ZD.h
//  微博
//
//  Created by zerd on 14-10-18.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZD)

- (id)initWithImage:(NSString *)imgString highlightedImage:(NSString *)highlightedImgString target:(id)target action:(SEL)action;

+ (id)itemWithImage:(NSString *)imgString highlightedImage:(NSString *)highlightedImgString target:(id)target action:(SEL)action;

@end
