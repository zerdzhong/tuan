//
//  BaseDealListController.h
//  tuan
//
//  Created by zerd on 15-1-8.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CoverView;

@interface BaseDealListController : UICollectionViewController{
    NSMutableArray *_dealArray;
    CoverView *_cover;
}

@end
