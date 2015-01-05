//
//  DetailInfoHeaderCell.m
//  tuan
//
//  Created by zerd on 14-12-30.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "DetailInfoHeaderView.h"
#import "UIImage+ZD.h"
#import "ImageTool.h"

@implementation DetailInfoHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"DetailInfoHeaderView" owner:nil options:0][0];
    }
    return self;
}

+ (instancetype)detailInfoHeader{
    return [[NSBundle mainBundle] loadNibNamed:@"DetailInfoHeaderView" owner:nil options:0][0];
}


-(void)setDeal:(DealModel *)deal{
    _deal = deal;
    //设置图片
    [ImageTool loadImage:_deal.image_url placeholder:@"placeholder_deal.png" imageView:_image];
    //购买人数
    NSString *purchaseString = [NSString stringWithFormat:@"%d人已购买",_deal.purchase_count];
    [_purchaseCount setTitle:purchaseString forState:UIControlStateNormal];
    
    //剩余时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *deadline = [[fmt dateFromString:_deal.purchase_deadline]dateByAddingTimeInterval:24 * 3600];
    NSDate *now = [NSDate date];
    
    //日历时间
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *compt = [calendar components:NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:now toDate:deadline options:0];
    NSString *timeString = [NSString stringWithFormat:@"%ld天%ld小时%ld分钟",(long)compt.day,(long)compt.hour,(long)compt.minute];
    [_time setTitle:timeString forState:UIControlStateNormal];
    
    //设置描述
    _desc.text = deal.desc;
    
    CGRect descRect = [deal.desc boundingRectWithSize:CGSizeMake(_desc.frame.size.width, MAXFLOAT)
                            options:NSStringDrawingUsesLineFragmentOrigin
                         attributes:[NSDictionary dictionaryWithObjectsAndKeys:_desc.font,NSFontAttributeName, nil] context:nil];
    
    descRect.size.height += 20;
    
    CGRect descFrame = _desc.frame;
    
    CGFloat heightChange = descRect.size.height - descFrame.size.height;
    
    descFrame.size.height = descRect.size.height;
    _desc.frame = descFrame;
    
    CGRect selfF = self.frame;
    selfF.size.height = selfF.size.height + heightChange;
    self.frame = selfF;
    
    [self setNeedsLayout];
    
    if (deal.restrictions != nil){
        //已经加载过了
        
        //设置是否可以退款
        _anyTimeRefund.enabled = _deal.restrictions.is_refundable;
        _reservation.enabled = _deal.restrictions.is_reservation_required;
        
    }
}

//- (void)setFrame:(CGRect)frame{
//    frame.size.height = self.frame.size.height;
//    [super setFrame:frame];
//}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [[UIImage resizedImage:@"bg_order_cell.png"]drawInRect:rect];
}

@end
