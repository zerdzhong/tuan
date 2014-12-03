//
//  MetaDataTool.h
//  tuan
//
//  Created by zerd on 14-12-3.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  管理项目的元数据类 团购城市，团购城市分区，团购分类

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface MetaDataTool : NSObject

singleton_interface(MetaDataTool)

@property (nonatomic, strong, readonly)NSArray *totalCitySections;

@end
