//
//  DealCollectionCell.h
//  tuan
//
//  Created by zerd on 14-12-15.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealModel.h"

@interface DealCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *desc;         //描述
@property (weak, nonatomic) IBOutlet UIImageView *image;    //配图
@property (weak, nonatomic) IBOutlet UILabel *price;        //价格
@property (weak, nonatomic) IBOutlet UIButton *joinCount;   //人数
@property (weak, nonatomic) IBOutlet UIImageView *badge;    //标签

@property (nonatomic, strong) DealModel *dealModel;

@end
