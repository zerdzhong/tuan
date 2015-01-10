//
//  BaseDealListController.m
//  tuan
//
//  Created by zerd on 15-1-8.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "BaseDealListController.h"
#import "Common.h"
#import "DealModel.h"
#import "DealCollectionCell.h"

#define kCellHeight 250
#define kCellWidth 250

@interface BaseDealListController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation BaseDealListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化collectionview
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kCellWidth, kCellHeight); //大小
    layout.minimumLineSpacing = 20;         //行间距 initWithCollectionViewLayout:layout
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    //设置背景色
    self.collectionView.backgroundColor = kGlobalBgColor;
    
    //注册cell的xib
    [self.collectionView registerNib:[UINib nibWithNibName:@"DealCollectionCell"
                                                    bundle:nil]
          forCellWithReuseIdentifier:@"dealCell"];
    
    //设置collectionview永远支持垂直滚动(数据不足时，默认不能滚动)
    self.collectionView.alwaysBounceVertical = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    //计算默认间距
    CGSize size = [UIScreen mainScreen].bounds.size;
    [self viewWillTransitionToSize:size withTransitionCoordinator:nil];
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

#pragma mark- collectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //显示团购详情控制器
    
    DealModel *deal = _dealArray[indexPath.row];
    [self showDealDetailController:deal];
}

@end
