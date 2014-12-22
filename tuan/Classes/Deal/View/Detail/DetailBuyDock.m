//
//  DetailBuyDock.m
//  tuan
//
//  Created by zerd on 14-12-21.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "DetailBuyDock.h"
#import "UIImage+ZD.h"

@implementation DetailBuyDock

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {

       UIView *containerView = [[NSBundle mainBundle]loadNibNamed:@"DetailBuyDock" owner:self options:nil][0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
    }
    return self;
}

-(void)setDealModel:(DealModel *)dealModel{
    _dealModel = dealModel;
    _currentPrice.text = _dealModel.current_price_text;
    _originalPrice.text = [NSString stringWithFormat:@"%@ 元",_dealModel.list_price_text];
}

+ (instancetype)buyDock{
    
    return [[NSBundle mainBundle]loadNibNamed:@"DetailBuyDock" owner:nil options:nil][0];
}

-(void)drawRect:(CGRect)rect{
    [[UIImage resizedImage:@"bg_buyBtn.png"] drawInRect:rect];
}

@end
