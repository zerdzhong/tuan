//
//  DropDownMenu.m
//  tuan
//
//  Created by zerd on 14-12-8.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "DropDownMenu.h"
#import "CategoryMenuItem.h"
#import "DistrictMenuItem.h"
#import "OrderMenuItem.h"
#import "Common.h"

#define kDuration 0.4
#define kCoverAlpha 0.4

@interface DropDownMenu ()

@property (nonatomic, strong) UIView *cover;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) DropDownMenuItem *selectedItem;

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
        
        //内容view
        _contentView = [[UIView alloc]init];
        _contentView.frame = CGRectMake(0, 64, self.frame.size.width, kDropDownItemHeight);
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_contentView];
        
        //添加scroolview
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.frame = CGRectMake(0, 0, self.frame.size.width, kDropDownItemHeight);
        [_contentView  addSubview:scrollView];
        _scrollView = scrollView;
    }
    return self;
}

#pragma mark- 通过动画显示出来
- (void)showWithAnimation{

    _contentView.transform = CGAffineTransformMakeTranslation(0, -_contentView.frame.size.height);
    _contentView.alpha = 0;
    _cover.alpha = 0;
    [UIView animateWithDuration:kDuration animations:^{
        //1.scrollview 从上方出现
        _contentView.transform = CGAffineTransformIdentity;
        _contentView.alpha = 1;
        //2.cover alpha 0 -> 0.4
        _cover.alpha = kCoverAlpha;
    }];
    

}
#pragma mark- 通过动画隐藏出来
- (void)hideWithAnimation{
    [UIView animateWithDuration:kDuration animations:^{
        //1.scrollview 缩到上方
        _contentView.transform = CGAffineTransformMakeTranslation(0, -_contentView.frame.size.height);
        _contentView.alpha = 0;
        //2.cover alpha 0.4 -> 0
        _cover.alpha = 0;
    } completion:^(BOOL finished) {
        //重置属性
        _contentView.transform = CGAffineTransformIdentity;
        _contentView.alpha = 1;
        _cover.alpha = kCoverAlpha;
        //从父控件移除
        [self removeFromSuperview];
        if (_hiddenBlock != nil) {
            _hiddenBlock();
        }
    }];
}

#pragma mark- 菜单项点击事件处理 分类，商区，排序item点击事件
- (void)onItemClicked:(DropDownMenuItem *)item{
    
    //控制item状态
    _selectedItem.selected = NO;
    _selectedItem = item;
    _selectedItem.selected = YES;

    
    //判断当前item有没有子类别
    if (item.titles.count){
        [self showSubtitlesView:item.titles];
    }else{
        //隐藏子标题
        [self hideSubtitlesView];
    }
}

#pragma mark- 隐藏子标题
- (void)hideSubtitlesView{
    [_subTitleView hideWithAnimation];
    CGRect frame = _contentView.frame;
    frame.size.height = kDropDownItemHeight;
    _contentView.frame = frame;
}

#pragma mark- 显示子标题
- (void)showSubtitlesView:(NSArray *)titles{
    //显示所有子标题
    if (_subTitleView == nil) {
        _subTitleView = [[DropDownSubTitle alloc]init];
    }
    
    CGFloat y = self.scrollView.frame.origin.y + kDropDownItemHeight;
    _subTitleView.frame = CGRectMake(0, y, self.frame.size.width, _subTitleView.frame.size.height);
    
    _subTitleView.titles = titles ;
    
    if (_subTitleView.superview == nil){
        //执行动画
        [_subTitleView showWithAnimation];
    }
    
    [_contentView insertSubview:_subTitleView belowSubview:self.scrollView];
    
    CGRect frame = _contentView.frame;
    frame.size.height = kDropDownItemHeight + _subTitleView.frame.size.height;
    _contentView.frame = frame;
}

@end
