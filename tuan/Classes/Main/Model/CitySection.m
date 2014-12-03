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


-(void)setCities:(NSArray *)cities{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in cities) {
        CityModel *city = [[CityModel alloc]init];
        [city setValues:dict];
        [array addObject:city];
    }
    
    _cities = array;
}

@end
