//
//  AppDelegate.m
//  WKWebViewTest
//
//  Created by pengweijian on 2022/5/17.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [self setupRootViewController];
    return YES;
}

- (void)setupRootViewController
{
    window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    ViewController *rooVc = [[ViewController alloc] init];
    rooVc.wantsFullScreenLayout = YES;
    [window setRootViewController:rooVc];
    
    [window makeKeyAndVisible];
    [UIApplication sharedApplication].statusBarHidden = YES;
    // 设置关闭自动息屏
    [UIApplication sharedApplication].idleTimerDisabled = YES;
}

#pragma mark - UISceneSession lifecycle

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskLandscape;
}

@end
