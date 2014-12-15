//
//  ImageTool.h
//  tuan
//
//  Created by zerd on 14-12-15.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageTool : NSObject

+(void)loadImage:(NSString *)url placeholder:(NSString *)place imageView:(UIImageView *)imageView;

@end
