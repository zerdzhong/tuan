//
//  CollectController.m
//  tuan
//
//  Created by zerd on 14-11-28.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "CollectController.h"
#import "CollectDealTool.h"
#import "Common.h"

@implementation CollectController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"收藏";
    
    _dealArray = [NSMutableArray arrayWithArray:[CollectDealTool sharedCollectDealTool].collectDeals];
    
    //添加监听 收藏改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onCollectChanged)
                                                 name:kCollectChanged
                                               object:nil];
}

- (void)onCollectChanged{
    _dealArray = [NSMutableArray arrayWithArray:[CollectDealTool sharedCollectDealTool].collectDeals];
    [self.collectionView reloadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
