//
//  BaseDetailController.m
//  tuan
//
//  Created by zerd on 15-1-10.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "BaseDetailController.h"
#import "CoverView.h"
#import "BaseNavigationController.h"
#import "DealDetailController.h"
#import "UIBarButtonItem+ZD.h"
#import "DealModel.h"
#import "Common.h"

#define kDetailWidth 550

@interface BaseDetailController ()

@end

@implementation BaseDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
