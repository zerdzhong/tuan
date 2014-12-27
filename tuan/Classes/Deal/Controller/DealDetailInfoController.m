//
//  DealDetailInfoController.m
//  tuan
//
//  Created by zerd on 14-12-23.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "DealDetailInfoController.h"
#import "DealDetailInfoHeaderView.h"
#import "ImageTool.h"
#import "Common.h"
#import "DianpingDealTool.h"

@interface DealDetailInfoController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet DealDetailInfoHeaderView *headerView;

@property (weak, nonatomic) IBOutlet UIImageView *image; 
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIButton *anyTimeRefund;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *overdueRefund;
@property (weak, nonatomic) IBOutlet UIButton *time;
@property (weak, nonatomic) IBOutlet UIButton *purchaseCount;
@property (weak, nonatomic) IBOutlet UIButton *reservation;

@end

@implementation DealDetailInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    NSString *timeString = [NSString stringWithFormat:@"%ld天%ld小时%ld分钟",compt.day,compt.hour,compt.minute];
    [_time setTitle:timeString forState:UIControlStateNormal];
    
    //设置描述
    _desc.text = deal.desc;
    
    //加载详细的团购信息
    [self loadDetailInfo];
    
}

- (void)loadDetailInfo{
    [[DianpingDealTool sharedDianpingDealTool] dealWithID:_deal.deal_id success:^(DealModel *deal) {
        //获得到团购的详细信息
        
        //设置是否可以退款
        _anyTimeRefund.enabled = deal.restrictions.is_refundable;
        _reservation.enabled = deal.restrictions.is_reservation_required;
        
    } failure:^(NSError *error) {
        
    }];
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
