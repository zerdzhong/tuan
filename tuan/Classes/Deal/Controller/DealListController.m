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
#import "MetaDataTool.h"
#import "DealModel.h"
#import "DealCollectionCell.h"
#import "DianpingDealTool.h"
#import "MJRefresh.h"
#import "ImageTool.h"
#import "CoverView.h"
#import "DealDetailController.h"
#import "BaseNavigationController.h"
#import "UIBarButtonItem+ZD.h"

#define kCellHeight 250
#define kCellWidth 250

#define kDetailWidth 550

@interface DealListController () <UIGestureRecognizerDelegate>

@property (nonatomic, assign) int page;
@property (nonatomic, strong) UISearchBar *searchBar;

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
    _collectionView.backgroundColor = kGlobalBgColor;
    
    //添加右边搜索框
    UISearchBar *searchBar = [[UISearchBar alloc]init];
    searchBar.frame = CGRectMake(0, 0, 210, 40);
    searchBar.barStyle = UIBarStyleBlack;
    searchBar.placeholder = @"请输入商品名、商铺等";
    self.searchBar = searchBar;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:searchBar];
    
    //添加左边的菜单栏
    DealTopMenu *topMenu = [[DealTopMenu alloc]init];
    topMenu.contentView = self.view;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:topMenu];
    
    //刷新控件
    [self addMJRefresh];
    
//    [self setUpForDismissKeyboard];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAnywhereToDismissKeyboard:)];
    tapGes.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGes];
}

#pragma mark- Keyboard

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
    [self.searchBar resignFirstResponder];
}


#pragma mark- 上下拉刷新

- (void)addMJRefresh{
    
    [_collectionView addHeaderWithTarget:self action:@selector(onHeaderRefresh)];
    
    [_collectionView addFooterWithTarget:self action:@selector(onFooterRefresh)];
    
}

- (void)onHeaderRefresh{
    //下拉刷新
    _page = 1;
    [[DianpingDealTool sharedDianpingDealTool] dealsWithPage:_page success:^(NSArray *deals, int totalCount) {
        //清除之前缓存
        [ImageTool clearMemory];
        //清除之前的deal
        _dealArray = [NSMutableArray array];
        
        [_dealArray addObjectsFromArray:deals];
        //刷新数据
        [_collectionView reloadData];
        //停止刷新
        [_collectionView headerEndRefreshing];
        //根据数量判断是否隐藏footer
        _collectionView.footerHidden = totalCount <= [_dealArray count];
    } failure:^(NSError *error) {
        //停止刷新
        [_collectionView headerEndRefreshing];
    }];
}

- (void)onFooterRefresh{
    //上拉加载
    _page++;
    
    [[DianpingDealTool sharedDianpingDealTool] dealsWithPage:_page success:^(NSArray *deals, int totalCount) {
        [_dealArray addObjectsFromArray:deals];
        //刷新数据
        [_collectionView reloadData];
        //停止刷新
        [_collectionView footerEndRefreshing];
        
        //根据数量判断是否隐藏footer
        _collectionView.footerHidden = totalCount <= [_dealArray count];
    } failure:^(NSError *error) {
        //停止刷新
        [_collectionView footerEndRefreshing];
    }];
}

#pragma mark- notification
- (void)dataChange{
    [_collectionView headerBeginRefreshing];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
