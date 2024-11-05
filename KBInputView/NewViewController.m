//
//  NewViewController.m
//  KBInputView
//
//  Created by loyalwind on 2018/3/9.
//  Copyright © 2018年 pengweijian. All rights reserved.
//

#import "NewViewController.h"
#import "PKNativeUIManager.h"
#import "PKInputViewController.h"
#import <CommonCrypto/CommonDigest.h>

@interface NewViewController ()<PKInputViewControllerDelegate>


@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[PKNativeUIManager sharedManager] registerViewController:[PKInputViewController class]];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoard)];
//    [self.view addGestureRecognizer:tap];
    
}
- (IBAction)close:(id)sender
{
    NSLog(@"-------closeClick%@",sender);
}


- (IBAction)callKeyBoard:(id)sender {
    NSDictionary *param = @{@"ee":@"ds"};
//    vc.param = @{@"ee":@"ds"};
    PKNativeServeWindowData *data = [PKNativeServeWindowData dataWithClass:[PKInputViewController class] param:param reCreat:YES];
    [[PKNativeUIManager sharedManager] showViewController:data completion:^(UIViewController<PKNativeUIDelegate> *vc) {
        ((PKInputViewController *)vc).delegate = self;
        [(PKInputViewController *)vc beginInput];
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__func__);
}
- (void)closeKeyBoard
{
    NSLog(@"-------closeKeyBoard");
//    [self.view endEditing: YES];
}
- (void)inputViewController:(PKInputViewController *)viewController inputedText:(NSString *)text
{
    NSLog(@"----%@",text);
}
@end
