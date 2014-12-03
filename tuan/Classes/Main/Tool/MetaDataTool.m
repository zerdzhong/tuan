//
//  MetaDataTool.m
//  tuan
//
//  Created by zerd on 14-12-3.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "MetaDataTool.h"
#import "CitySection.h"
#import "NSObject+Value.h"

@implementation MetaDataTool

singleton_implementation(MetaDataTool)

-(instancetype)init{
    if (self = [super init]) {
        //加载plist数据
        NSArray *cityArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Cities" ofType:@"plist"]];
        //转换成Model
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (NSDictionary *dict in cityArray) {
            CitySection *section = [[CitySection alloc]init];
            [section setValues:dict];
            [array addObject:section];
        }
        _totalCitySections = array;
    }
    
    return self;
}

@end
