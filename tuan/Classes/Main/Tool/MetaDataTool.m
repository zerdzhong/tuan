//
//  MetaDataTool.m
//  tuan
//
//  Created by zerd on 14-12-3.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "MetaDataTool.h"
#import "CitySection.h"
#import "CityModel.h"
#import "CategoryModel.h"
#import "Common.h"
#import "NSObject+Value.h"

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"visitedCityNames.data"]

@interface MetaDataTool ()

@property (nonatomic, strong) CitySection *visitedSection;      // 最近访问的城市组数据
@property (nonatomic, strong) NSMutableArray *visitedCityNames; // 最近访问的城市名

@end

@implementation MetaDataTool

singleton_implementation(MetaDataTool)

-(instancetype)init{
    if (self = [super init]) {
        
        //1.加载城市
        [self loadCityData];
        //2.加载分类数据
        [self loadCategoryData];
    }
    
    return self;
}

- (void)loadCityData{
    _totalCities = [[NSMutableDictionary alloc]init];
    NSMutableArray *tempTotalArray = [[NSMutableArray alloc]init];
    
    //所有城市
    //加载plist数据
    NSArray *a2zCityArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Cities" ofType:@"plist"]];
    
    //初始化热门城市
    CitySection *hotSection = [[CitySection alloc]init];
    hotSection.name = @"热门城市";
    hotSection.cities = [[NSMutableArray alloc]init];
    [tempTotalArray addObject:hotSection];
    
    //添加A-Z城市
    for (NSDictionary *dict in a2zCityArray) {
        CitySection *section = [[CitySection alloc]init];
        [section setValues:dict];
        [tempTotalArray addObject:section];
        for (CityModel *city in section.cities) {
            if (city.hot) {
                //添加热门城市
                [hotSection.cities addObject:city];
            }
            [_totalCities setValue:city forKey:city.name];
        }
    }
    
    //从沙盒中读取最近城市
    _visitedCityNames = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    if (_visitedCityNames == nil) {
        _visitedCityNames = [[NSMutableArray alloc]init];
    }
    
    //添加最近访问城市组
    _visitedSection = [[CitySection alloc]init];
    _visitedSection.name = @"最近访问";
    _visitedSection.cities = [[NSMutableArray alloc]init];
    
    
    for (NSString *name in _visitedCityNames) {
        CityModel *city = [_totalCities valueForKey:name];
        [_visitedSection.cities addObject:city];
    }
    
    if (_visitedSection.cities.count != 0) {
        [tempTotalArray insertObject:_visitedSection atIndex:0];
    }
    
    _totalCitySections = tempTotalArray;
}

- (void)loadCategoryData{
    NSMutableArray *tempTotalArray = [[NSMutableArray alloc]init];
    //加载plist数据
    NSArray *categoryArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Categories"
                                                                                              ofType:@"plist"]];
    for (NSDictionary *dict in categoryArray) {
        CategoryModel *category = [[CategoryModel alloc]init];
        [category setValues:dict];
        [tempTotalArray addObject:category];
    }
    _totalCategories = tempTotalArray;
}

-(void)setCurrentCity:(CityModel *)currentCity{
    _currentCity = currentCity;
    //移除之前相同的城市
    [_visitedCityNames removeObject:_currentCity.name];
    
    //将新的插到最前面
    [_visitedCityNames insertObject:_currentCity.name atIndex:0];
    //存储
    [NSKeyedArchiver archiveRootObject:_visitedCityNames toFile:kFilePath];
    
    //将新的插到城市组的最前面
    [_visitedSection.cities removeObject:currentCity ];
    [_visitedSection.cities insertObject:currentCity atIndex:0];
    
    if (![_totalCitySections containsObject:_visitedSection]) {
        NSMutableArray *totalSections = (NSMutableArray *)_totalCitySections;
        [totalSections insertObject:_visitedSection atIndex:0];
    }
    
    //发出通知
    [[NSNotificationCenter defaultCenter]postNotificationName:kCityChanged object:nil userInfo:nil];
}


@end
