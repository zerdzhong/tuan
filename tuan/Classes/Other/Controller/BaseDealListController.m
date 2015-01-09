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
#import "CoverView.h"
#import "BaseNavigationController.h"
#import "DealDetailController.h"
#import "UIBarButtonItem+ZD.h"

#define kCellHeight 250
#define kCellWidth 250

#define kDetailWidth 550

@interface BaseDealListController ()


@end

@implementation BaseDealListController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(kCellWidth, kCellHeight); //大小
        layout.minimumLineSpacing = 20;         //行间距
        return [super initWithCollectionViewLayout:layout];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
