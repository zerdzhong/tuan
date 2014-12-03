//
//  CityModel.m
//  tuan
//
//  Created by zerd on 14-12-3.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "CityModel.h"
#import "NSObject+Value.h"
#import "DistrictMode.h"

@implementation CityModel

-(void)setDistricts:(NSArray *)districts{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in districts) {
        DistrictMode *district = [[DistrictMode alloc]init];
        [district setValues:dict];
        [array addObject:district];
    }
    
    _districts = array;
}

@end
