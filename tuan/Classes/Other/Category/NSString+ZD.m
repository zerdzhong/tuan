//
//  NSString+ZD.m
//  微博
//
//  Created by zerd on 14-10-16.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "NSString+ZD.h"

@implementation NSString (ZD)

- (NSString *)fileAppend:(NSString *)appendString
{
    //1.获取文件扩展名
    NSString *ext = [self pathExtension];
    
    //2.删除文件扩展名
    NSString *imageName = [self stringByDeletingPathExtension];
    
    //3.拼接上 -568h@2x
    imageName = [imageName stringByAppendingString:appendString];
    
    //4.拼接扩展名
    return [imageName stringByAppendingPathExtension:ext];
}

@end
