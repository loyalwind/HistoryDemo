//
//  MemoryUtilsOC.h
//  MapMemory
//
//  Created by 彭维剑 on 2020/10/20.
//  Copyright © 2020 loyalwind. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MemoryUtilsOC : NSObject
+ (void)setStringForKey:(NSString *)key value:(NSString *)value;
+ (void)clearStringForKey:(NSString *)key;
+ (void)clearAll;
+ (NSString *)getStringForKey:(NSString *)key defaultValue:(NSString *)value;
@end

NS_ASSUME_NONNULL_END
