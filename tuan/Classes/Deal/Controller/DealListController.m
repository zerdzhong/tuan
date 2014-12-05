//
//  DealListViewController.m
//  tuan
//
//  Created by zerd on 14-11-28.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "DealListController.h"
#import "DealTopMenu.h"
#import "Common.h"

@implementation DealListController

-(void)viewDidLoad{
    [super viewDidLoad];

    // 1.监听城市改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChange) name:kCityChanged object:nil];
    
    //设置背景色
    self.view.backgroundColor = kGlobalBgColor;
    
    //添加右边搜索框
    UISearchBar *searchBar = [[UISearchBar alloc]init];
    searchBar.frame = CGRectMake(0, 0, 210, 40);
    searchBar.barStyle = UIBarStyleBlack;
    searchBar.placeholder = @"请输入商品名、商铺等";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:searchBar];
    
    //添加左边的菜单栏
    DealTopMenu *topMenu = [[DealTopMenu alloc]init];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:topMenu];
    
}

- (void)cityChange
{
    MyLog(@"TGDealListController监听到城市改变了");
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
