//
//  CenterLineLable.m
//  tuan
//
//  Created by zerd on 14-12-21.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "CenterLineLable.h"

@implementation CenterLineLable

#pragma mark- 在label上划线
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    //1.获得上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //2.设置颜色
    [self.textColor set];
    //划线
    CGFloat y = (rect.size.height * 0.5) + rect.origin.y;
    CGContextMoveToPoint(context, 0, y);
    CGContextAddLineToPoint(context, rect.size.width, y);
    //渲染
    CGContextStrokePath(context);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
