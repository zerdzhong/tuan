//
//  DetailInfoTextCell.h
//  tuan
//
//  Created by zerd on 14-12-30.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailInfoTextView : UIView

+ (instancetype)detailInfoText;

@property (weak, nonatomic) IBOutlet UIButton *infoBtn;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

- (void)setInfoText:(NSString *)text;
- (void)setInfoBtnTitle:(NSString *)title icon:(NSString *)icon;

@end
