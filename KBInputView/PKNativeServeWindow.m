//
//  PKNativeServeWindow.m
//  KBInputView
//
//  Created by loyalwind on 2018/3/9.
//  Copyright © 2018年 pengweijian. All rights reserved.
//

#import "PKNativeServeWindow.h"
#import "PKNativeServeWindowViewControllerDelegate.h"

@implementation PKNativeServeWindow
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.windowLevel = [UIApplication sharedApplication].keyWindow.windowLevel + 2;
        self.backgroundColor = [UIColor clearColor];
        self.rootViewController = [[UIViewController alloc] init];
    }
    return self;
}

- (void)showViewController:(UIViewController <PKNativeServeWindowViewControllerDelegate>*)vc animated:(BOOL)animated completion:(void (^)(void))completion
{
    if (!vc)return;
    self.hidden = NO;
    [self.rootViewController presentViewController:vc animated:animated completion:^{
        NSLog(@"modal finised %@",vc);
        completion ? completion() : nil;
    }];
}
- (BOOL)canBecomeFirstResponder
{
    NSLog(@"----");
    return YES;
}

- (void)hiddenCompletion:(void (^)(void))completion
{
    [self.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:^{
        self.hidden = YES;
        NSLog(@"dismiss finised");
        completion ? completion() : nil;
    }];
}

@end
