//
//  ViewController.m
//  KBInputView
//
//  Created by loyalwind on 2018/3/1.
//  Copyright © 2018年 pengweijian. All rights reserved.
//

#import "ViewController.h"
#import "PKInputViewController.h"

@interface ViewController ()
@property (weak, nonatomic) PKInputViewController *inputVc;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
}
- (PKInputViewController *)inputVc
{
    if (!_inputVc) {
        PKInputViewController *inputVc = [[PKInputViewController alloc] init];
        [self addChildViewController:inputVc];
        [self.view addSubview:inputVc.view];
        inputVc.view.translatesAutoresizingMaskIntoConstraints = NO;
        NSMutableArray *constraints = [NSMutableArray array];
        UIView *subView = inputVc.view;
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[subView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(subView)]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[subView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(subView)]];
        [self.view addConstraints:constraints];
        
        _inputVc = inputVc;
    }
    return _inputVc;
}

- (IBAction)callKeyBoard:(id)sender
{
    self.inputVc.view.hidden = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        BOOL ret = [self.inputVc.textView becomeFirstResponder];
//        NSLog(@"%d",ret);
    });
}

@end
