//
//  IDFVViewController.m
//  CFUUID
//
//  Created by pengweijian on 2017/11/16.
//  Copyright © 2017年 pengweijian. All rights reserved.
//

#import "IDFVViewController.h"
#import "BYNavigationController.h"
#import "UUIDViewController.h"

@interface IDFVViewController ()<CALayerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *idfvLabe;
@property (weak, nonatomic) IBOutlet UILabel *genidfvLabel;
@property (weak, nonatomic) CALayer *redLayer;
@end

@implementation IDFVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"viewDidLoad-push");
    NSString *idfv = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    self.idfvLabe.text = idfv;
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = CGRectMake(0, 0, 300, 300);
    NSLog(@"%@",idfv);
    CALayer *redLayer = [CALayer layer];
    redLayer.backgroundColor = [UIColor redColor].CGColor;
    redLayer.frame = CGRectMake(200, 500, 100, 100);
    [self.view.layer addSublayer:redLayer];
    CATransition *trasition = [CATransition animation];
    trasition.type = kCATransitionPush;
    trasition.subtype = kCATransitionFromRight;
    redLayer.actions = @{@"backgroundColor":trasition};
    _redLayer = redLayer;
}
- (IBAction)genIDFVAction
{
//    NSString *idfv = [[UIDevice currentDevice] identifierForVendor].UUIDString;
//    self.genidfvLabel.text = idfv;
//    NSLog(@"%@",idfv);
//    [CATransaction begin];
//    [CATransaction setDisableActions:YES];
//    self.redLayer.frame = CGRectMake(50 + arc4random_uniform(150), 200+arc4random_uniform(100), 50+arc4random_uniform(40), 50+arc4random_uniform(40));
    CGFloat red = arc4random_uniform(255)/255.0;
    CGFloat green = arc4random_uniform(255)/255.0;
    CGFloat blue = arc4random_uniform(255)/255.0;
    self.redLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
}

- (nullable id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event
{
    return [NSNull null];
}
- (void)dealloc
{
     NSLog(@"%@", self.navigationController);
}
/**
 7CBB8D93-8F5A-447F-8A40-3F49092B0A9E
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%@",self.view.superview);
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%@",self.view.superview);
}
@end
