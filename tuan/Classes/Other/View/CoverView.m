//
//  CoverView.m
//  tuan
//
//  Created by zerd on 14-12-19.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "CoverView.h"

#define KAlpha 0.6

@implementation CoverView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置背景色
        self.backgroundColor = [UIColor blackColor];
        //设置透明度
        self.alpha = KAlpha;
        //设置自动伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

+ (instancetype)coverView{
    return [[self alloc]init];
}

+ (instancetype)coverViewWithTarget:(id)target action:(SEL)action{
    CoverView *cover = [CoverView coverView];
    [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:action]];
    return cover;
}

- (void)resetAlpha{
    self.alpha = KAlpha;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
