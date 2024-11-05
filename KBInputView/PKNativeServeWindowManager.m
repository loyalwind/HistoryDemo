//
//  PKNativeServeWindowManager.m
//  KBInputView
//
//  Created by pengweijian on 2018/3/9.
//  Copyright © 2018年 pengweijian. All rights reserved.
//

#import "PKNativeServeWindowManager.h"
#import "PKNativeServeWindow.h"
#import <UIKit/UIKit.h>

@interface PKNativeServeWindowData ()

@property (nonatomic, assign,) PKPreDefineViewControllerClass vcClass;
@property (nonatomic, assign, getter=isReCreat) BOOL reCreat;
@property (nonatomic, strong) NSDictionary *param;

@end

@implementation PKNativeServeWindowData

+ (instancetype)dataWithClass:(PKPreDefineViewControllerClass)vcClass param:(NSDictionary *)param animated:(BOOL)animated reCreat:(BOOL)reCreat
{
    return [[self alloc] initWithClass:vcClass param:param animated:animated reCreat:reCreat];
}
- (instancetype)initWithClass:(PKPreDefineViewControllerClass)vcClass param:(NSDictionary *)param animated:(BOOL)animated reCreat:(BOOL)reCreat
{
    if (self = [super init]) {
        _vcClass = vcClass;
        _reCreat = reCreat;
        _animated = animated;
        _param = param;
    }
    return self;
}
@end


@interface PKNativeServeWindowManager ()
@property(nonatomic, strong) NSMutableDictionary <NSString *, PKPreDefineViewControllerClass> *vcClassMap;
@property(nonatomic, strong) NSMutableDictionary <NSString *, PKPreDefineViewControllerObjc *> *vcObjcMap;
@property(nonatomic, strong) PKNativeServeWindow *nativeServeWindow;
@end

static PKNativeServeWindowManager *_instance = nil;
@implementation PKNativeServeWindowManager
+ (void)initialize
{
    [PKNativeServeWindowManager sharedManager].nativeServeWindow.hidden = YES;
}
+ (instancetype)sharedManager
{
    if (_instance) return _instance;
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (PKNativeServeWindow *)nativeServeWindow
{
    if (!_nativeServeWindow) {
        _nativeServeWindow = [[PKNativeServeWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _nativeServeWindow;
}

- (NSMutableDictionary<NSString *, PKPreDefineViewControllerClass> *)vcClassMap
{
    if (!_vcClassMap) {
        _vcClassMap = [NSMutableDictionary dictionary];
    }
    return _vcClassMap;
}

- (NSMutableDictionary<NSString *, PKPreDefineViewControllerObjc *> *)vcObjcMap
{
    if (!_vcObjcMap) {
        _vcObjcMap = [NSMutableDictionary dictionary];
    }
    return _vcObjcMap;
}

- (void)registerViewController:(PKPreDefineViewControllerClass)vcClass
{
    if (![self _conformsPreDefineCondition:vcClass]) return;
    self.vcClassMap[NSStringFromClass(vcClass)] = vcClass;
    
}
- (void)registerViewControllers:(NSArray <PKPreDefineViewControllerClass> *)vcClses
{
    for (Class cls in vcClses) {
        [self registerViewController:cls];
    }
}
- (void)cancelRegisterViewController:(PKPreDefineViewControllerClass)vcClass
{
    if (![self _conformsPreDefineCondition:vcClass]) return;
    [self.vcClassMap removeObjectForKey:NSStringFromClass(vcClass)];
}
- (void)cancelRegisterViewControllers:(NSArray <PKPreDefineViewControllerClass> *)vcClses
{
    for (Class cls in vcClses) {
        [self cancelRegisterViewController:cls];
    }
}

- (void)showViewController:(PKNativeServeWindowData *)data completion:(void (^)(PKPreDefineViewControllerObjc *))completion
{
    if (!data) {
        completion ? completion(nil) : nil;
        return;
    }
    if (![self _conformsPreDefineCondition:data.vcClass]) return;
  
    if (!self.vcClassMap[NSStringFromClass(data.vcClass)]) return;
    
    PKPreDefineViewControllerObjc *viewController = nil;
    if (data.isReCreat) { // 需要重新创建这个控制器
        [self.vcObjcMap removeObjectForKey:NSStringFromClass(data.vcClass)];
        viewController = [[(Class)data.vcClass alloc] init];
        self.vcObjcMap[NSStringFromClass(data.vcClass)] = viewController;
    }else{
        PKPreDefineViewControllerObjc *tempVc = self.vcObjcMap[NSStringFromClass(data.vcClass)];
        if (tempVc) {
            viewController = tempVc;
        }else{
            viewController = [[(Class)data.vcClass alloc] init];
            self.vcObjcMap[NSStringFromClass(data.vcClass)] = viewController;
        }
    }
    
    viewController.param = data.param;
    [self.nativeServeWindow showViewController:viewController animated:data.animated completion:^{
        completion ? completion(viewController) : nil;
    }];
}

- (BOOL)_conformsPreDefineCondition:(Class)vcClass
{
    BOOL ret = [vcClass conformsToProtocol:@protocol(PKNativeServeWindowViewControllerDelegate)]
            && [vcClass instancesRespondToSelector:@selector(param)]
            && [vcClass instancesRespondToSelector:@selector(setParam:)];
    return ret;
}
- (void)hiddenServeWindow:(void (^)(void))completion
{
    [self.nativeServeWindow hiddenCompletion:completion];
}
@end


