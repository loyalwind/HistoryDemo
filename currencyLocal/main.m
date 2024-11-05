//
//  main.m
//  currencyLocal
//
//  Created by pengweijian on 2018/10/18.
//  Copyright © 2018 pengweijian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "CGGroupNumberFormat.h"

void localCurrency(void);
NSString * test(NSNumber *num);
NSString * test1(NSString *num);
NSString *test0(NSNumber *num);
NSNumber *test01(NSString *num);
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        localCurrency();
    }
    return 0;
}
NSNumber *test01(NSString *num){

//    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@",.\0"];
//    NSRange range = [num rangeOfCharacterFromSet:set];
//    unsigned long length = num.length;
//    int groups = 0;// 记录,的个数
//    int decimals = 0;// 记录.的个数
//    for (int i = 0; i < length; i++) {
//        char c = [num characterAtIndex:i];
//        if (c == ',' || c == '.' || (c >= '0' && c <= '9')){
//            if (c == ',') {
//                groups++;
//            } else if (c == '.'){
//                decimals++;
//            }
//            // 校验,和.的个数不能都超过两个
//            if (groups >= 2 && decimals >= 2) {
//                return nil;
//            }
//        }else{
//            return nil;
//        }
//        NSLog(@"c = %d",c);
//    }
    CGGroupNumberFormat *fmt1 = [[CGGroupNumberFormat alloc] init];
    NSNumber *n1 = [fmt1 numberFromString:num];

//    num = [num stringByReplacingOccurrencesOfString:@"," withString:@""];
//    num = [num stringByReplacingOccurrencesOfString:@"." withString:@""];
//    NSNumber * f = [NSNumber numberWithFloat:num.floatValue];
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    fmt.groupingSeparator = @",";
    fmt.decimalSeparator = @".";
    return [fmt numberFromString:num];;
    

}

NSString *test0(NSNumber *num)
{

    NSArray <NSString *> *array = [num.stringValue componentsSeparatedByString:@"."];
    NSString *a1 = array[0];
    // 没多少字符一组
    NSUInteger space = 3;
    NSUInteger length = a1.length;
    // 分割符的数量
    NSUInteger seperatorNum = (length-0.5)/ space; // 2
    // 第一个分割符的位置
    NSUInteger firstSeperatorPos = length % space; // 1
    // 7522341 --> 7,522,341

    NSMutableString *str = [NSMutableString stringWithString:a1];
    for (int i = 0; i < seperatorNum; i++) {
        NSUInteger pos = firstSeperatorPos + i * space;
        [str insertString:@"," atIndex:pos+i];
    }
//    NSString *a2 = array[1];
    return nil;
}

NSString * test(NSNumber *num){
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
//    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
//    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
//    numberFormatter.currencyGroupingSeparator;
    fmt.groupingSize = 3;
//    numberFormatter
    fmt.usesGroupingSeparator = true;
    fmt.groupingSeparator = @"."; //数字分割的格式
    fmt.decimalSeparator = @",";
//    fmt.alwaysShowsDecimalSeparator = TRUE;
    // 小数位最多位数
    fmt.maximumFractionDigits = 5;
    // 小数位最少位数
    fmt.minimumFractionDigits = 0;
    fmt.roundingMode = kCFNumberFormatterRoundFloor;
    return [fmt stringFromNumber:num];
}

NSString * test1(NSString *num){
    NSNumberFormatter;
    SKProduct *product;
    product.price;
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setLocale:product.priceLocale];
    NSString *formattedString = [numberFormatter stringFromNumber:product.price];
    return nil;
}
void localCurrency()
{
    
}
// 1231231552 1,231,231,552
// NSString *groupSeperator = @",";
// NSString *decimalSeperator = @".";
    //金钱每三位加一个逗号
NSString *countNumAndChangeformat(NSString *num, NSString *groupSeperator, NSString *decimalSeperator)
{
    if([num rangeOfString:@"."].location !=NSNotFound)  {
        NSString *losttotal = [NSString stringWithFormat:@"%.2f",[num floatValue]];//小数点后只保留两位
        NSArray *array = [losttotal componentsSeparatedByString:@"."];
            //小数点前:array[0]
            //小数点后:array[1]
        int count = 0;
        num = array[0];
        long long int a = num.longLongValue;
        while (a != 0)
        {
            count++;
            a /= 10;
        }
        NSMutableString *string = [NSMutableString stringWithString:num];
        NSMutableString *newstring = [NSMutableString string];
        while (count > 3) {
            count -= 3;
            NSRange rang = NSMakeRange(string.length - 3, 3);
            NSString *str = [string substringWithRange:rang];
            [newstring insertString:str atIndex:0];
            [newstring insertString:@"," atIndex:0];
            [string deleteCharactersInRange:rang];
        }
        [newstring insertString:string atIndex:0];
        NSMutableString *newString = [NSMutableString string];
        newString =[NSMutableString stringWithFormat:@"%@.%@",newstring,array[1]];
        return newString;
    }else {
        int count = 0;
        long long int a = num.longLongValue;
        while (a != 0)
        {
            count++;
            a /= 10;
        }
        NSMutableString *string = [NSMutableString stringWithString:num];
        NSMutableString *newstring = [NSMutableString string];
        while (count > 3) {
            count -= 3;
            NSRange rang = NSMakeRange(string.length - 3, 3);
            NSString *str = [string substringWithRange:rang];
            [newstring insertString:str atIndex:0];
            [newstring insertString:@"," atIndex:0];
            [string deleteCharactersInRange:rang];
        }
        [newstring insertString:string atIndex:0];
        return newstring;
    }
}
