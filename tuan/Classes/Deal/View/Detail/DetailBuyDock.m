//
//  DetailBuyDock.m
//  tuan
//
//  Created by zerd on 14-12-21.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "DetailBuyDock.h"

@implementation DetailBuyDock

-(void)setDealModel:(DealModel *)dealModel{
    _dealModel = dealModel;
    _currentPrice.text = _dealModel.current_price_text;
    _originalPrice.text = [NSString stringWithFormat:@"%@ 元",_dealModel.list_price_text];
}

+ (instancetype)buyDock{
    
    return [[NSBundle mainBundle]loadNibNamed:@"DetailBuyDock" owner:nil options:nil][0];
}

@end
