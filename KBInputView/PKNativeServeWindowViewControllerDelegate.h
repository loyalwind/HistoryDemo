//
//  PKNativeServeWindowViewControllerDelegate.h
//  KBInputView
//
//  Created by pengweijian on 2018/3/12.
//  Copyright © 2018年 pengweijian. All rights reserved.
//

#ifndef PKNativeServeWindowViewControllerDelegate_h
#define PKNativeServeWindowViewControllerDelegate_h

#import <Foundation/Foundation.h>
@protocol PKNativeServeWindowViewControllerDelegate <NSObject>

@property(nonatomic, strong) NSDictionary *param;

@end

#define PKPreDefineViewControllerClass Class<PKNativeServeWindowViewControllerDelegate>
#define PKPreDefineViewControllerObjc UIViewController<PKNativeServeWindowViewControllerDelegate>



#endif /* PKNativeServeWindowViewControllerDelegate_h */
