//
//  DropDownMenu.m
//  tuan
//
//  Created by zerd on 14-12-8.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "DropDownMenu.h"
#import "Common.h"

#define kDuration 0.4
#define kCoverAlpha 0.4

@interface DropDownMenu ()

@property (nonatomic, strong) UIView *cover;

@end

@implementation DropDownMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        //添加蒙板
        UIView *cover = [[UIView alloc]init];
        cover.alpha = kCoverAlpha ;
        cover.frame = self.bounds;
        cover.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        cover.backgroundColor = [UIColor blackColor];
        
        [cover addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(hideWithAnimation)]
         ];
        
        [self addSubview:cover];
        _cover = cover;
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

#pragma mark- 通过动画显示出来
- (void)showWithAnimation{

    _scrollView.transform = CGAffineTransformMakeTranslation(0, -kDropDownItemHeight);
    _cover.alpha = 0;
    [UIView animateWithDuration:kDuration animations:^{
        //1.scrollview 从上方出现
        _scrollView.transform = CGAffineTransformIdentity;
        //2.cover alpha 0 -> 0.4
        _cover.alpha = kCoverAlpha;
    }];
    

}
#pragma mark- 通过动画隐藏出来
- (void)hideWithAnimation{
    [UIView animateWithDuration:kDuration animations:^{
        //1.scrollview 缩到上方
        _scrollView.transform = CGAffineTransformMakeTranslation(0, -kDropDownItemHeight);
        //2.cover alpha 0.4 -> 0
        _cover.alpha = 0;
    } completion:^(BOOL finished) {
        //重置属性
        _scrollView.transform = CGAffineTransformIdentity;
        _cover.alpha = kCoverAlpha;
        //从父控件移除
        [self removeFromSuperview];
        if (_hiddenBlock != nil) {
            _hiddenBlock();
        }
    }];
}

@end
