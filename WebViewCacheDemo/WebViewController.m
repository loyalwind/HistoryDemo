//
//  WebViewController.m
//  WebViewCacheDemo
//
//  Created by pengweijian on 2018/4/23.
//  Copyright © 2018年 pengweijian. All rights reserved.
//

#import "WebViewController.h"
#import "JWCacheURLProtocol.h"

@interface WebViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [JWCacheURLProtocol startListeningNetWorking];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"UIWebView";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://m.jd.com"]];
    [self.webView loadRequest:request];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清理缓存" style:UIBarButtonItemStylePlain target:self action:@selector(clearWebViewCache)];
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(nonnull NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"----%@",request.URL.absoluteString);
    
    return YES;
}
- (void)clearWebViewCache
{
    [JWCacheURLProtocol removeWebCache];
}
- (void)dealloc
{
    [JWCacheURLProtocol cancelListeningNetWorking];
}
@end
