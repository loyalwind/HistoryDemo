//
//  CGGroupNumberFormat.h
//  currencyLocal
//
//  Created by pengweijian on 2018/10/19.
//  Copyright © 2018 pengweijian. All rights reserved.
//  对数字进行分组，比如 123455 -> 123,455 或者123455 -> 123.455； 123455.98 -> 123,455.98或者123455.98 -> 123.455,98；

#import <Foundation/Foundation.h>
    //  12,134,255.98 nil;
NS_ASSUME_NONNULL_BEGIN

@interface CGGroupNumberFormat : NSObject
@property (null_resettable, nonatomic, copy) NSString *decimalSeparator; // default is "."
@property (null_resettable, nonatomic, copy) NSString *groupingSeparator;// default is ","
@property (nonatomic, assign) NSUInteger groupingSize; // default is 3 , and minnum is 3
- (nullable NSString *)stringFromNumber:(NSNumber *)number;
- (nullable NSNumber *)numberFromString:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
