//
//  Singleton.h
//  ipoker_v1.0
//
//  Created by loyalwindPeng on 2017/8/10.
//  Copyright © 2017年 pengweijian. All rights reserved.
//

#ifndef Singleton_h
#define Singleton_h

#define SingleInterface(name) +(instancetype)share##name;
#if __has_feature(objc_arc)
// ARC下
#define SingleImplementation(name) +(instancetype)share##name\
{\
    return [[self alloc] init];\
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
#define SingleImplementation(name) +(instancetype)share##name\
{\
return [[self alloc] init];\
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
}
#endif

#endif /* Singleton_h */
