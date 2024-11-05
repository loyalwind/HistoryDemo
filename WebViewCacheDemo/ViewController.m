//
//  ViewController.m
//  WebViewCacheDemo
//
//  Created by pengweijian on 2018/4/23.
//  Copyright © 2018年 pengweijian. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
#import "WKWebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"UIWebView" style:UIBarButtonItemStylePlain target:self action:@selector(showUIWebView)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"WKWebView" style:UIBarButtonItemStylePlain target:self action:@selector(showWKWebView)];
    NSLog(@"cache directory---%@", NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]);
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSArray *protocolArray = @[ [MyURLProtocol class] ];
//    configuration.protocolClasses = protocolArray;
}

- (void)showUIWebView
{
    WebViewController *webVc = [[WebViewController alloc] init];
    [self.navigationController pushViewController:webVc animated:YES];
}

- (void)showWKWebView
{
    WKWebViewController *wkWebVc = [[WKWebViewController alloc] init];
    [self.navigationController pushViewController:wkWebVc animated:YES];
}

@end
