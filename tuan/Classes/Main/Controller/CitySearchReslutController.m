//
//  CitySearchReslutController.m
//  tuan
//
//  Created by zerd on 14-12-4.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "CitySearchReslutController.h"
#import "MetaDataTool.h"
#import "PinYin4Objc.h"
#import "Common.h"

@interface CitySearchReslutController ()

@property (nonatomic, strong) NSMutableArray *searchResultCities;

@end

@implementation CitySearchReslutController

-(instancetype)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:style]) {
        
    }
    
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    _searchResultCities = [[NSMutableArray alloc]init];
}

-(void)setSearchText:(NSString *)searchText{
    _searchText = searchText;
    
    //清除之前搜索结果
    [_searchResultCities removeAllObjects];
    //搜索新文字
    HanyuPinyinOutputFormat *pyFormat = [[HanyuPinyinOutputFormat alloc]init];
    pyFormat.caseType = CaseTypeUppercase;
    pyFormat.toneType = ToneTypeWithoutTone;
    pyFormat.vCharType = VCharTypeWithV;
    
    NSDictionary *cities = [MetaDataTool sharedMetaDataTool].totalCities;
    [cities enumerateKeysAndObjectsUsingBlock:^(NSString *key, CityModel *obj, BOOL *stop) {
        //拼音
        NSString *pinyin = [PinyinHelper toHanyuPinyinStringWithNSString:obj.name withHanyuPinyinOutputFormat:pyFormat withNSString:@"#"];
        NSArray *pinyinArray = [pinyin componentsSeparatedByString:@"#"];
        //拼音首字母
        NSMutableString *pinyinHeader = [NSMutableString string];
        for (NSString *word in pinyinArray) {
            [pinyinHeader appendString:[word substringToIndex:1]];
        }
        if ([obj.name rangeOfString:searchText].length != 0
            ||[pinyin rangeOfString:searchText.uppercaseString].length != 0
            || [pinyinHeader rangeOfString:searchText.uppercaseString].length != 0
            ) {
            //符合条件
            [_searchResultCities addObject:obj.name];
        }
    }];
    //刷新表格
    [self.tableView reloadData];
}

#pragma mark- datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _searchResultCities.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIden = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
    }
    
    cell.textLabel.text = _searchResultCities[indexPath.row];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"共有%lu个结果",(unsigned long)_searchResultCities.count];
}

#pragma mark0 delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CityModel *city = [[MetaDataTool sharedMetaDataTool].totalCities objectForKey:_searchResultCities[indexPath.row]];
    
    [MetaDataTool sharedMetaDataTool].currentCity = city;
}

@end
