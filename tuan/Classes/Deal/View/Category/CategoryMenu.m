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

@implementation CategoryMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *categoryArray = [MetaDataTool sharedMetaDataTool].totalCategories;
        //往scrollView添加分类数据
        
        for (int i = 0; i < categoryArray.count; i++) {
            CategoryModel *category = categoryArray[i];
            CategoryMenuItem *item = [[CategoryMenuItem alloc]init];
            item.category = category;
            item.frame = CGRectMake(i * kDropDownItemWidth, 0, 0, 0);
            [self.scrollView addSubview:item];
        }
        self.scrollView.contentSize = CGSizeMake(categoryArray.count * kDropDownItemWidth, 0);
    }
    return self;
}

@end
