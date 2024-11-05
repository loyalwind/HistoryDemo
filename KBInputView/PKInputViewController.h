//
//  PKInputViewController.h
//  KBInputView
//
//  Created by loyalwind on 2018/3/2.
//  Copyright © 2018年 pengweijian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKNativeUIDelegate.h"
@class PKInputViewController;

@protocol PKInputViewControllerDelegate <NSObject>
@optional
- (void)inputViewController:(PKInputViewController *)viewController inputedText:(NSString *)text;
- (void)inputViewController:(PKInputViewController *)viewController inputingText:(NSString *)text;
- (void)inputViewControllerGiveupInput:(PKInputViewController *)viewController;
@end


@interface PKInputViewController : UIViewController<PKNativeUIDelegate>
@property (weak, nonatomic) id<PKInputViewControllerDelegate> delegate;
- (void)setSendBtnText:(NSString *)text;
- (void)beginInput;
@end
