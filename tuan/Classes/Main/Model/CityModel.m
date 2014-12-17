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
#import "Common.h"

@implementation CityModel

-(void)setDistricts:(NSArray *)districts{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    //添加全部商区
    DistrictMode *all = [[DistrictMode alloc]init];
    all.name = kAllDistrict;
    [array addObject:all];
    
    for (NSDictionary *dict in districts) {
        DistrictMode *district = [[DistrictMode alloc]init];
        [district setValues:dict];
        [array addObject:district];
    }
    
    _districts = array;
}

@end
