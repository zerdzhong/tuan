//
//  OrderMenuItem.m
//  tuan
//
//  Created by zerd on 14-12-9.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "OrderMenuItem.h"

@implementation OrderMenuItem

-(void)setOrder:(OrderModel *)order{
    _order = order;
    [self setTitle:order.name forState:UIControlStateNormal];
}

@end
