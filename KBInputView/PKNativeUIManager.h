//
//  PKNativeUIManager.h
//  KBInputView
//
//  Created by loyalwind on 2018/3/9.
//  Copyright © 2018年 pengweijian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKNativeUIDelegate.h"


#define SafeExecuteBlock(block,...) block ? block(##__VA_ARGS__) : nil;

@interface PKNativeServeWindowData : NSObject
/** 指定遵守协议的UIVIewController类型的类对象 */
@property (nonatomic, assign, readonly) PKPreDefineViewControllerClass vcClass;
/** 是否重新创建 默认：NO */
@property (nonatomic, assign, readonly, getter=isReCreat) BOOL reCreat;
/** 是否有动画出现 默认：NO */
//@property (nonatomic, assign, readonly, getter=isAnimated) BOOL animated;
/** 其他参数 */
@property (nonatomic, strong, readonly) NSDictionary *param;

+ (instancetype)dataWithClass:(PKPreDefineViewControllerClass)vcClass param:(NSDictionary *)param reCreat:(BOOL)reCreat;

- (instancetype)initWithClass:(PKPreDefineViewControllerClass)vcClass param:(NSDictionary *)param reCreat:(BOOL)reCreat;

@end


@interface PKNativeUIManager : NSObject
+ (instancetype)sharedManager;

- (void)registerViewController:(PKPreDefineViewControllerClass)vcClass;

- (void)registerViewControllers:(NSArray <PKPreDefineViewControllerClass> *)vcClses;

- (void)cancelRegisterViewController:(PKPreDefineViewControllerClass)vcClass;

- (void)cancelRegisterViewControllers:(NSArray <PKPreDefineViewControllerClass> *)vcClses;

- (void)showViewController:(PKNativeServeWindowData *)data completion:(void (^)(PKPreDefineViewControllerObjc *))completion;

- (void)hiddenServeWindow:(void (^)(void))completion;
@end


