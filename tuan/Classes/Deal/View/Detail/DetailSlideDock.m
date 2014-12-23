//
//  DetailSlideDock.m
//  tuan
//
//  Created by zerd on 14-12-22.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "DetailSlideDock.h"
#import "Common.h"

@interface DetailSlideDock ()

@property (nonatomic, strong) UIButton *selectedBtn;

@end

@implementation DetailSlideDock

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        UIView *containerView = [[NSBundle mainBundle]loadNibNamed:@"DetailSlideDock" owner:self options:nil][0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
    }
    return self;
}

+ (instancetype)detailSlideDock{
    
    return [[NSBundle mainBundle]loadNibNamed:@"DetailSlideDock" owner:nil options:nil][0];
}

-(void)awakeFromNib{
    [self onBtnClicked:_infoBtn];
}

- (IBAction)onBtnClicked:(UIButton *)sender {
    
    //通知代理
    if ([_delegate respondsToSelector:@selector(detailDock:btnClickedFrom:to:)]) {
        [_delegate detailDock:self btnClickedFrom:(int)_selectedBtn.tag to:(int)sender.tag];
    }
    
    //控制按钮状态
    _selectedBtn.enabled = YES;
    _selectedBtn = sender;
    _selectedBtn.enabled = NO;
//    //让被选中的按钮变成最上面
//    if (sender == _infoBtn) {        //最上边的按钮
//        [self insertSubview:_merchantBtn atIndex:0];
//    }else if (sender == _merchantBtn){
//        [self insertSubview:_infoBtn atIndex:0];
//    }
//    [self bringSubviewToFront:_selectedBtn]; 
}

//忽略size
-(void)setFrame:(CGRect)frame{
    frame.size = self.frame.size;
    [super setFrame:frame];
}

@end
