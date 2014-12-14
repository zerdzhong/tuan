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

@implementation DistrictMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CityModel *city = [MetaDataTool sharedMetaDataTool].currentCity;
        NSArray *districtArray = city.districts;
        //往scrollView添加分类数据
        
        for (int i = 0; i < districtArray.count; i++) {
            DistrictMenuItem *item = [[DistrictMenuItem alloc]init];
            item.district = districtArray[i];
            [item addTarget:self action:@selector(onItemClicked:) forControlEvents:UIControlEventTouchUpInside];
            item.frame = CGRectMake(i * kDropDownItemWidth, 0, 0, 0);
            [self.scrollView addSubview:item];
        }
        self.scrollView.contentSize = CGSizeMake(districtArray.count * kDropDownItemWidth, 0);
        
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

- (void)cityChange{
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    CityModel *city = [MetaDataTool sharedMetaDataTool].currentCity;
    NSArray *districtArray = city.districts;
    //往scrollView添加分类数据
    
    for (int i = 0; i < districtArray.count; i++) {
        DistrictMenuItem *item = [[DistrictMenuItem alloc]init];
        item.district = districtArray[i];
        [item addTarget:self action:@selector(onItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        item.frame = CGRectMake(i * kDropDownItemWidth, 0, 0, 0);
        [self.scrollView addSubview:item];
    }
    self.scrollView.contentSize = CGSizeMake(districtArray.count * kDropDownItemWidth, 0);
}

@end
