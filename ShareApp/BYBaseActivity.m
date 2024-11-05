//
//  BYBaseActivity.m
//  Deal4K
//
//  Created by pengweijian on 2017/7/11.
//  Copyright © 2017年 pengweijian. All rights reserved.
//

#import "BYBaseActivity.h"

static NSString const *title_ = nil;
static UIImage const *image_ = nil;
static NSURL const *url_ = nil;

@implementation BYBaseActivity
// override methods
+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

- (NSString *)activityType
{
    return [NSString stringWithFormat:@"com.bingdian.activity.%@",NSStringFromClass(self.classForCoder)];
}

/**
 返回是否可以执行
 - parameter activityItems: 从调用处传进来的items，可以通过这个items里面存放的类型数据来判断是否可以执行
 - returns: 返回true，则这个activity就会在controller上出现；否则，则不会出现
 */
- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    //只要items有数据，就返回true
    return activityItems.count > 0;
}

/**
 准备数据
 - parameter activityItems: 数据对象数组
 */
- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    for (id activityItem in activityItems) {
        if ([activityItem isKindOfClass:[NSString class]]) {
            title_ = activityItem;
        } else if ([activityItem isKindOfClass:[UIImage class]]) {
            image_ = activityItem;
        } else if ([activityItem isKindOfClass:[NSURL class]]) {
            url_ = activityItem;
        }
    }
}

/**
 执行点击
 */

- (void)performActivity
{
    [super performActivity];
    NSLog(@"title - %@", title_);
    NSLog(@"image - %@", image_);
    NSLog(@"url - %@", url_);
}
@end
