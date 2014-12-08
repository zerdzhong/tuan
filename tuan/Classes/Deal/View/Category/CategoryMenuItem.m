//
//  CategoryMenuItem.m
//  tuan
//
//  Created by zerd on 14-12-8.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "CategoryMenuItem.h"
#import "Common.h"

@implementation CategoryMenuItem

-(void)setFrame:(CGRect)frame{
    frame.size.height = kDropDownItemHeight;
    frame.size.width = kDropDownItemWidth;
    [super setFrame:frame];
}

-(void)setCategory:(CategoryModel *)category{
    _category = category;
    //设置文字 图标
    [self setImage:[UIImage imageNamed:category.icon] forState:UIControlStateNormal];
    [self setTitle:category.name forState:UIControlStateNormal];
    self.titleLabel.textColor = [UIColor whiteColor];
}

@end
