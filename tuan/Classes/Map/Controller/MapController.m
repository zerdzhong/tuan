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
#import "CoverView.h"
#import "Common.h"
#import "DealDetailController.h"
#import "BaseNavigationController.h"
#import "UIBarButtonItem+ZD.h"

#define kDetailWidth 550

@interface MapController () <MKMapViewDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManage;
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) NSMutableArray *showingBusinesses;

@property (nonatomic, strong) CoverView *cover;

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
    if (_mapView == mapView) {
        return;
    }
//    [mapView setCenterCoordinate:userLocation.coordinate animated:YES];
    MKCoordinateSpan span = MKCoordinateSpanMake(0.02, 0.03);
    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.coordinate, span);
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
        DealPosAnnotation *dealAnnotation = view.annotation;
        MyLog(@"%@",dealAnnotation.deal.title);
        [self showDealDetailController:dealAnnotation.deal];
        [mapView deselectAnnotation:view.annotation animated:NO];
    }
}

#pragma mark- 显示/隐藏详情控制器

- (void)showDealDetailController:(DealModel *)deal{
    
    //1.显示遮盖
    if (_cover == nil) {
        _cover = [CoverView coverViewWithTarget:self action:@selector(hideDealDetailController)];
    }
    _cover.frame = self.navigationController.view.bounds;
    _cover.alpha = 0;
    [UIView animateWithDuration:kAnimationDuration animations:^{
        [_cover resetAlpha];
    }];
    [self.navigationController.view addSubview:_cover];
    
    //显示团购详情控制器
    DealDetailController *detailController= [[DealDetailController alloc]init];
    //添加关闭BarButtonItem
    detailController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"btn_nav_close.png" highlightedImage:@"btn_nav_close_hl.png" target:self action:@selector(hideDealDetailController)];
    //初始化NavgationController
    BaseNavigationController *detailNavController = [[BaseNavigationController alloc]
                                                     initWithRootViewController:detailController];
    detailNavController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleLeftMargin;
    //设置宽高
    detailNavController.view.frame = CGRectMake(_cover.frame.size.width, 0, kDetailWidth, _cover.frame.size.height);
    [self.navigationController.view addSubview:detailNavController.view];
    [self.navigationController addChildViewController:detailNavController];
    
    detailController.deal = deal;
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        CGRect frame = detailNavController.view.frame;
        frame.origin.x -= kDetailWidth;
        detailNavController.view.frame = frame;
    }];
    
}

- (void)hideDealDetailController{
    UIViewController *nav = [self.navigationController.childViewControllers lastObject];
    //隐藏
    [UIView animateWithDuration:kAnimationDuration animations:^{
        //隐藏遮盖
        _cover.alpha = 0;
        //隐藏详情
        CGRect frame = nav.view.frame;
        frame.origin.x += kDetailWidth;
        nav.view.frame = frame;
    } completion:^(BOOL finished) {
        [_cover removeFromSuperview];
        [nav.view removeFromSuperview];
        [nav removeFromParentViewController];
        //        _detailNavController.view = nil;
    }];
}

@end
