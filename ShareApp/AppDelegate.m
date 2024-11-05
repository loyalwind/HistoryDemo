//
//  AppDelegate.m
//  Deal4K
//
//  Created by pengweijian on 2017/6/26.
//  Copyright © 2017年 pengweijian. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
  
//    NSMutableArray<UIApplicationShortcutItem *> *existingShortcutItems = (NSMutableArray *)[[UIApplication sharedApplication] shortcutItems];
//    UIApplicationShortcutItem *anExistingShortcutItem = [existingShortcutItems objectAtIndex:0];
//    NSMutableArray <UIApplicationShortcutItem *> *updatedShortcutItems = [existingShortcutItems mutableCopy];
//    UIMutableApplicationShortcutItem *aMutableShortcutItem = [anExistingShortcutItem mutableCopy];
//    [aMutableShortcutItem setLocalizedTitle: @"New Title"];
//    [updatedShortcutItems replaceObjectAtIndex:0 withObject: aMutableShortcutItem];
//    [[UIApplication sharedApplication] setShortcutItems: updatedShortcutItems];
    UIApplicationShortcutItem *shortcutItem = launchOptions[UIApplicationLaunchOptionsShortcutItemKey];
    NSLog(@"%@",shortcutItem);
    if (shortcutItem) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
            view.backgroundColor = [UIColor redColor];
            [self.window addSubview:view];
        });
        [self handerShortcutItem:shortcutItem];
        return NO;
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(200, 50, 100, 100)];
            view.backgroundColor = [UIColor greenColor];
            [self.window addSubview:view];
        });
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    [self handerShortcutItem:shortcutItem];
}
- (void)handerShortcutItem:(UIApplicationShortcutItem *)shortcutItem
{
    if ([shortcutItem.type isEqualToString:@"com.ipoker.share"])
    {
        // do something ...
        NSLog(@"分享");
        NSMutableArray *items = [NSMutableArray array];
        [items addObject:@"hahaha"];
        UIImage *img = [UIImage imageNamed:@"AppIcon60x60"];
        if (img) [items addObject:img];
        NSURL *url = [NSURL URLWithString:@"www.baidu.com"];
        [items addObject:url];
        UIActivityViewController *activityVc = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
        
        activityVc.excludedActivityTypes = @[UIActivityTypePostToTwitter,
                                             UIActivityTypePostToWeibo,
//                                             UIActivityTypeMessage,
                                             UIActivityTypeMail,
                                             UIActivityTypePrint,
                                             UIActivityTypeCopyToPasteboard,
                                             UIActivityTypeAssignToContact,
                                             UIActivityTypeSaveToCameraRoll,
                                             UIActivityTypeAddToReadingList,
//                                             UIActivityTypePostToFlickr,
                                             UIActivityTypePostToVimeo,
                                             UIActivityTypePostToTencentWeibo,
                                             UIActivityTypeOpenInIBooks
                                             ];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.window.rootViewController presentViewController:activityVc animated:YES completion:nil];
        });
        [activityVc setCompletionWithItemsHandler:^(UIActivityType activityType, BOOL completed, NSArray *returnedItems, NSError *activityError){
            NSLog(@"===%@",activityType);
        }];

    }
    else if ([shortcutItem.type isEqualToString:@"com.ipoker.quickGame"])
    {   
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"启动程序222" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"取消", nil];
        [alert show];
        
    }
    // ...
}

@end
