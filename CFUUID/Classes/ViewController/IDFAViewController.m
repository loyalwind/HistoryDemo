//
//  IDFAViewController.m
//  CFUUID
//
//  Created by pengweijian on 2017/11/16.
//  Copyright © 2017年 pengweijian. All rights reserved.
//

#import "IDFAViewController.h"
#import <AdSupport/AdSupport.h>

@interface IDFAViewController ()
@property (weak, nonatomic) IBOutlet UILabel *idfaLabe;
@property (weak, nonatomic) IBOutlet UILabel *genidfaLabel;

@end

@implementation IDFAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    self.idfaLabe.text = idfa;
    NSLog(@"%@",idfa);
}

- (IBAction)genIDFAAction
{
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    self.genidfaLabel.text = idfa;
    NSLog(@"%@",idfa);
}

/**
 F36E1ABC-5911-43A8-8C7C-F45B7A9F76E4
 471C60B4-2A9D-4041-AB55-16F55C7285EE
 */
@end
