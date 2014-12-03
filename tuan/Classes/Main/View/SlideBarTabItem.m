//
//  SlideBarTabItem.m
//  tuan
//
//  Created by zerd on 14-11-27.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  标签

#import "SlideBarTabItem.h"

@implementation SlideBarTabItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"bg_tabbar_item.png"] forState:UIControlStateDisabled];
    }
    return self;
}

-(void)setEnabled:(BOOL)enabled{
    //控制顶部分割线是否需要显示

    [self.divider setHidden:!enabled];
    
    [super setEnabled:enabled];
}

@end
