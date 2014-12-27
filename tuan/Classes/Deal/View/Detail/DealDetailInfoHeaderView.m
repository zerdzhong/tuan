//
//  DealDetailInfoHeaderView.m
//  tuan
//
//  Created by zerd on 14-12-27.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "DealDetailInfoHeaderView.h"
#import "UIImage+ZD.h"

@implementation DealDetailInfoHeaderView

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [[UIImage resizedImage:@"bg_order_cell.png"]drawInRect:rect];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
