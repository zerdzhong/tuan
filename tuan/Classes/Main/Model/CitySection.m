//
//  CitySection.m
//  tuan
//
//  Created by zerd on 14-12-3.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "CitySection.h"
#import "CityModel.h"
#import "NSObject+Value.h"

@implementation CitySection


-(void)setCities:(NSMutableArray *)cities{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in cities) {
        if (![dict isKindOfClass:[NSMutableDictionary class]]) {
            //cities是模型
            _cities = cities;
            return;
        }
        CityModel *city = [[CityModel alloc]init];
        [city setValues:dict];
        [array addObject:city];
    }
    
    _cities = array;
}

@end
