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
#import "DealDetailInfoController.h"
#import "DealDetailWebController.h"
#import "DealDetailMerchantController.h"

@interface DealDetailController ()<DetailSlideDockDelegate>

@property (nonatomic, weak) IBOutlet DetailBuyDock *buyDock;
@property (weak, nonatomic) IBOutlet DetailSlideDock *slideDock;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic, strong) DealDetailWebController *webController;

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
    
    //设置buyDock内容
    _buyDock.dealModel = _deal;
    //设置slideDock代理
    _slideDock.delegate = self;
    //初始化子控制器
    [self addAllChildController];
}

- (void)addAllChildController{
    //团购简介
    DealDetailInfoController *infoController = [[DealDetailInfoController alloc]init];
    infoController.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:infoController];

    //默认选中团购简介
    [self detailDock:nil btnClickedFrom:0 to:0];
    
    
    //图文详情
    _webController = [[DealDetailWebController alloc]init];
    _webController.deal = _deal;
    [self addChildViewController:_webController];
    //商家信息
    DealDetailMerchantController *merchantController = [[DealDetailMerchantController alloc]init];
    merchantController.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:merchantController];
}

-(void)setDeal:(DealModel *)deal{
    _deal = deal;
    _buyDock.dealModel = _deal;
    _webController.deal = _deal;
    //标题
    self.title = _deal.title;
}


#pragma mark- 关闭自己
- (void)onClose{
}

#pragma mark- slideDockDelegate
-(void)detailDock:(DetailSlideDock *)dock btnClickedFrom:(int)from to:(int)to{
    //移除旧的控制器
    UIViewController *old = self.childViewControllers[from];
    [old.view removeFromSuperview];
    //添加新的控制器
    UIViewController *new = self.childViewControllers[to];
    new.view.frame = CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height);
    MyLog(@"%f,%f",new.view.frame.size.width,new.view.frame.size.height);
    [_containerView addSubview:new.view];
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
