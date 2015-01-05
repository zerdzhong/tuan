//
//  DetailInfoTextCell.m
//  tuan
//
//  Created by zerd on 14-12-30.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "DetailInfoTextView.h"
#import "UIImage+ZD.h"

@implementation DetailInfoTextView

- (void)awakeFromNib {
    // Initialization code
}

+ (instancetype)detailInfoText{
    return [[NSBundle mainBundle] loadNibNamed:@"DetailInfoTextView" owner:nil options:0][0];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [[UIImage resizedImage:@"bg_order_cell.png"]drawInRect:rect];
}

- (void)setInfoText:(NSString *)text{
    
    //设置描述
    
    CGRect descRect = [text boundingRectWithSize:CGSizeMake(_infoLabel.frame.size.width, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:[NSDictionary dictionaryWithObjectsAndKeys:_infoLabel.font,NSFontAttributeName, nil] context:nil];
    
//    descRect.size.height += 20;
    
    CGRect descFrame = _infoLabel.frame;
    
    CGFloat height = descRect.size.height + descFrame.origin.y;
    
    descFrame.size.height = descRect.size.height;
    _infoLabel.frame = descFrame;
    
    CGRect selfF = self.frame;
    selfF.size.height = height + 10;
    self.frame = selfF;
    
    _infoLabel.text = text;
}

- (void)setInfoBtnTitle:(NSString *)title icon:(NSString *)icon{
    [_infoBtn setTitle:title forState:UIControlStateNormal];
    [_infoBtn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
}


@end
