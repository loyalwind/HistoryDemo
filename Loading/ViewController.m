//
//  ViewController.m
//  Loading
//
//  Created by 彭维剑 on 2020/8/14.
//  Copyright © 2020 loyalwind. All rights reserved.
//

#import "ViewController.h"
#import "PKLoadingView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(50, 100, 100, 100);
    [btn addTarget:self action:@selector(showLoading) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showLoading
{
    [[PKLoadingView sharedLoading] show];
}
@end
