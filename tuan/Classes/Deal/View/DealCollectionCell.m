//
//  DealCollectionCell.m
//  tuan
//
//  Created by zerd on 14-12-15.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "DealCollectionCell.h"
#import "ImageTool.h"
#import "Common.h"

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
    _price.text = _dealModel.current_price_text;
    
    //5.标签
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy-MM-dd";
    NSString *now = [format stringFromDate:[NSDate date]];
    //设置标签图片类型
    if ([now isEqualToString:_dealModel.publish_date]) {
        _badge.hidden = NO;
        _badge.image = [UIImage imageNamed:@"ic_deal_new.png"];
    } else if ([now isEqualToString:_dealModel.purchase_deadline]){
        _badge.hidden = NO;
        _badge.image = [UIImage imageNamed:@"ic_deal_soonOver.png"];
    } else if ([now compare:_dealModel.purchase_deadline] == NSOrderedDescending){
        _badge.hidden = NO;
        _badge.image = [UIImage imageNamed:@"ic_deal_over.png"];
    }else{
        _badge.hidden = YES;
    }
}


@end
