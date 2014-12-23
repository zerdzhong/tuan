//
//  DetailSlideDock.h
//  tuan
//
//  Created by zerd on 14-12-22.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailSlideDock;
//delegate
@protocol DetailSlideDockDelegate <NSObject>

@optional
- (void)detailDock:(DetailSlideDock *)dock btnClickedFrom:(int)from to:(int)to;

@end

//class
@interface DetailSlideDock : UIView

@property (weak, nonatomic) IBOutlet UIButton *infoBtn;
@property (weak, nonatomic) IBOutlet UIButton *webBtn;
@property (weak, nonatomic) IBOutlet UIButton *merchantBtn;

@property (assign, nonatomic) id<DetailSlideDockDelegate> delegate;

- (IBAction)onBtnClicked:(id)sender;

+ (instancetype)detailSlideDock;

@end
