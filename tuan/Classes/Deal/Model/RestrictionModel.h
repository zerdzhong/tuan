//
//  RestrictionsModel.h
//  tuan
//
//  Created by zerd on 14-12-27.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  一个团购的约束条件

#import <Foundation/Foundation.h>

@interface RestrictionModel : NSObject

@property (nonatomic, assign) BOOL is_reservation_required;  //是否需要预约，0：不是，1：是
@property (nonatomic, assign) BOOL is_refundable;            //是否支持随时退款，0：不是，1：是
@property (nonatomic, copy) NSString *special_tips;         //附加信息(一般为团购信息的特别提示)

@end
