//
//  DetailSlideDock.m
//  tuan
//
//  Created by zerd on 14-12-22.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "DetailSlideDock.h"
#import "Common.h"

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

- (IBAction)onBtnClicked:(id)sender {
    MyLog(@"%@",sender);
}

+ (instancetype)detailSlideDock{
    
    return [[NSBundle mainBundle]loadNibNamed:@"DetailSlideDock" owner:nil options:nil][0];
}

//忽略size
-(void)setFrame:(CGRect)frame{
    frame.size = self.frame.size;
    [super setFrame:frame];
}

@end
