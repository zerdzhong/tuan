//
//  CityListController.m
//  tuan
//
//  Created by zerd on 14-11-30.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "CityListController.h"
#import "Common.h"
#import "NSObject+Value.h"
#import "CitySection.h"

#define kSearchHeight 44

@interface CityListController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic, strong)NSArray *citySections;
@property (nonatomic, strong)UIView *cover;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UISearchBar *searchBar;

@end

@implementation CityListController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //添加搜索框
    [self addSearchBar];
    
    //添加tableview
    [self addTableView];
    
    //加载数据
    [self loadCityData];
}

- (void)addSearchBar{
    UISearchBar *search = [[UISearchBar alloc]init];
    search.delegate = self;
    search.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    search.frame = CGRectMake(0, 0, self.view.frame.size.width, kSearchHeight);
    _searchBar = search;
    [self.view addSubview:search];
}

- (void)addTableView{
    UITableView *table = [[UITableView alloc]init];
    table.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    table.dataSource = self;
    table.delegate = self;
    CGFloat height = self.view.frame.size.height - kSearchHeight;
    table.frame = CGRectMake(0, kSearchHeight, self.view.frame.size.width, height);
    _tableView = table;
    [self.view addSubview:table];
}

- (void)loadCityData{
    NSArray *cityArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Cities" ofType:@"plist"]];
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dict in cityArray) {
        CitySection *section = [[CitySection alloc]init];
        [section setValues:dict];
        [array addObject:section];
    }
    
    _citySections = array;
}

#pragma mark- datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _citySections.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CitySection *sec = _citySections[section];
    return sec.cities.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    CitySection *sec = _citySections[indexPath.section];
    CityBaseModel *city = sec.cities[indexPath.row];
    cell.textLabel.text = city.name;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    CitySection *sec = _citySections[section];
    return sec.name;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return [_citySections valueForKeyPath:@"name"];;
}

#pragma mark- SearchBar delegate
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    //显示取消按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    
    //显示蒙层
    if (_cover == nil){
        _cover = [[UIView alloc]init];
        _cover.backgroundColor = [UIColor blackColor];
        _cover.frame = _tableView.frame;
        _cover.autoresizingMask = _tableView.autoresizingMask;
        [_cover addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onCoverClicked)]];
    }
    [self.view addSubview:_cover];
    _cover.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        _cover.alpha = 0.7;
    }];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

}

#pragma mark- 退出搜索框
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self onCoverClicked];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self onCoverClicked];
}

#pragma mark- 蒙层响应事件

- (void)onCoverClicked{
    //移除蒙层
    [UIView animateWithDuration:0.5 animations:^{
        _cover.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_cover removeFromSuperview];
    }];
    //去掉searchBar的取消
    [_searchBar setShowsCancelButton:NO animated:YES];
    //隐藏键盘
    [_searchBar resignFirstResponder];
}

@end
