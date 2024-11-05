//
//  PKInputViewController.h
//  KBInputView
//
//  Created by loyalwind on 2018/3/2.
//  Copyright © 2018年 pengweijian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKNativeServeWindowViewControllerDelegate.h"

@interface PKInputViewController : UIViewController<PKNativeServeWindowViewControllerDelegate>
@property (weak, nonatomic, readonly) UITextView *textView;
@property (weak, nonatomic, readonly) UIButton *doneButton;
- (void)setSendBtnText:(NSString *)text;
@end
