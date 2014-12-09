//
//  OrderMenuItem.h
//  tuan
//
//  Created by zerd on 14-12-9.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "DropDownMenuItem.h"
#import "OrderModel.h"

@interface OrderMenuItem : DropDownMenuItem

@property (nonatomic, strong) OrderModel *order;

@end
