//
//  DropDownMenuItem.m
//  tuan
//
//  Created by zerd on 14-12-9.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "DropDownMenuItem.h"
#import "Common.h"

@implementation DropDownMenuItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1.右边分割线
        UIImage *img = [UIImage imageNamed:@"separator_filter_item.png"];
        UIImageView *separatorImage = [[UIImageView alloc]initWithImage:img];
        separatorImage.bounds = CGRectMake(0, 0, 2, kDropDownItemHeight * 0.7);
        separatorImage.center = CGPointMake(kDropDownItemWidth, kDropDownItemHeight * 0.5);
        [self addSubview:separatorImage];
        
        //文字颜色
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    frame.size.height = kDropDownItemHeight;
    frame.size.width = kDropDownItemWidth;
    [super setFrame:frame];
}


@end
