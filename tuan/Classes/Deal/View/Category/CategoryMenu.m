//
//  CategoryMenu.m
//  tuan
//
//  Created by zerd on 14-12-8.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "CategoryMenu.h"
#import "MetaDataTool.h"
#import "CategoryModel.h"
#import "CategoryMenuItem.h"
#import "Common.h"

@interface CategoryMenu ()

@end

@implementation CategoryMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *categoryArray = [MetaDataTool sharedMetaDataTool].totalCategories;
        //往scrollView添加分类数据
        
        for (int i = 0; i < categoryArray.count; i++) {
            CategoryMenuItem *item = [[CategoryMenuItem alloc]init];
            item.category = categoryArray[i];;
            item.frame = CGRectMake(i * kDropDownItemWidth, 0, 0, 0);
            [item addTarget:self action:@selector(onItemClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:item];
        }
        self.scrollView.contentSize = CGSizeMake(categoryArray.count * kDropDownItemWidth, 0);
    }
    return self;
}

-(void)hideWithAnimation{
    [super hideWithAnimation];
}

- (void)settingSubTitleBlock{
    self.subTitleView.setTitleBlock = ^(NSString *title){
        [MetaDataTool sharedMetaDataTool].currentCategory = title;
    };
    self.subTitleView.getTitleBlock = ^(){
        return [MetaDataTool sharedMetaDataTool].currentCategory;
    };
}

@end
