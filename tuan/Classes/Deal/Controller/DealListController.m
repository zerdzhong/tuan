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

#define kCellHeight 250
#define kCellWidth 250

@interface DealListController ()<DPRequestDelegate>

@property (nonatomic, strong) NSMutableArray *dealArray;

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
    
}

#pragma mark- notification
- (void)dataChange{
    
    DPAPI *api = [[DPAPI alloc]init];
    
    [api requestWithURL:@"v1/deal/find_deals"
                 params:@{@"city":[MetaDataTool sharedMetaDataTool].currentCity.name}
               delegate:self];
    
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

#pragma mark- 点评delegate

-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    //转换成数据Model
    NSArray *array = result[@"deals"];
    
    _dealArray = [[NSMutableArray alloc]init];
    for (NSDictionary *deal in array) {
        DealModel *dealModel = [[DealModel alloc]init];
        [dealModel setValues:deal];
        [_dealArray addObject:dealModel];
    }
    
    //刷新数据
    [self.collectionView reloadData];
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
    
    UICollectionViewCell *cell = [collectionView
                                  dequeueReusableCellWithReuseIdentifier:iden
                                  forIndexPath:indexPath];
    
    
    return cell;
}

@end
