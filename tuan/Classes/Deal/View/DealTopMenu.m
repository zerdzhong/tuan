//
//  DealTopMenu.m
//  tuan
//
//  Created by zerd on 14-12-5.
//  Copyright (c) 2014年 zerd. All rights reserved.
//  团购顶部菜单

#import "DealTopMenu.h"
#import "DealTopMenuItem.h"
#import "CategoryMenu.h"
#import "DistrictMenu.h"
#import "OrderMenu.h"
#import "Common.h"
#import "MetaDataTool.h"

#define kItemMargin 10

@interface DealTopMenu ()

@property (nonatomic, strong) DealTopMenuItem *selectedItem;
@property (nonatomic, strong) DropDownMenu *showingMenu;    // CategoryMenu/DistrictMenu/OrderMenu

@property (nonatomic, strong) CategoryMenu *categoryMenu;   //分类菜单
@property (nonatomic, strong) DistrictMenu *districtMenu;   //区域菜单
@property (nonatomic, strong) OrderMenu *orderMenu;         //排序菜单

@property (nonatomic, strong) DealTopMenuItem *categoryMenuItem;        //分类菜单item
@property (nonatomic, strong) DealTopMenuItem *districtMenuItem;        //区域菜单item
@property (nonatomic, strong) DealTopMenuItem *orderMenuItem;           //排序菜单item

@end

@implementation DealTopMenu

- (instancetype)init
{
    self = [super init];
    if (self) {
        _categoryMenuItem = [self addItem:kAllCategory index:0];
        _districtMenuItem = [self addItem:kAllDistrict index:1];
        _orderMenuItem = [self addItem:@"默认排序" index:2];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(dataChange)
                                                     name:kCityChanged
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(dataChange)
                                                     name:KCategoryChanged
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(dataChange)
                                                     name:KDistrictChanged
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(dataChange)
                                                     name:KOrderChanged
                                                   object:nil];
        
    }
    return self;
}

- (DealTopMenuItem *)addItem:(NSString *)title index:(int)index{
    DealTopMenuItem *item = [[DealTopMenuItem alloc]init];
    item.title = title;
    item.tag = index;
    item.frame = CGRectMake((kTopMenuItemWidth + kItemMargin) * index, 0, 0, 0);
    
    [item addTarget:self
             action:@selector(onItemClicked:)
   forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:item];
    return item;
}

- (void)onItemClicked:(DealTopMenuItem *)item{
    
    //没有选择城市，不能选择菜单
    if ([MetaDataTool sharedMetaDataTool].currentCity == nil) {
        return;
    }
    
    _selectedItem.selected = NO;
    
    if (_selectedItem == item) {
        _selectedItem = nil;
        //隐藏本来显示的菜单
        [self hideDropMenu];
    }else{
        //选中菜单，显示DropMenu
        _selectedItem = item;
        [self showDropMenu:item];
    }
    _selectedItem.selected = YES;
}

#pragma mark- 显示底部菜单
- (void)showDropMenu:(DealTopMenuItem *)item{
    
    [_showingMenu removeFromSuperview];
    
    //没有菜单在显示 需要菜单
    BOOL needAnimation = _showingMenu == nil;
    
    switch (item .tag) {
        case 0:{//分类菜单
            if (_categoryMenu == nil) {
                _categoryMenu = [[CategoryMenu alloc]initWithFrame:_contentView.bounds];
            }
            _showingMenu = _categoryMenu;
            break;
        }
        case 1:{//区域菜单
            if (_districtMenu == nil) {
                _districtMenu = [[DistrictMenu alloc]initWithFrame:_contentView.bounds];
            }
            _showingMenu = _districtMenu;
            break;
        }
        case 2:{//排序菜单
            if (_orderMenu == nil) {
                _orderMenu = [[OrderMenu alloc]initWithFrame:_contentView.bounds];
            }
            _showingMenu = _orderMenu;
            break;
        }
        default:
            break;
    }
    
    __unsafe_unretained DealTopMenu *menu = self;
    
    _showingMenu.hiddenBlock = ^(void){
        //清空菜单选中
        menu->_selectedItem.selected = NO;
        menu->_selectedItem = nil;
        //清空showingMenu
        menu->_showingMenu = nil;
    };
    
    [_contentView addSubview:_showingMenu];
    
    //执行动画
    if (needAnimation) {
        [_showingMenu showWithAnimation];
    }
}

#pragma mark- 隐藏  底部菜单
- (void)hideDropMenu{
    [_showingMenu hideWithAnimation];
}

-(void)setFrame:(CGRect)frame{
    frame.size = CGSizeMake(3*kTopMenuItemWidth, kTopMenuItemHeight);
    [super setFrame:frame];
}

#pragma mark- notification

- (void)dataChange{
    _selectedItem.selected = NO;
    _selectedItem = nil;
    
    //更新分类按钮的文字
    if ([MetaDataTool sharedMetaDataTool].currentCategory != nil) {
        _categoryMenuItem.title = [MetaDataTool sharedMetaDataTool].currentCategory;
    }
    //更新商区按钮的文字
    if ([MetaDataTool sharedMetaDataTool].currentDistrict != nil) {
        _districtMenuItem.title = [MetaDataTool sharedMetaDataTool].currentDistrict;
    }

    //更新排序按钮的文字
    if ([MetaDataTool sharedMetaDataTool].currentOrder.name != nil) {
        _orderMenuItem.title = [MetaDataTool sharedMetaDataTool].currentOrder.name;
    }
    
    //隐藏
    [self hideDropMenu];
    _showingMenu = nil;
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
