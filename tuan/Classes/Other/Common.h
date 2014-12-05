//
//  Common.h
//  tuan
//
//  Created by zerd on 14-11-26.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#ifndef tuan_Common_h
#define tuan_Common_h

/*
 控件属性
 */

#define kItemWidth 100
#define kItemHeight 80

#define kCityChanged @"tuan_cityChanged"
#define kCityKey @"tuan_city"

#define kGlobalBgColor [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_deal.png"]]

//顶部菜单item宽度
#define kTopMenuItemWidth 100
#define kTopMenuItemHeight 44

// 2.日志输出宏定义
#ifdef DEBUG
// 调试状态
#define MyLog(...) NSLog(__VA_ARGS__)
#else
// 发布状态
#define MyLog(...)
#endif

#endif
