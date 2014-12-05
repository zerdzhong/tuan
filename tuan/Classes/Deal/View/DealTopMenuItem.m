//
//  DealTopMenuItem.m
//  tuan
//
//  Created by zerd on 14-12-5.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "DealTopMenuItem.h"
#import "Common.h"

#define kTitleScale 0.8

@implementation DealTopMenuItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        //字体颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        //设置图片
        [self setImage:[UIImage imageNamed:@"ic_arrow_down.png"] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeCenter;
//        //右边分割线
//        UIImage *separateImage = [UIImage imageNamed:@"separator_filter_item.png"];
//        UIImageView *separate = [[UIImageView alloc]initWithImage:separateImage];
//        separate.bounds = CGRectMake(0, 0, separateImage.size.width, kTopMenuItemHeight * 0.7);
//        separate.center = CGPointMake(kTopMenuItemWidth, kTopMenuItemHeight * 0.5);
//        [self addSubview:separate];
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    [self setTitle:title forState:UIControlStateNormal];
}

-(void)setFrame:(CGRect)frame{
    frame.size = CGSizeMake(kTopMenuItemWidth, kTopMenuItemHeight);
    [super setFrame:frame];
}

#pragma mark- 改变内部位置
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat height = contentRect.size.height;
    CGFloat width = contentRect.size.width * kTitleScale;
    return CGRectMake(0, 0, width, height);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat height = contentRect.size.height;
    CGFloat x = contentRect.size.width * kTitleScale;
    CGFloat width = contentRect.size.width * (1- kTitleScale);
    return CGRectMake(x, 0, width, height);
}

@end
