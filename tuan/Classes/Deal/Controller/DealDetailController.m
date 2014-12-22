//
//  DealDetailController.m
//  tuan
//
//  Created by zerd on 14-12-19.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "DealDetailController.h"
#import "Common.h"
#import "UIBarButtonItem+ZD.h"
#import "DetailBuyDock.h"
#import "DetailSlideDock.h"

@interface DealDetailController ()

@property (nonatomic, strong) DetailBuyDock *buyDock;

@end

@implementation DealDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //背景色
    self.view.backgroundColor = kGlobalBgColor;
    //标题
    self.title = _deal.title;
    
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem itemWithImage:@"btn_share.png"
                                                              highlightedImage:@"btn_share_pressed.png"
                                                                        target:self
                                                                        action:nil],
                                                
                                                [UIBarButtonItem itemWithImage:@"ic_deal_collect.png"
                                                              highlightedImage:@"ic_deal_collect_pressed.png"
                                                                        target:self
                                                                        action:nil]];
    
//    //添加购买栏
//    [self addBuyDock];
//    //添加右边边栏
//    [self addDetailSlideDock];
}

#pragma mark- 添加购买栏

- (void)addBuyDock{
    //添加购买栏
    _buyDock = [DetailBuyDock buyDock];
    _buyDock.dealModel = _deal;
    _buyDock.frame = CGRectMake(0, 64, self.view.frame.size.width, 60);
    [self.view addSubview:_buyDock];
}

- (void)addDetailSlideDock{
    DetailSlideDock *slideDock = [DetailSlideDock detailSlideDock];
    CGFloat x = self.view.frame.size.width - slideDock.frame.size.width;
    CGFloat y = self.view.frame.size.height - slideDock.frame.size.height - 100;
    slideDock.frame = CGRectMake(x, y, 0, 0);
    [self.view addSubview:slideDock];
}


-(void)setDeal:(DealModel *)deal{
    _deal = deal;
    _buyDock.dealModel = _deal;
    //标题
    self.title = _deal.title;
}


#pragma mark- 关闭自己
- (void)onClose{
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
