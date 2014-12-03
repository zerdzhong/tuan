//
//  SlideBarItem.m
//  tuan
//
//  Created by zerd on 14-11-26.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "SlideBarBaseItem.h"
#import "Common.h"
#import "NSString+ZD.h"

@implementation SlideBarBaseItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _divider = [[UIImageView alloc]init];
        _divider.image = [UIImage imageNamed:@"separator_tabbar_item.png"];
        _divider.frame = CGRectMake(0, 0, kItemWidth, 2);
        [self addSubview:_divider];
    }
    return self;
}


#pragma mark- 重写setHighlighter 没有Highlighter状态
-(void)setHighlighted:(BOOL)highlighted{}

#pragma mark- 设置按钮图片
-(void)setIcon:(NSString *)icon{
    [self setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:[icon fileAppend:@"_hl"]] forState:UIControlStateDisabled];
}

#pragma mark- 重写setFrame 防止宽高被修改
-(void)setFrame:(CGRect)frame{
    frame.size = CGSizeMake(kItemWidth, kItemHeight);
    [super setFrame:frame];
}

@end
