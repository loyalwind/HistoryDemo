//
//  PKNativeUIDelegate.h
//  KBInputView
//
//  Created by loyalwind on 2018/3/12.
//  Copyright © 2018年 pengweijian. All rights reserved.
//

#ifndef PKNativeUIDelegate_h
#define PKNativeUIDelegate_h

#import <Foundation/Foundation.h>
@protocol PKNativeUIDelegate <NSObject>

@property(nonatomic, copy) NSDictionary *param;

@end

#define PKPreDefineViewControllerClass Class<PKNativeUIDelegate>
#define PKPreDefineViewControllerObjc UIViewController<PKNativeUIDelegate>



#endif /* PKNativeUIDelegate_h */
