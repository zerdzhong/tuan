//
//  UIImage+ZD.m
//  微博
//
//  Created by zerd on 14-10-15.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "UIImage+ZD.h"
#import "NSString+ZD.h"

@implementation UIImage (ZD)

//全屏显示图片
//+ (UIImage *)fullScreenImage:(NSString *)imageName
//{
//    //如果是 iphone 5/5s 自动加上 -568h@2x
//    if (iPhone5) {
//        imageName = [imageName fileAppend:@"-568h@2x"];
//    }
//    return [self imageNamed:imageName];
//}

//自由拉伸不会变形的图片
+ (UIImage *)resizedImage:(NSString *)imageName{

    return [UIImage resizedImage:imageName xPos:0.5 yPos:0.5];
}

+ (UIImage *)resizedImage:(NSString *)imageName xPos:(float)xPos yPos:(double)yPos{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * xPos topCapHeight:image.size.height * yPos];
}

@end
