//
//  WKWebViewController.m
//  WebViewCacheDemo
//
//  Created by pengweijian on 2018/4/23.
//  Copyright © 2018年 pengweijian. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import "JWCacheURLProtocol.h"

@interface WKWebViewController ()

@property (weak, nonatomic) IBOutlet WKWebView *wkWebView;
@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"WKWebView";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清理缓存" style:UIBarButtonItemStylePlain target:self action:@selector(clearWebViewCache)];
}
- (void)clearWebViewCache
{
    [JWCacheURLProtocol removeWebCache];
}
@end
