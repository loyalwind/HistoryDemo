//
//  Singleton.h
//  ipoker_v1.0
//
//  Created by loyalwindPeng on 2017/8/10.
//  Copyright © 2017年 pengweijian. All rights reserved.
//  单例宏

#ifndef Singleton_h
#define Singleton_h

#define SingleInterface(name) +(instancetype)shared##name;
#if __has_feature(objc_arc)
// ARC下
#define SingleImplementation(name) +(instancetype)shared##name\
{\
    static BOOL hasInited = NO;\
    id obj = [self alloc];\
    if (hasInited) return obj;\
    obj = [obj init];\
    if(obj) hasInited = YES;\
    return obj;\
}\
+ (instancetype)allocWithZone:(struct _NSZone *)zone\
{\
    static id __instance;\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        __instance = [super allocWithZone:zone];\
    });\
    return __instance;\
}\
-(id)copyWithZone:(NSZone *)zone\
{\
    return self;\
}\
-(id)mutableCopyWithZone:(NSZone *)zone\
{\
    return self;\
}

#else
// MRC下
#define SingleImplementation(name) +(instancetype)shared##name\
{\
    static BOOL hasInited = NO;\
    id obj = [self alloc];\
    if (hasInited) return obj;\
    obj = [obj init];\
    if(obj) hasInited = YES;\
    return obj;\
}\
+ (instancetype)allocWithZone:(struct _NSZone *)zone\
{\
    static id __instance;\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        __instance = [super allocWithZone:zone];\
    });\
    return __instance;\
}\
- (id)copyWithZone:(NSZone *)zone\
{\
    return self;\
}\
- (id)mutableCopyWithZone:(NSZone *)zone\
{\
    return self;\
}\
- (oneway void)release\
{}\
- (instancetype)retain\
{\
    return self;\
}\
- (NSUInteger)retainCount\
{\
    return MAXFLOAT;\
}\
+ (id)copyWithZone:(struct _NSZone *)zone\
{\
    return [self shared##name];\
}\
+ (id)mutableCopyWithZone:(struct _NSZone *)zone\
{\
    return [self shared##name];\
}
#endif

#endif /* Singleton_h */
