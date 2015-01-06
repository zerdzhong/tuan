//
//  MapViewController.m
//  tuan
//
//  Created by zerd on 14-11-28.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "MapController.h"
#import <MapKit/MapKit.h>

@interface MapController () <MKMapViewDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManage;

@end


@implementation MapController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"地图";
    
    //添加 MapView
    MKMapView *mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    mapView.delegate = self;
    mapView.showsUserLocation = YES;
    [self.view addSubview:mapView];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    if([CLLocationManager locationServicesEnabled]){
        self.locationManage = [[CLLocationManager alloc] init];
        self.locationManage.delegate = self;
        self.locationManage.distanceFilter = 200;
        self.locationManage.desiredAccuracy = kCLLocationAccuracyBestForNavigation;//kCLLocationAccuracyBest;
        if ([self.locationManage respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            //使用期间
//            [self.locationManage requestWhenInUseAuthorization];
            //始终
            [self.locationManage requestAlwaysAuthorization];
        }
    }
    [self.locationManage startUpdatingLocation];
}

#pragma mark- MapViewDelegate
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
//    [mapView setCenterCoordinate:userLocation.coordinate animated:YES];
    MKCoordinateSpan span = MKCoordinateSpanMake(0.02, 0.03);
    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.coordinate, span);
    [mapView setRegion:region animated:YES];
}

@end
