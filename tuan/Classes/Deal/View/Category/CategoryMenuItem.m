//
//  CategoryMenuItem.m
//  tuan
//
//  Created by zerd on 14-12-8.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "CategoryMenuItem.h"
#import "Common.h"

#define kImageScale 0.6

@implementation CategoryMenuItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)setCategory:(CategoryModel *)category{
    _category = category;
    //设置文字 图标
    [self setImage:[UIImage imageNamed:category.icon] forState:UIControlStateNormal];
    [self setTitle:category.name forState:UIControlStateNormal];
    self.titleLabel.textColor = [UIColor whiteColor];
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleHeight = contentRect.size.height *(1 - kImageScale);
    CGFloat titleY = contentRect.size.height - titleHeight;
    return CGRectMake(0, titleY, contentRect.size.width, titleHeight);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * kImageScale);
}

@end
