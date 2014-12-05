//
//  MTMainController.m
//  tuan
//
//  Created by zerd on 14-11-25.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "MainController.h"
#import "SlideBar.h"
#import "Common.h"

#import "DealListController.h"
#import "MapController.h"
#import "CollectController.h"
#import "MineController.h"
#import "BaseNavigationController.h"

@interface MainController ()<SliderBarDelegate>

//@property (nonatomic, strong)UIView *contentView;

@end

@implementation MainController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //添加侧边
    SlideBar *slideBar = [[SlideBar alloc]init];
    slideBar.frame = CGRectMake(0, 0, 0, self.view.frame.size.height);
    slideBar.delegate = self;
    [self.view addSubview:slideBar];
    
    //添加子控制器
    [self addAllChildController];
    
}

#pragma mark- 添加子控制器
- (void)addAllChildController{
    //团购
    DealListController *deal = [[DealListController alloc]init];
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:deal];
    [self addChildViewController:nav];

    //地图
    MapController *map = [[MapController alloc]init];
    map.view.backgroundColor = [UIColor blueColor];
    nav = [[BaseNavigationController alloc]initWithRootViewController:map];
    [self addChildViewController:nav];
    
    //收藏
    CollectController *collect = [[CollectController alloc]init];
    collect.view.backgroundColor = [UIColor grayColor];
    nav = [[BaseNavigationController alloc]initWithRootViewController:collect];
    [self addChildViewController:nav];
    
    //我的
    MineController *mine = [[MineController alloc]init];
    mine.view.backgroundColor = [UIColor blackColor];
    nav = [[BaseNavigationController alloc]initWithRootViewController:mine];
    [self addChildViewController:nav];
    
    
    //默认选中团购
    [self slideBarItem:nil tabFrom:0 to:0];
}

#pragma mark- SlideBarDelegate
-(void)slideBarItem:(SlideBar *)slideBar tabFrom:(int)from to:(int)to{
    
    //移除旧控制器
    UIViewController *oldViewController = self.childViewControllers[from];
    [oldViewController.view removeFromSuperview];
    
    //添加新的
    UIViewController *newViewController = self.childViewControllers[to];
    newViewController.view.frame = CGRectMake(kItemWidth, 0,self.view.frame.size.width - kItemWidth, self.view.frame.size.height);
    newViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:newViewController.view];
    
    
}

@end
