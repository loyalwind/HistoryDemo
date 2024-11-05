//
//  NewViewController.m
//  KBInputView
//
//  Created by loyalwind on 2018/3/9.
//  Copyright © 2018年 pengweijian. All rights reserved.
//

#import "NewViewController.h"
#import "PKNativeServeWindowManager.h"
#import "PKInputViewController.h"
#import <CommonCrypto/CommonDigest.h>


@interface NewViewController ()


@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[PKNativeServeWindowManager sharedManager] registerViewController:[PKInputViewController class]];
//    self.tableView.estimatedRowHeight = 0;
    if (@available(iOS 11.0, *)) {
        NSLog(@"%s",__FUNCTION__);
        //当有heightForHeader delegate时设置
//        self.tableView.estimatedSectionHeaderHeight = 0;
//        //当有heightForFooter delegate时设置
//        self.tableView.estimatedSectionFooterHeight = 0;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

}

- (IBAction)callKeyBoard:(id)sender {
    NSDictionary *param = @{@"ee":@"ds"};
//    PKInputViewController *vc = [[PKInputViewController alloc] init];
//    vc.param = @{@"ee":@"ds"};
//    [self presentViewController:vc animated:YES completion:nil];
    PKNativeServeWindowData *data = [PKNativeServeWindowData dataWithClass:[PKInputViewController class] param:param animated:NO reCreat:YES];
    [[PKNativeServeWindowManager sharedManager] showViewController:data completion:^(UIViewController<PKNativeServeWindowViewControllerDelegate> *vc) {
    
//        NSLog(@"%zd",[((PKInputViewController *)vc).textView becomeFirstResponder]);
    }];
}
@end
