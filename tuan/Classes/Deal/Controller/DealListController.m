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

@interface DealListController ()

@property (nonatomic, strong) NSMutableArray *dealArray;
@property (nonatomic, assign) int page;

@property (nonatomic, strong) CoverView *cover;
@property (nonatomic, strong) BaseNavigationController *detailNavController;
@property (nonatomic, strong) DealDetailController *detailController;

@end

@implementation DealListController

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kCellWidth, kCellHeight); //大小
    layout.minimumLineSpacing = 20;         //行间距
    return [super initWithCollectionViewLayout:layout];
}

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
    self.collectionView.backgroundColor = kGlobalBgColor;
    
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
    
    //注册cell的xib
    [self.collectionView registerNib:[UINib nibWithNibName:@"DealCollectionCell"
                                                    bundle:nil]
          forCellWithReuseIdentifier:@"dealCell"];
    
    //设置collectionview永远支持垂直滚动(数据不足时，默认不能滚动)
    self.collectionView.alwaysBounceVertical = YES;
    
    //刷新控件
    [self addMJRefresh];
    
    //test 为了设置默认城市 以后加了定位之后再去掉
    [MetaDataTool sharedMetaDataTool];
    
}

#pragma mark- 上下拉刷新

- (void)addMJRefresh{
    
    [self.collectionView addHeaderWithTarget:self action:@selector(onHeaderRefresh)];
    
    [self.collectionView addFooterWithTarget:self action:@selector(onFooterRefresh)];
    
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
        [self.collectionView reloadData];
        //停止刷新
        [self.collectionView headerEndRefreshing];
        //根据数量判断是否隐藏footer
        self.collectionView.footerHidden = totalCount <= [_dealArray count];
    } failure:^(NSError *error) {
        //停止刷新
        [self.collectionView headerEndRefreshing];
    }];
}

- (void)onFooterRefresh{
    //上拉加载
    _page++;
    
    [[DianpingDealTool sharedDianpingDealTool] dealsWithPage:_page success:^(NSArray *deals, int totalCount) {
        [_dealArray addObjectsFromArray:deals];
        //刷新数据
        [self.collectionView reloadData];
        //停止刷新
        [self.collectionView footerEndRefreshing];
        
        //根据数量判断是否隐藏footer
        self.collectionView.footerHidden = totalCount <= [_dealArray count];
    } failure:^(NSError *error) {
        //停止刷新
        [self.collectionView footerEndRefreshing];
    }];
}

#pragma mark- notification
- (void)dataChange{
    [self.collectionView headerBeginRefreshing];
}

#pragma mark- 屏幕旋转处理
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    CGFloat vSpace = 20;
    CGFloat hSpece = 0;
    
    //控制器的宽度
    CGFloat width = size.width - kItemWidth;
    
    if (size.width >768 ) {
        //横屏
        hSpece = (width - 3 * kCellWidth) / 4;
    }else{
        //竖屏
        hSpece = (width - 2 * kCellWidth) / 3;
    }
    
    layout.sectionInset = UIEdgeInsetsMake(vSpace, hSpece, vSpace, hSpece);
}

- (void)viewWillAppear:(BOOL)animated{
    //计算默认间距
    CGSize size = [UIScreen mainScreen].bounds.size;
    [self viewWillTransitionToSize:size withTransitionCoordinator:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    if (_detailNavController == nil) {
        _detailController= [[DealDetailController alloc]init];
        //添加关闭BarButtonItem
        _detailController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"btn_nav_close.png" highlightedImage:@"btn_nav_close_hl.png" target:self action:@selector(hideDealDetailController)];
        //初始化NavgationController
        _detailNavController = [[BaseNavigationController alloc]
                             initWithRootViewController:_detailController];
        _detailNavController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleLeftMargin;
    }
    //设置宽高
    _detailNavController.view.frame = CGRectMake(_cover.frame.size.width, 0, kDetailWidth, _cover.frame.size.height);
    [self.navigationController.view addSubview:_detailNavController.view];
    [self.navigationController addChildViewController:_detailNavController];
    
    _detailController.deal = deal;
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        CGRect frame = _detailNavController.view.frame;
        frame.origin.x -= kDetailWidth;
        _detailNavController.view.frame = frame;
    }];
    
}

- (void)hideDealDetailController{
    //隐藏
    [UIView animateWithDuration:kAnimationDuration animations:^{
        //隐藏遮盖
        _cover.alpha = 0;
        //隐藏详情
        CGRect frame = _detailNavController.view.frame;
        frame.origin.x += kDetailWidth;
        _detailNavController.view.frame = frame;
    } completion:^(BOOL finished) {
        [_cover removeFromSuperview];
        [_detailNavController.view removeFromSuperview];
        [_detailNavController removeFromParentViewController];
    }];
}

#pragma mark- collectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //显示团购详情控制器
    
    DealModel *deal = _dealArray[indexPath.row];
    [self showDealDetailController:deal];
}

#pragma mark- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_dealArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *iden = @"dealCell";
    
    DealCollectionCell *cell = [collectionView
                                  dequeueReusableCellWithReuseIdentifier:iden
                                  forIndexPath:indexPath];
    
    
    cell.dealModel = _dealArray[indexPath.row];
    
    return cell;
}

@end
