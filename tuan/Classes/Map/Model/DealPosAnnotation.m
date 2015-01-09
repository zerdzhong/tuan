//
//  DealPosAnnotation.m
//  tuan
//
//  Created by zerd on 15-1-9.
//  Copyright (c) 2015年 zerd. All rights reserved.
//

#import "DealPosAnnotation.h"
#import "MetaDataTool.h"

@implementation DealPosAnnotation

- (void)setDeal:(DealModel *)deal{
    _deal = deal;
    for (NSString *categoryName in _deal.categories) {
        NSString *iconName = [[MetaDataTool sharedMetaDataTool]iconNameWithCategory:categoryName];
        if (iconName != nil) {
            iconName = [iconName stringByReplacingOccurrencesOfString:@"filter_" withString:@""];
            _iconName = iconName;
            break;
        }
    }
}

@end
