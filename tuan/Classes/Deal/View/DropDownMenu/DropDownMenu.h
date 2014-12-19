//
//  DropDownMenu.h
//  tuan
//
//  Created by zerd on 14-12-8.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  底部菜单(基类)

#import <UIKit/UIKit.h>
#import "DropDownMenuItem.h"
#import "DropDownSubTitle.h"

@interface DropDownMenu : UIView

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) DropDownSubTitle *subTitleView;
@property (nonatomic, strong) DropDownMenuItem *selectedItem;
@property (nonatomic, copy) void(^hiddenBlock)();

- (void)settingSubTitleBlock;
- (void)setItemMetaData:(DropDownMenuItem *)item;


//通过动画显示出来
- (void)showWithAnimation;
//通过动画隐藏出来
- (void)hideWithAnimation;

- (void)onItemClicked:(DropDownMenuItem *)item;

@end
