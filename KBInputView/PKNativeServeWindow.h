//
//  PKNativeServeWindow.h
//  KBInputView
//
//  Created by loyalwind on 2018/3/9.
//  Copyright © 2018年 pengweijian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKNativeServeWindowViewControllerDelegate.h"

@interface PKNativeServeWindow : UIWindow

- (void)showViewController:(PKPreDefineViewControllerObjc *)vc animated:(BOOL)animated completion:(void (^)(void))completion;

- (void)hiddenCompletion:(void (^)(void))completion;
@end
