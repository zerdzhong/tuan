//
//  DealPosAnnotation.h
//  tuan
//
//  Created by zerd on 15-1-9.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "DealModel.h"

@interface DealPosAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) DealModel *deal;
@property (nonatomic, copy) NSString *iconName;

@end
