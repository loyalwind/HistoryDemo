//
//  PKInputViewController.m
//  KBInputView
//
//  Created by loyalwind on 2018/3/2.
//  Copyright © 2018年 pengweijian. All rights reserved.
//

#import "PKInputViewController.h"
#import "PKNativeServeWindowManager.h"

@interface PKInputViewController ()
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *inputContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerBottomCons;
@end

@implementation PKInputViewController
@synthesize param = _param;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.8];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitKeyBoard)];
    [self.view addGestureRecognizer:tap];
    self.doneButton.titleLabel.adjustsFontSizeToFitWidth = YES;
//    self.inputContainerView.hidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
//    [self.textView performSelectorOnMainThread:@selector(becomeFirstResponder) withObject:nil waitUntilDone:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     NSLog(@"----%zd",[self.textView becomeFirstResponder]);
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

   
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (IBAction)changeSendBtnText
{
    static int index = 0;
    if (index % 2) {
        [self setSendBtnText:@"发送"];
    }else{
        [self setSendBtnText:@"Send Message"];
    }
    index++;
}

/**
 退出输入
 */
- (IBAction)exitInputView
{
    [self.view endEditing:YES];
    [[PKNativeServeWindowManager sharedManager] hiddenServeWindow:^{
        NSLog(@"%@",self.textView.text);
    }];
}
- (void)setSendBtnText:(NSString *)text
{
    [self.doneButton setTitle:text forState:UIControlStateNormal];
}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    CGRect kbFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.containerBottomCons.constant = self.view.frame.size.height - kbFrame.origin.y;
    NSLog(@"%@",NSStringFromCGRect(kbFrame));
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

/**
 退出键盘
 */
- (void)exitKeyBoard
{
    [self.textView becomeFirstResponder];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
