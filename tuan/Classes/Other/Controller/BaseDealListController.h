//
//  BaseDealListController.h
//  tuan
//
//  Created by zerd on 15-1-8.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDetailController.h"

@class CoverView;

@interface BaseDealListController : BaseDetailController{
    NSMutableArray *_dealArray;
    UICollectionView *_collectionView;
}

@end
