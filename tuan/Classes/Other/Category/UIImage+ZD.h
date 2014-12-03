//
//  UIImage+ZD.h
//  微博
//
//  Created by zerd on 14-10-15.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZD)

//全屏显示图片
//+ (UIImage *)fullScreenImage:(NSString *)imageName;

//自由拉伸不会变形的图片
+ (UIImage *)resizedImage:(NSString *)imageName;

+ (UIImage *)resizedImage:(NSString *)imageName xPos:(float)xPos yPos:(double)yPos;

@end
