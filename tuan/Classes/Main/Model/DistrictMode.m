//
//  DistrictMode.m
//  tuan
//
//  Created by zerd on 14-12-3.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "DistrictMode.h"
#import "CityBaseModel.h"
#import "NSObject+Value.h"

@implementation DistrictMode

-(void)setNeighbohoods:(NSArray *)neighbohoods{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in neighbohoods) {
        NSString *neighbohood = [[NSString alloc]init];
        [neighbohood setValues:dict];
        [array addObject:neighbohood];
    }
    
    _neighbohoods = array;
}

@end
