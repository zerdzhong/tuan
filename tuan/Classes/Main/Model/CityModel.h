//
//  CityModel.h
//  tuan
//
//  Created by zerd on 14-12-3.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityBaseModel.h"

@interface CityModel : CityBaseModel

@property (nonatomic, strong) NSArray *districts;    //分区
@property (nonatomic, assign) BOOL hot;

@end
