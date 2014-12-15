//
//  ImageTool.m
//  tuan
//
//  Created by zerd on 14-12-15.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "ImageTool.h"
#import "UIImageView+WebCache.h"

@implementation ImageTool

+(void)loadImage:(NSString *)url placeholder:(NSString *)place imageView:(UIImageView *)imageView{
    [imageView sd_setImageWithURL:[NSURL URLWithString:url]
                 placeholderImage:[UIImage imageNamed:place]
                          options:SDWebImageLowPriority | SDWebImageRetryFailed];
}

@end
