//
//  Deal.m
//  团购
//
//  Created by mj on 14-12-14.
//  Copyright (c) 2013年 zerd. All rights reserved.
//

#import "DealModel.h"

@implementation DealModel

- (void)setCurrent_price:(double)current_price{
    _current_price = current_price;
    _current_price_text = [self doubleToString:_current_price];
}

- (void)setList_price:(double)list_price{
    _list_price = list_price;
    _list_price_text = [self doubleToString:_list_price];
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

@end
