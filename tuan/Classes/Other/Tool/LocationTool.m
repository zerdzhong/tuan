//
//  LocationTool.m
//  tuan
//
//  Created by zerd on 15-1-11.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "LocationTool.h"
#import "Common.h"
#import "MetaDataTool.h"

@interface LocationTool () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManage;
@property (nonatomic, strong) CLGeocoder *geo;

@end

@implementation LocationTool

singleton_implementation(LocationTool)

- (instancetype)init
{
    self = [super init];
    if (self) {
        _geo = [[CLGeocoder alloc]init];
        self.locationManage = [[CLLocationManager alloc] init];
        self.locationManage.delegate = self;
        self.locationManage.distanceFilter = 200;
        self.locationManage.desiredAccuracy = kCLLocationAccuracyBestForNavigation;//kCLLocationAccuracyBest;
        
        if([CLLocationManager locationServicesEnabled]){
            if ([self.locationManage respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                //使用期间
                //            [self.locationManage requestWhenInUseAuthorization];
                //始终
                [self.locationManage requestAlwaysAuthorization];
            }
        }
        [self.locationManage startUpdatingLocation];
    }
    return self;
}

#pragma mark- CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = locations[0];
    [_geo reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *place = placemarks[0];
        if ([place.addressDictionary[@"State"] containsString:@"市"]) {
            NSString *name = place.addressDictionary[@"State"];
            CityModel *city = [MetaDataTool sharedMetaDataTool].totalCities[[name substringToIndex:name.length - 1]];
            [MetaDataTool sharedMetaDataTool].currentCity = city;
        }else if ([place.addressDictionary[@"City"] containsString:@"市"]){
            NSString *name = place.addressDictionary[@"City"];
            CityModel *city = [MetaDataTool sharedMetaDataTool].totalCities[[name substringToIndex:name.length - 1]];
            [MetaDataTool sharedMetaDataTool].currentCity = city;
        }
    }];
}

@end
