//
//  Singleton.h
//  微博
//
//  Created by zerd on 14-10-19.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#ifndef ___Singleton_h
#define ___Singleton_h

//.h
#define singleton_interface(class) + (class *)shared##class;

//.m
#define singleton_implementation(class) \
static class *_instance;\
\
+ (class *)shared##class\
{\
    if (_instance == nil) {\
        _instance = [[self alloc]init];\
    }\
    return _instance;\
}\
\
+(instancetype)allocWithZone:(NSZone *)zone\
{\
    static dispatch_once_t once_token;\
    dispatch_once(&once_token, ^{\
        _instance = [super allocWithZone:zone];\
    });\
    \
    return _instance;\
}

#endif
