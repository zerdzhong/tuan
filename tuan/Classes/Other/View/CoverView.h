//
//  CoverView.h
//  tuan
//
//  Created by zerd on 14-12-19.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoverView : UIView

+ (instancetype)coverView;
+ (instancetype)coverViewWithTarget:(id)target action:(SEL)action;

- (void)resetAlpha;

@end
