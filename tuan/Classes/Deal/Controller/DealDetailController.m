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
#import "CollectDealTool.h"

#define kMargin 20

@interface DealDetailController ()<DetailSlideDockDelegate>

@property (nonatomic, weak) IBOutlet DetailBuyDock *buyDock;
@property (weak, nonatomic) IBOutlet DetailSlideDock *slideDock;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic, strong) DealDetailWebController *webController;
@property (nonatomic, strong) DealDetailInfoController *infoController;

@property (nonatomic, strong) UIBarButtonItem *collectButton;

@end

@implementation DealDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //背景色
    self.view.backgroundColor = kGlobalBgColor;
    //标题
    self.title = _deal.title;
    
    NSString *collectIcon = [[CollectDealTool sharedCollectDealTool] isDealCollected:_deal] ? @"ic_collect_suc.png":@"ic_deal_collect.png";
    
    //添加监听 收藏改变通知 KVO
    [[CollectDealTool sharedCollectDealTool] addObserver:self forKeyPath:@"collectDeals" options:NSKeyValueObservingOptionNew context:NULL];
    
    
    _collectButton = [UIBarButtonItem itemWithImage:collectIcon
                                   highlightedImage:@"ic_deal_collect_pressed.png"
                                             target:self
                                             action:@selector(onCollectClicked)];
    
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem itemWithImage:@"btn_share.png"
                                                              highlightedImage:@"btn_share_pressed.png"
                                                                        target:self
                                                                        action:nil],
                                                _collectButton
                                                ];
    
    //设置buyDock内容
    _buyDock.dealModel = _deal;
    //设置slideDock代理
    _slideDock.delegate = self;
    //初始化子控制器
    [self addAllChildController];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self detailDock:nil btnClickedFrom:0 to:0];
    _infoController.deal = _deal;
}

- (void)addAllChildController{
    //团购简介
    _infoController = [[DealDetailInfoController alloc]init];
    //默认选中团购简介
    [self addChildViewController:_infoController];
    
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

#pragma mark- 收藏相关
- (void)onCollectClicked{
    if(_deal.collected){
        [[CollectDealTool sharedCollectDealTool] disCollectDeal:_deal];
    }else{
        [[CollectDealTool sharedCollectDealTool] collectDeal:_deal];
    }
}

- (void)onCollectChanged{
    //改变收藏按钮图片
    NSString *collectIcon = [[CollectDealTool sharedCollectDealTool] isDealCollected:_deal] ? @"ic_collect_suc.png":@"ic_deal_collect.png";
    
    [_collectButton setCustomButtonImage:collectIcon forState:UIControlStateNormal];
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
    [_containerView addSubview:new.view];
}

#pragma mark- KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"collectDeals"]) {
        [self onCollectChanged];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[CollectDealTool sharedCollectDealTool] removeObserver:self forKeyPath:@"collectDeals"];
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
