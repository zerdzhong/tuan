//
//  DealCollectionCell.m
//  tuan
//
//  Created by zerd on 14-12-15.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "DealCollectionCell.h"
#import "ImageTool.h"

@implementation DealCollectionCell

- (void)setDealModel:(DealModel *)dealModel{
    _dealModel = dealModel;
    // 1.设置描述
    _desc.text = _dealModel.desc;
    
    // 2.图片
    [ImageTool loadImage:_dealModel.image_url placeholder:@"placeholder_deal.png" imageView:_image];
    
    // 3.购买人数
    [_joinCount setTitle:[NSString stringWithFormat:@"%d", _dealModel.purchase_count] forState:UIControlStateNormal];
    
    // 4.价格
    _price.text = [NSString stringWithFormat:@"%.f", _dealModel.current_price];
}

@end
