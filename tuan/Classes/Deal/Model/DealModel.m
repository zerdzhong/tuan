//
//  Deal.m
//  团购
//
//  Created by mj on 14-12-14.
//  Copyright (c) 2013年 zerd. All rights reserved.
//

#import "DealModel.h"
#import "NSObject+Value.h"
#import "DealBusinessModel.h"

@implementation DealModel

- (void)setCurrent_price:(double)current_price{
    _current_price = current_price;
    _current_price_text = [self doubleToString:_current_price];
}

- (void)setList_price:(double)list_price{
    _list_price = list_price;
    _list_price_text = [self doubleToString:_list_price];
}

-(void)setRestrictions:(RestrictionModel *)restrictions{
    if ([restrictions isKindOfClass:[NSDictionary class]]) {
        _restrictions = [[RestrictionModel alloc]init];
        [_restrictions setValues:(NSDictionary *)restrictions];
    }else{
        _restrictions = restrictions;
    }
}

- (void)setBusinesses:(NSArray *)businesses{
    NSDictionary *dicObj = [businesses lastObject];
    if ([dicObj isKindOfClass:[NSDictionary class]]) {
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in businesses) {
            DealBusinessModel *bus = [[DealBusinessModel alloc]init];
            [bus setValues:dict];
            [temp addObject:bus];
        }
        _businesses = temp;
    }else {
        _businesses = businesses;
    }
}

- (NSString *)doubleToString:(double)num{
    NSString *resultString;
    NSString *doubleString = [NSString stringWithFormat:@"%f",num];
    if ([doubleString containsString:@"."]) {
        const char *floatChars = [doubleString UTF8String];
        int length = (int)[doubleString length];
        int zeroLength = 0;
        int i = length-1;
        for(; i>=0; i--)
        {
            if(floatChars[i] == '0'/*0x30*/) {
                zeroLength++;
            } else {
                break;
            }
        }
        resultString = [doubleString substringToIndex:i+1];
        if ([resultString hasSuffix:@"."]) {
            resultString = [resultString substringToIndex:resultString.length - 1];
        }
    }else{
        resultString = doubleString;
    }
    
    return resultString;
}

#pragma mark- 根据团购id判断是否为同一个团购
-(BOOL)isEqual:(DealModel *)object{
    return [_deal_id isEqualToString:object.deal_id];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super init]){
        self.image_url = [coder decodeObjectForKey:@"image_url"];
        self.purchase_count = [coder decodeIntForKey:@"purchase_count"];
        self.current_price = [coder decodeDoubleForKey:@"current_price"];
        self.desc = [coder decodeObjectForKey:@"desc"];
        self.deal_id = [coder decodeObjectForKey:@"deal_id"];
        self.purchase_deadline = [coder decodeObjectForKey:@"purchase_deadline"];
        self.publish_date = [coder decodeObjectForKey:@"publish_date"];
        self.list_price = [coder decodeDoubleForKey:@"list_price"];
        self.title = [coder decodeObjectForKey:@"title"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_image_url forKey:@"image_url"];
    [coder encodeInt:_purchase_count forKey:@"purchase_count"];
    [coder encodeDouble:_current_price forKey:@"current_price"];
    [coder encodeObject:_desc forKey:@"desc"];
    [coder encodeObject:_deal_id forKey:@"deal_id"];
    [coder encodeObject:_purchase_deadline forKey:@"purchase_deadline"];
    [coder encodeObject:_publish_date forKey:@"publish_date"];
    [coder encodeDouble:_list_price forKey:@"list_price"];
    [coder encodeObject:_title forKey:@"title"];
}

@end
