//
//  DistrictMenuItem.m
//  tuan
//
//  Created by zerd on 14-12-9.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "DistrictMenuItem.h"

@implementation DistrictMenuItem

-(void)setDistrict:(DistrictMode *)district{
    _district = district;
    [self setTitle:district.name forState:UIControlStateNormal];
}

-(NSArray *)titles{
    return _district.neighborhoods;
}

@end
