//
//  DetailInfoHeaderCell.h
//  tuan
//
//  Created by zerd on 14-12-30.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealModel.h"

@interface DetailInfoHeaderView : UIView

/**详情headerview里面的控件*/
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIButton *anyTimeRefund;
@property (weak, nonatomic) IBOutlet UIButton *time;
@property (weak, nonatomic) IBOutlet UIButton *purchaseCount;
@property (weak, nonatomic) IBOutlet UIButton *reservation;

@property (nonatomic, strong) DealModel *deal;

+ (instancetype)detailInfoHeader;


@end
