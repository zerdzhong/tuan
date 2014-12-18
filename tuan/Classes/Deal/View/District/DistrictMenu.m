//
//  DistrictMenu.m
//  tuan
//
//  Created by zerd on 14-12-9.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "DistrictMenu.h"
#import "MetaDataTool.h"
#import "DistrictMenuItem.h"
#import "CityModel.h"
#import "DistrictMode.h"
#import "Common.h"

@interface DistrictMenu ()

@property (nonatomic, strong) NSMutableArray *itemArray;

@end

@implementation DistrictMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _itemArray = [NSMutableArray array];
        
        [self cityChange];
        
        //城市改变
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(cityChange)
                                                     name:kCityChanged
                                                   object:nil];
        
    }
    return self;
}

- (void)settingSubTitleBlock{
    self.subTitleView.setTitleBlock = ^(NSString *title){
        [MetaDataTool sharedMetaDataTool].currentDistrict = title;
    };
    self.subTitleView.getTitleBlock = ^(){
        return [MetaDataTool sharedMetaDataTool].currentDistrict;
    };
}

- (void)setItemMetaData:(DropDownMenuItem *)item{
    [MetaDataTool sharedMetaDataTool].currentDistrict = [item titleForState:UIControlStateNormal];
}

#pragma mark- 城市改变监听
- (void)cityChange{
    
    CityModel *city = [MetaDataTool sharedMetaDataTool].currentCity;
    NSArray *districtArray = city.districts;
    //往scrollView添加分类数据
    
    for (int i = 0; i < districtArray.count; i++) {
        DistrictMenuItem *item = nil;
        if (i >= _itemArray.count) {
            //item不够新创建
            item = [[DistrictMenuItem alloc]init];
            [_itemArray addObject:item];
            [self.scrollView addSubview:item];
        }else{
            item = _itemArray[i];
        }
        
        item.hidden = NO;
        item.district = districtArray[i];
        [item addTarget:self action:@selector(onItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        item.frame = CGRectMake(i * kDropDownItemWidth, 0, 0, 0);
        //默认选中第0个
        if (i == 0) {
            item.selected = YES;
            self.selectedItem = item;
        }else{
            item.selected = NO;
        }
    }
    //隐藏多余的Item
    for (NSUInteger i = districtArray.count; i < _itemArray.count; i++) {
        DistrictMenuItem *item = _itemArray[i];
        item.hidden = YES;
    }
    self.scrollView.contentSize = CGSizeMake(districtArray.count * kDropDownItemWidth, 0);
    
    //隐藏subtitle
    [self.subTitleView hideWithAnimation];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
