//
//  DropDownMenu.m
//  tuan
//
//  Created by zerd on 14-12-8.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "DropDownMenu.h"
#import "Common.h"

@implementation DropDownMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        //添加蒙板
        UIView *cover = [[UIView alloc]init];
        cover.alpha = 0.7;
        cover.frame = self.bounds;
        cover.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        cover.backgroundColor = [UIColor blackColor];
        [self addSubview:cover];
        //添加scroolview
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.frame = CGRectMake(0, 64, self.frame.size.width, kDropDownItemHeight);
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
    return self;
}

@end
