//
//  CGGroupNumberFormat.h
//  currencyLocal
//
//  Created by pengweijian on 2018/10/19.
//  Copyright © 2018 pengweijian. All rights reserved.
//

#import "CGGroupNumberFormat.h"
typedef struct {
    unsigned int index;
    char c;
    unsigned int count;
}SeperatorInfo;


@implementation CGGroupNumberFormat

- (instancetype)init
{
    if (self = [super init]) {
        _decimalSeparator = @".";
        _groupingSeparator = @",";
        _groupingSize = 3;
    }
    return self;
}

- (void)setDecimalSeparator:(NSString *)decimalSeparator
{
    if (decimalSeparator == nil) return;
    _decimalSeparator = decimalSeparator;
}

- (void)setGroupingSeparator:(NSString *)groupingSeparator
{
    if (groupingSeparator == nil) return;
    _groupingSeparator = groupingSeparator;
}

- (NSUInteger)groupingSize
{
    if (_groupingSize < 3) {
        return 3;
    }
    return _groupingSize;
}

- (nullable NSString *)stringFromNumber:(NSNumber *)number
{
    if (!number) return nil;
    
    NSString *string = number.stringValue;
    if ([string rangeOfString:@"."].location != NSNotFound) { // 包含了小数
        NSArray <NSString *> *array = [string componentsSeparatedByString:@"."];
        NSString *imumIntegerDigits = array[0]; // 整数
        NSString *imumFractionDigits = array[1]; // 小数
        NSMutableString *str = [self _handleIntegerDigits:imumIntegerDigits];
        return [str stringByAppendingFormat:@"%@%@",self.decimalSeparator,imumFractionDigits];
    }else{ //不包含了小数
        NSMutableString *str = [self _handleIntegerDigits:string];
        return [NSString stringWithString:str];
    }
}

- (NSMutableString *)_handleIntegerDigits:(NSString *)integerDigits
{
    // 没多少字符一组
    NSUInteger space = self.groupingSize;
    NSUInteger length = integerDigits.length;
    // 分割符的数量
    NSUInteger seperatorNum = (length-0.5)/ space; // 2
    // 第一个分割符的位置
    NSUInteger firstSeperatorPos = length % space; // 1
    // 7522341 --> 7,522,341
    NSMutableString *str = [NSMutableString stringWithString:integerDigits];
    for (int i = 0; i < seperatorNum; i++) {
        NSUInteger pos = firstSeperatorPos + i * (space + self.groupingSeparator.length);
        [str insertString:self.groupingSeparator atIndex:pos];
    }
    return str;
}

- (nullable NSNumber *)numberFromString:(NSString *)string
{
    if (!string) return nil;
    
    NSUInteger length = string.length;

    BOOL isValid = YES;
    SeperatorInfo groupInfos = {0,'\0',0};//malloc(sizeof(SeperatorInfo));
    SeperatorInfo decimalInfos = {0,'\0',0};//malloc(sizeof(SeperatorInfo));
    SeperatorInfo *infos[2];
    reallocf(NULL, 1);
    realloc(NULL, 1);
    infos[1] = malloc(sizeof(SeperatorInfo));
    infos[1] = malloc(sizeof(SeperatorInfo));
    for (int i = 0; i < length; i++) {
        char c = [string characterAtIndex:i];
        if (c == ',' || c == '.' || (c >= '0' && c <= '9')){ // 如果包含了 "0~9"，"," ，"."之外的字符就是无效的字符串
            if (c == ',') {
                groupInfos.index = i;
                groupInfos.c = c;
                groupInfos.count++;
            } else if (c == '.'){
                decimalInfos.index = i;
                decimalInfos.c = c;
                decimalInfos.count++;
            }
                // 校验,和.的个数不能都超过两个
            if (decimalInfos.count >= 2 && groupInfos.count >= 2) {
                isValid = NO;
                break;
            }
        }else{
            isValid = NO;
            break;
        }
    }
    // 23,345,545.235
    if (!isValid) return nil;
    if (groupInfos.index == 0 && decimalInfos.index == 0) { // 说明只包含0-9
        return @(string.integerValue);
    }else if(groupInfos.index < decimalInfos.index){ // 说明最后面包的是.
        if (groupInfos.count == 0) { // 说明前面没有,
            @(string.floatValue);
        }else if (groupInfos.count == decimalInfos.count) {
            
        }else{
        }
    }else{
        
    }

    
//    string = [string stringByReplacingOccurrencesOfString:self.groupingSeparator withString:@""];
//    string = [string stringByReplacingOccurrencesOfString:self.decimalSeparator withString:@""];
//    string.floatValue;
//    if ([string rangeOfString:self.decimalSeparator].location != NSNotFound) { // 包含了小数
//        NSArray <NSString *> *array = [string componentsSeparatedByString:@"."];
//        NSString *imumIntegerDigits = array[0]; // 整数
//        if ([imumIntegerDigits rangeOfString:self.groupingSeparator].location != NSNotFound) { // 包含了分组符号
//
//        }
//
//        NSString *imumFractionDigits = array[1]; // 小数
//    }else{ // 不包含了小数
//
//    }
//
    return nil;
}

@end
