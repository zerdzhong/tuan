//
//  DealDetailInfoController.m
//  tuan
//
//  Created by zerd on 14-12-23.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "DealDetailInfoController.h"
#import "ImageTool.h"
#import "Common.h"
#import "DianpingDealTool.h"
#import "DetailInfoTextView.h"
#import "DetailInfoHeaderView.h"

#define kMargin 20

@interface DealDetailInfoController ()

@property (nonatomic, strong) UIScrollView *scrollView;

//团购详情
@property (nonatomic, strong) DetailInfoHeaderView *headerView;

@end

@implementation DealDetailInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame = CGRectMake(0, 0, 430, self.view.frame.size.height);
    CGFloat x = self.view.frame.size.width * 0.5;
    CGFloat y = self.view.frame.size.height * 0.5;
    _scrollView.center = CGPointMake(x, y);
    _scrollView.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin| UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.scrollEnabled = YES;
//    _scrollView.contentInset = UIEdgeInsetsMake(70, 0, 0, 0);
//    _scrollView.contentOffset = CGPointMake(0, -70);
    [self.view addSubview:_scrollView];
    
    _headerView = [DetailInfoHeaderView detailInfoHeader];
    _headerView.frame = CGRectMake(0, 100, _scrollView.frame.size.width, _headerView.frame.size.height);
    [_scrollView addSubview:_headerView];
    
}
-(void)setDeal:(DealModel *)deal{
    _deal = deal;
    _headerView.deal = _deal;
    if (_deal.restrictions == nil) {
        [self loadDetailInfo];
    }
}

- (void)loadDetailInfo{
    [[DianpingDealTool sharedDianpingDealTool] dealWithID:_deal.deal_id success:^(DealModel *deal) {
        //获得到团购的详细信息
        
        _deal = deal;
        
        //设置是否可以退
        
        //添加详情数据
        if (_deal.details.length != 0) {
            [self addInfoTextView:_deal.details title:@"团购详情" icon:@"ic_content.png"];
        }
        //团购详情
        if (_deal.restrictions.special_tips.length != 0) {
            [self addInfoTextView:_deal.restrictions.special_tips title:@"购买须知" icon:@"ic_tip.png"];
        }
        
        //购买须知
        if (_deal.notice.length != 0) {
            [self addInfoTextView:_deal.notice title:@"重要通知" icon:@"ic_tip.png"];
        }
        
        //
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)addInfoTextView:(NSString *)text title:(NSString *)title icon:(NSString *)icon{
    UIView *lastView = [_scrollView.subviews lastObject];
    DetailInfoTextView *textView = [DetailInfoTextView detailInfoText];
    textView.frame = CGRectMake(0, CGRectGetMaxY(lastView.frame) + kMargin , _scrollView.frame.size.width, 200);
//    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin ;
    [textView setInfoBtnTitle:title icon:icon];
    [_scrollView addSubview:textView];
    
    [textView setInfoText:text];
    _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(textView.frame) + 20);
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
