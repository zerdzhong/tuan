//
//  MetaDataTool.h
//  tuan
//
//  Created by zerd on 14-12-3.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  管理项目的元数据类 团购城市，团购城市分区，团购分类

#import <Foundation/Foundation.h>
#import "CityModel.h"
#import "Singleton.h"

@interface MetaDataTool : NSObject

singleton_interface(MetaDataTool)

@property (nonatomic, strong, readonly) NSDictionary *totalCities;       // 存放所有的城市 key 是城市名  value 是城市对象
@property (nonatomic, strong, readonly) NSArray *totalCitySections;     //所有城市分组数据

@property (nonatomic, strong) CityModel *currentCity;     //当前城市

@property (nonatomic, strong, readonly) NSArray *totalCategories;    //所有分类
@property (nonatomic, strong, readonly) NSArray *totalOrders;

@end
