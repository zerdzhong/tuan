//
//  CollectController.m
//  tuan
//
//  Created by zerd on 14-11-28.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "CollectController.h"
#import "CollectDealTool.h"

@implementation CollectController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"收藏";
    
    _dealArray = [NSMutableArray arrayWithArray:[CollectDealTool sharedCollectDealTool].collectDeals];
}

@end
