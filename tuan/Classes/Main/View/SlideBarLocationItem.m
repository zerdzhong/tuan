//
//  SlideBarLocationItem.m
//  tuan
//
//  Created by zerd on 14-11-27.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "SlideBarLocationItem.h"
#import "CityListController.h"
#import "Common.h"
#import "MetaDataTool.h"
#import "LocationTool.h"
#import <CoreLocation/CoreLocation.h>

#define kImageScale 0.6

@interface SlideBarLocationItem () <UIPopoverControllerDelegate>

@property (nonatomic, strong) UIPopoverController *popover;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end

@implementation SlideBarLocationItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置自动伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        //设置默认文字
        [self setTitle:@"定位中" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        
        //设置图片的属性
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        //设置监听
        [self addTarget:self action:@selector(onLocationClicked) forControlEvents:UIControlEventTouchDown];
        
        // 6.监听城市改变的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChange) name:kCityChanged object:nil];
        //定位城市
        [self loadCity];
        
    }
    return self;
}

- (void)loadCity{
    //添加
    _indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [_indicator setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_indicator];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_indicator attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_indicator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:-10]];
    
    [_indicator startAnimating];
    
    [LocationTool sharedLocationTool];
}

- (void)cityChange
{
    CityModel *city = [MetaDataTool sharedMetaDataTool].currentCity;
    
    // 1.更改显示的城市名称
    [self setTitle:city.name forState:UIControlStateNormal];
    
    // 2.关闭popover（代码关闭popover不会触发代理方法）
    [_popover dismissPopoverAnimated:YES];
    
    // 3.变为enable
    self.enabled = YES;
    
    //移除 Indicator
    [_indicator removeFromSuperview];
    _indicator = nil;
    
    //设置图片
    [self setIcon:@"ic_district.png"];
    
}

- (void)screenRotate{
    
    if ([_popover isPopoverVisible]) {
        [_popover dismissPopoverAnimated:NO];
        
        [_popover presentPopoverFromRect:self.bounds
                                  inView:self
                permittedArrowDirections:UIPopoverArrowDirectionLeft
                                animated:YES];
    }
}

- (void)onLocationClicked{
    
    self.enabled = NO;
    
    CityListController *city = [[CityListController alloc]init];
    _popover = [[UIPopoverController alloc]initWithContentViewController:city];
    _popover.delegate = self;
    
    [_popover presentPopoverFromRect:self.bounds
                              inView:self
            permittedArrowDirections:UIPopoverArrowDirectionLeft
                            animated:YES];
    
    //监听屏幕旋转
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(screenRotate) name:UIDeviceOrientationDidChangeNotification object:nil];
    
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height*kImageScale);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, contentRect.size.height * kImageScale - 5, contentRect.size.width, contentRect.size.height * (1-kImageScale));
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    self.enabled = YES;
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
