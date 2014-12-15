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
#import "DPAPI.h"
#import "MetaDataTool.h"
#import "DealModel.h"
#import "NSObject+Value.h"

@interface DealListController ()<DPRequestDelegate>

@property (nonatomic, strong) NSMutableArray *dealArray;

@end

@implementation DealListController

-(void)viewDidLoad{
    [super viewDidLoad];

    // 1.监听城市改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dataChange)
                                                 name:kCityChanged
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dataChange)
                                                 name:KCategoryChanged
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dataChange)
                                                 name:KDistrictChanged
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dataChange)
                                                 name:KOrderChanged
                                               object:nil];
    
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
    topMenu.contentView = self.view;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:topMenu];
    
}

#pragma mark- notification
- (void)dataChange{
    
    DPAPI *api = [[DPAPI alloc]init];
    
    [api requestWithURL:@"v1/deal/find_deals"
                 params:@{@"city":[MetaDataTool sharedMetaDataTool].currentCity.name}
               delegate:self];
    
}

#pragma mark- 点评delegate

-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    NSArray *array = result[@"deals"];
    
    _dealArray = [[NSMutableArray alloc]init];
    for (NSDictionary *deal in array) {
        DealModel *dealModel = [[DealModel alloc]init];
        [dealModel setValues:deal];
        [_dealArray addObject:dealModel];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
