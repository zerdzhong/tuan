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

#define kCellHeight 250
#define kCellWidth 250

@interface DealListController ()

@property (nonatomic, strong) NSMutableArray *dealArray;
@property (nonatomic, assign) int page;

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
    
}

- (void)addMJRefresh{
    
    [self.collectionView addHeaderWithTarget:self action:@selector(onHeaderRefresh)];
    
    [self.collectionView addFooterWithTarget:self action:@selector(onFooterRefresh)];
    
}

- (void)onHeaderRefresh{
    //下拉刷新
    _page = 1;
    [[DianpingDealTool sharedDianpingDealTool] dealsWithPage:_page success:^(NSArray *deals) {
        _dealArray = [NSMutableArray array];
        [_dealArray addObjectsFromArray:deals];
        //刷新数据
        [self.collectionView reloadData];
        //停止刷新
        [self.collectionView headerEndRefreshing];
    } failure:^(NSError *error) {
        //停止刷新
        [self.collectionView headerEndRefreshing];
    }];
}

- (void)onFooterRefresh{
    //上拉加载
    _page++;
    
    [[DianpingDealTool sharedDianpingDealTool] dealsWithPage:_page success:^(NSArray *deals) {
        [_dealArray addObjectsFromArray:deals];
        //刷新数据
        [self.collectionView reloadData];
        //停止刷新
        [self.collectionView footerEndRefreshing];
    } failure:^(NSError *error) {
        //停止刷新
        [self.collectionView footerEndRefreshing];
    }];
}

#pragma mark- notification
- (void)dataChange{
    
    [[DianpingDealTool sharedDianpingDealTool] dealsWithPage:1 success:^(NSArray *deals) {
        _dealArray = [[NSMutableArray alloc]init];
        [_dealArray addObjectsFromArray:deals];
        _page = 1;  //回到第一页
        //刷新数据
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
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

#pragma mark- collectionViewDelegate



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
