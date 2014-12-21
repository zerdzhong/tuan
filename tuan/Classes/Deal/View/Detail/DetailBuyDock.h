//
//  DetailBuyDock.h
//  tuan
//
//  Created by zerd on 14-12-21.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealModel.h"
#import "CenterLineLable.h"

@interface DetailBuyDock : UIView
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (weak, nonatomic) IBOutlet CenterLineLable *originalPrice;

@property (nonatomic, strong) DealModel *dealModel;

+ (instancetype)buyDock;

@end
