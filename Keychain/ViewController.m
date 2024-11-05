//
//  ViewController.m
//  Keychain
//
//  Created by pengweijian on 2020/4/30.
//  Copyright © 2020 loyalwind. All rights reserved.
//

#import "ViewController.h"
#import "DeviceState.h"
#import "KeychainItem.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    KeychainItem *item = [[KeychainItem alloc] initWithService:KeychainItem.defaultService account:KeychainItem.defaultAccount accessGroup:nil];
    [item saveItem:@"avd-ers=22"];
    NSString *udi = [KeychainItem currentUserIdentifier];
    NSLog(@"==>%@", @"udi");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSString *uuid = [DeviceState uuid];
    NSString *bid = [NSBundle mainBundle].bundleIdentifier;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:bid message:uuid delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alert show];
//    6e5ad39ff3c850a7ddb1e2e3b1a0ad75d71edc9a
}

@end
