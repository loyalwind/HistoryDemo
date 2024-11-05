//
//  MemoryUtilsOC.m
//  MapMemory
//
//  Created by 彭维剑 on 2020/10/20.
//  Copyright © 2020 loyalwind. All rights reserved.
//

#import "MemoryUtilsOC.h"
#include "ByMemoryUtils.h"

@implementation MemoryUtilsOC
+ (void)setStringForKey:(NSString *)key value:(NSString *)value
{
    by::MemoryUtils::getInstance()->setStringForKey(key.UTF8String, value.UTF8String);
}
+ (void)clearStringForKey:(NSString *)key
{
    by::MemoryUtils::getInstance()->clearStringForKey(key.UTF8String);
}
+ (void)clearAll
{
    by::MemoryUtils::getInstance()->clearAll();
}
+ (NSString *)getStringForKey:(NSString *)key defaultValue:(NSString *)value
{
    std::string v = by::MemoryUtils::getInstance()->getStringForKey(key.UTF8String, value.UTF8String);
    return @(v.c_str());
}
@end
