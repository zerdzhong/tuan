//
//  CategoryMenuItem.h
//  tuan
//
//  Created by zerd on 14-12-8.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"

@interface CategoryMenuItem : UIButton

@property (nonatomic, strong) CategoryModel *category;  //需要显示的数据Model

@end
