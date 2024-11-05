//
//  PKInputViewController.m
//  KBInputView
//
//  Created by loyalwind on 2018/3/2.
//  Copyright © 2018年 pengweijian. All rights reserved.
//

#import "PKInputViewController.h"
#import "PKNativeUIManager.h"
#include <cstring>

@interface PKInputViewController ()<UITextViewDelegate,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *inputContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerBottomCons;
@property (weak, nonatomic) IBOutlet UIView *textContainerView;
/// 正在旋转方向
@property (nonatomic, assign) BOOL rotatingOrientation;
@property (weak, nonatomic) UIControl *maskControl;

@end

@implementation PKInputViewController

@synthesize param = _param;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.frame = [UIScreen mainScreen].bounds;
    [self setupView];
//    self.inputContainerView.hidden = YES;
    self.clearButton.hidden = YES;
    self.doneButton.hidden = YES;
    // 键盘frame变化的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)setupView
{
    self.rotatingOrientation = NO;
    self.view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    
//    UIControl *maskControl = [[UIControl alloc] init];
//    [self.view insertSubview:maskControl atIndex:0];
//    maskControl.translatesAutoresizingMaskIntoConstraints = NO;
//    maskControl.hidden = NO;
//    maskControl.userInteractionEnabled = YES;
//    NSMutableArray *constraints = [NSMutableArray array];
//    NSString *hVFL = @"H:|-0-[maskControl]-0-|";
//    NSArray *hCons = [NSLayoutConstraint constraintsWithVisualFormat:hVFL options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(maskControl)];
//    [constraints addObjectsFromArray:hCons];
//    NSString *vVFL = @"V:|-0-[maskControl]-0-|";
//    NSArray *vCons = [NSLayoutConstraint constraintsWithVisualFormat:vVFL options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(maskControl)];
//    [constraints addObjectsFromArray:vCons];
//    [maskControl addTarget:self action:@selector(backgroundClick) forControlEvents:UIControlEventTouchUpInside];
//    _maskControl = maskControl;
//    [self.view addConstraints:constraints];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitKeyBoard:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
    self.doneButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.textContainerView.layer.cornerRadius = 5.0;
    self.textContainerView.layer.masksToBounds = YES;
    self.textContainerView.backgroundColor = [UIColor whiteColor];
    
    self.inputContainerView.backgroundColor = [UIColor clearColor];
    self.textView.textColor = [UIColor blackColor];
}

- (void)setParam:(NSDictionary *)param
{
    _param = param.copy;
}

#pragma mark - 旋转相关的delegate
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    self.rotatingOrientation = YES;
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    self.rotatingOrientation = NO;
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

#pragma mark - 按钮点击事件
- (IBAction)clearButtonAction
{
    self.textView.text = @"";
    self.clearButton.hidden = YES;
}

- (IBAction)backButtonAction
{
    // 隐藏该输入控制器
    [[PKNativeUIManager sharedManager] hiddenServeWindow:^{
        // 通知代理放弃输入
        if ([self.delegate respondsToSelector:@selector(inputViewControllerGiveupInput:)]) {
            [self.delegate inputViewControllerGiveupInput:self];
        }
    }];
    // 退出键盘
    [self.view endEditing:YES];
}
- (IBAction)doneButtonAction
{
    // 隐藏该输入控制器
    [[PKNativeUIManager sharedManager] hiddenServeWindow:^{
        // 通知代理输入完成
        if ([self.delegate respondsToSelector:@selector(inputViewController:inputedText:)]) {
            [self.delegate inputViewController:self inputedText:self.textView.text];
        }
    }];
    // 退出键盘
    [self.view endEditing:YES];
}

///** 退出键盘 */
- (void)exitKeyBoard:(UITapGestureRecognizer *)tap
{
    NSLog(@"%s",__func__);
    // 在输入容器内的单击，不需要退键盘
//    CGPoint point = [tap locationInView:self.inputContainerView];
//    if (CGRectContainsPoint(self.inputContainerView.bounds, point)) return;
//    [self backButtonAction];
}

- (void)setSendBtnText:(NSString *)text
{
    [self.doneButton setTitle:text forState:UIControlStateNormal];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__func__);
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    NSLog(@"%s",__func__);
    // 在输入容器内的单击，不需要该touch事件，会把事件传递给上一级
    CGPoint point = [touch locationInView:self.inputContainerView];
    BOOL receive = CGRectContainsPoint(self.inputContainerView.bounds, point);
    return  !receive;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.clearButton.hidden = textView.text.length <= 0;
}
- (void)textViewDidChange:(UITextView *)textView
{
    self.clearButton.hidden = textView.text.length <= 0;
    NSInteger maxLength = 20;// [_param[@"maxLength"] integerValue];
    if (maxLength == -1) {
        return;
    }
    NSString *text = textView.text;
    if (text.length > maxLength){
        const char* text_ = [text cStringUsingEncoding:NSUTF8StringEncoding];
        char* buffer = new char[std::strlen(text_)+1];
        std::strcpy(buffer, text_);
        buffer[maxLength] = 0;
        NSString *value = [[NSString alloc] initWithUTF8String:buffer];
        if (!value || value.length == 0) {
            value = [text substringToIndex:maxLength];
        }
        textView.text = value;
        delete [] buffer;
    }
    // 通知代理输入变化
    if ([self.delegate respondsToSelector:@selector(inputViewController:inputingText:)]) {
        [self.delegate inputViewController:self inputingText:textView.text];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@""]) { // delete
        return YES;
    }
    if (textView.isFirstResponder) { // emoji
        
        if (textView.textInputMode.primaryLanguage == nil || [textView.textInputMode.primaryLanguage isEqualToString:@"emoji"] ) {
            // In fact, in iOS7, 'textView.textInputMode.primaryLanguage' is nil
            return NO;
        }
    }
    return YES;
}

#pragma mark - NSNotification
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 如果view不在窗口上，那么不需要进行键盘变化
    if (!self.view.window) return;
    // 屏幕正在旋转也不用调整
    if (self.rotatingOrientation) return;
    
    // 键盘结束时的frame
    CGRect kbFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 计算底部约束
    CGFloat cons = self.view.frame.size.height - kbFrame.origin.y;
    self.containerBottomCons.constant = cons;
    NSLog(@"kbFrame=%@;self.view.frame=%@;cons=%.2f",NSStringFromCGRect(kbFrame),NSStringFromCGRect(self.view.frame),cons);
    // 动画过渡
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        [self.view layoutIfNeeded];;
    }];
}
- (void)beginInput
{
    [self.textView becomeFirstResponder];
}
- (void)backgroundClick
{
    NSLog(@"%s",__func__);
}
- (void)dealloc
{
    NSLog(@"dealloc--%@",self);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
