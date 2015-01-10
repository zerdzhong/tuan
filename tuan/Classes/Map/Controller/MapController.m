//
//  MapViewController.m
//  tuan
//
//  Created by zerd on 14-11-28.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "MapController.h"
#import <MapKit/MapKit.h>
#import "DianpingDealTool.h"
#import "DealPosAnnotation.h"
#import "DealModel.h"
#import "Common.h"
#import <QuartzCore/QuartzCore.h>

#define kSpan MKCoordinateSpanMake(0.02, 0.03)

@interface MapController () <MKMapViewDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManage;
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) NSMutableArray *showingBusinesses;


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
    
    _showingBusinesses = [NSMutableArray array];
    
    //回到用户位置的按钮
    UIButton *locateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [locateButton setImage:[UIImage imageNamed:@"btn_map_locate.png"] forState:UIControlStateNormal];
    [locateButton setImage:[UIImage imageNamed:@"btn_map_locate_hl.png"] forState:UIControlStateHighlighted];
    [locateButton addTarget:self action:@selector(onLocateClicked) forControlEvents:UIControlEventTouchUpInside];
    [locateButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:locateButton];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:locateButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-12]];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:locateButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-8]];
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


#pragma mark- 回到用户位置
- (void)onLocateClicked{
    CLLocationCoordinate2D userCoor = _mapView.userLocation.coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMake(userCoor, kSpan);
    [_mapView setRegion:region animated:YES];
}

#pragma mark- MapViewDelegate
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    if (_mapView == mapView) {
        return;
    }
//    [mapView setCenterCoordinate:userLocation.coordinate animated:YES];
    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.coordinate, kSpan);
    [mapView setRegion:region animated:YES];
    
    _mapView = mapView;
}

#pragma mark- 地图显示区域改变回调
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    //1.地图当前中心点
    CLLocationCoordinate2D center = mapView.region.center;
    
    [[DianpingDealTool sharedDianpingDealTool]dealWithCoordinate:center success:^(NSArray *deals, int totalCount) {
        for (DealModel *deal in deals) {
            for (DealBusinessModel *business in deal.businesses) {
                
                //已经显示过的就不用显示了
                if ([_showingBusinesses containsObject:@(business.ID)]) {
                    break;
                }
                
                if (business.latitude == nil) {
                    continue;
                }
                DealPosAnnotation *anna = [[DealPosAnnotation alloc]init];
                anna.coordinate = CLLocationCoordinate2DMake([business.latitude doubleValue], [business.longitude doubleValue]);
                anna.deal = deal;
                [mapView addAnnotation:anna];
                
                [_showingBusinesses addObject:@(business.ID)];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark- 大头针显示代理
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[DealPosAnnotation class]]) {
        static NSString *iden = @"DealMap";
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:iden];
        
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:iden];
        }
        
        //设置大头针
        annotationView.annotation = annotation;
        if ([annotation isKindOfClass:[DealPosAnnotation class]]) {
            DealPosAnnotation *dealAnno = (DealPosAnnotation *)annotation;
            annotationView.image = [UIImage imageNamed:dealAnno.iconName];
        }else{
            annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:iden];
        }
        
        return annotationView;
    }
    return nil;
}

#pragma mark- 大头针点击回调
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    if ([view.annotation isKindOfClass:[DealPosAnnotation class]]) {
        //展示详情
        DealPosAnnotation *dealAnnotation = view.annotation;
        [self showDealDetailController:dealAnnotation.deal];
        [mapView deselectAnnotation:view.annotation animated:NO];
        //让所选成为地图中心
        
        [mapView setCenterCoordinate:dealAnnotation.coordinate animated:YES];
        //添加所选大头针阴影
        view.layer.shadowColor = [UIColor blueColor].CGColor;
        view.layer.shadowOpacity = 1;
        view.layer.shadowRadius = 8;
    }
}

@end
