//
//  CategoryModel.h
//  tuan
//
//  Created by zerd on 14-12-8.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject

@property (nonatomic, copy) NSString *name;  //名字
@property (nonatomic, copy) NSString *icon;     //图标
@property (nonatomic, strong)NSArray *subCategory;  //子分类

@end
