//
//  SlideBar.h
//  tuan
//
//  Created by zerd on 14-11-26.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SlideBar;

@protocol SliderBarDelegate <NSObject>

@optional
- (void)slideBarItem:(SlideBar *)slideBar tabFrom:(int)from to:(int)to;

@end

@interface SlideBar : UIView

@property (nonatomic, assign)id<SliderBarDelegate> delegate;

@end
