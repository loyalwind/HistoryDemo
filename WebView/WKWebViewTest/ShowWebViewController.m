//
//  ShowWebViewController2.m
//  WKWebViewTest
//
//  Created by pengweijian on 2022/5/17.
//

#import "ShowWebViewController.h"
#import <WebKit/WebKit.h>
#import "MBProgressHUD/MBProgressHUD.h"

@interface ShowWebViewController () <WKNavigationDelegate, WKUIDelegate>
@property (weak, nonatomic) IBOutlet WKWebView *webView;


@end

@implementation ShowWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    NSURLRequest *req = [NSURLRequest requestWithURL:_url];
    [self.webView loadRequest:req];
}

- (void)setupSubView {
    WKWebView *webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor cyanColor];
    webView.frame = self.view.bounds;
    webView.navigationDelegate = self;
    webView.UIDelegate = self;
    webView.insetsLayoutMarginsFromSafeArea = YES;
    if (@available(iOS 11.0, *)){ // iOS11 解决SafeArea的问题
        webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.webView = webView;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"退出" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    [btn sizeToFit];
    btn.frame = CGRectMake(0, 0, 70, 30);
    [btn addTarget:self action:@selector(exitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (IBAction)exitBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showErr:(NSString *)err {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = err;
    [hud hideAnimated:NO afterDelay:1.5];
}

#pragma mark - WKNavigationDelegate
// 打开url时会询问是否允许或者取消导航
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURL *url = navigationAction.request.URL;
    NSLog(@"ShowWebViewController decidePolicyForNavigationAction--%@",url);
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 响应url时会询问是否允许或者取消
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
//    NSString *url = navigationResponse.response.URL.absoluteString;
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 开始导航，及开始加载网页显示
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {}

// 导航出错时调用，及加载网页出错了
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"ShowWebViewController didFailProvisionalNavigation--%@",error.localizedDescription);
    [self showErr:error.localizedDescription];
}

// 网页内容开始显示在页面时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {}

// 网页内容全部显示在页面时调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{}

// 网页内容显示在页面过程中出错时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"ShowWebViewController didFailNavigation--%@",error.localizedDescription);
    [self showErr:error.localizedDescription];
}
#pragma mark - WKUIDelegate
///处理alert事件
//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
//{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:([UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler();
//    }])];
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
//}

//- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler
//{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:([UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler(NO);
//    }])];
//    [alertController addAction:([UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler(YES);
//    }])];
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
//}
//- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler
//{
//    UIAlertController *alertController =[UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField){
//        textField.text = defaultText;
//    }];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler(alertController.textFields[0].text?:@"");
//    }]];
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
//}
@end

