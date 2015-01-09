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
    
    //KVO
    [[CollectDealTool sharedCollectDealTool] addObserver:self forKeyPath:@"collectDeals" options:NSKeyValueObservingOptionNew context:NULL];

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"collectDeals"]) {
        _dealArray = [NSMutableArray arrayWithArray:[CollectDealTool sharedCollectDealTool].collectDeals];
        [self.collectionView reloadData];
    }
}

- (void)dealloc
{
    [[CollectDealTool sharedCollectDealTool] removeObserver:self forKeyPath:@"collectDeals"];
}

@end
