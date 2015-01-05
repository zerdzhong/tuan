//
//  Deal.h
//  团购
//
//  Created by mj on 14-12-14.
//  Copyright (c) 2013年 zerd. All rights reserved.
//  一个团购模型

#import <Foundation/Foundation.h>
#import "RestrictionModel.h"

@interface DealModel : NSObject

@property (nonatomic, copy) NSString *deal_id;      // 团购ID
@property (nonatomic, copy) NSString *title;        // 标题
@property (nonatomic, copy) NSString *desc;         // 描述
@property (nonatomic, assign) double list_price;
@property (nonatomic, assign) double current_price; // 当前价格

@property (nonatomic, copy,readonly) NSString *list_price_text;
@property (nonatomic, copy,readonly) NSString *current_price_text; // 当前价格

@property (nonatomic, strong) NSArray *regions;             // 区域
@property (nonatomic, strong) NSArray *categories;          // 分类
@property (nonatomic, assign) int purchase_count;           // 已购买人数
@property (nonatomic, strong) NSString *publish_date;       // 发布日期
@property (nonatomic, strong) NSString *purchase_deadline;  // 下架日期
@property (nonatomic, copy) NSString *image_url;            // 图片
@property (nonatomic, copy) NSString *s_image_url;          // 小图
@property (nonatomic, copy) NSString *deal_h5_url;          // 链接


//扩充详情界面需要的信息
@property (nonatomic, copy) NSString *details;  //详情
@property (nonatomic, copy) NSString *notice;   //重要通知
@property (nonatomic, strong) RestrictionModel *restrictions;   //约束条件

@property (nonatomic, assign) BOOL collected;   //额外属性 是否收藏

@end