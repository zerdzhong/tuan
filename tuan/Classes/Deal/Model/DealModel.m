//
//  Deal.m
//  团购
//
//  Created by mj on 14-12-14.
//  Copyright (c) 2013年 zerd. All rights reserved.
//

#import "DealModel.h"

@implementation DealModel

-(void)setCurrent_price:(double)current_price{
    NSString *doubleString = [NSString stringWithFormat:@"%f",current_price];
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
        _current_price_text = [doubleString substringToIndex:i+1];
        if ([_current_price_text hasSuffix:@"."]) {
            _current_price_text = [_current_price_text substringToIndex:_current_price_text.length - 1];
        }
    }else{
        _current_price_text = doubleString;
    }
}

@end
