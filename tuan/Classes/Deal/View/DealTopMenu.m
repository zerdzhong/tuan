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

#define kItemMargin 10

@interface DealTopMenu ()

@property (nonatomic, strong) DealTopMenuItem *selectedItem;
@property (nonatomic, strong) DropDownMenu *showingMenu;    // CategoryMenu/DistrictMenu/OrderMenu

@property (nonatomic, strong) CategoryMenu *categoryMenu;   //分类菜单
@property (nonatomic, strong) DistrictMenu *districtMenu;   //区域菜单
@property (nonatomic, strong) OrderMenu *orderMenu;         //排序菜单

@end

@implementation DealTopMenu

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addItem:@"全部分类" index:0];
        [self addItem:@"全部商区" index:1];
        [self addItem:@"默认排序" index:2];
    }
    return self;
}

- (void)addItem:(NSString *)title index:(int)index{
    DealTopMenuItem *item = [[DealTopMenuItem alloc]init];
    item.title = title;
    item.tag = index;
    item.frame = CGRectMake((kTopMenuItemWidth + kItemMargin) * index, 0, 0, 0);
    
    [item addTarget:self
                     action:@selector(onItemClicked:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:item];
}

- (void)onItemClicked:(DealTopMenuItem *)item{
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

@end
