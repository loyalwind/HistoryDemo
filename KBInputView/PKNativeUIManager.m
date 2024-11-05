//
//  PKNativeUIManager.m
//  KBInputView
//
//  Created by loyalwind on 2018/3/9.
//  Copyright © 2018年 pengweijian. All rights reserved.
//

#import "PKNativeUIManager.h"
#import "PKNativeServeWindow.h"
#import <UIKit/UIKit.h>

@interface PKNativeServeWindowData ()

@property (nonatomic, assign,) PKPreDefineViewControllerClass vcClass;
@property (nonatomic, assign, getter=isReCreat) BOOL reCreat;
@property (nonatomic, strong) NSDictionary *param;

@end

@implementation PKNativeServeWindowData

+ (instancetype)dataWithClass:(PKPreDefineViewControllerClass)vcClass param:(NSDictionary *)param reCreat:(BOOL)reCreat
{
    return [[self alloc] initWithClass:vcClass param:param reCreat:reCreat];
}
- (instancetype)initWithClass:(PKPreDefineViewControllerClass)vcClass param:(NSDictionary *)param reCreat:(BOOL)reCreat
{
    if (self = [super init]) {
        _vcClass = vcClass;
        _reCreat = reCreat;
//        _animated = animated;
        _param = param;
    }
    return self;
}
@end


@interface PKNativeUIManager ()
@property(nonatomic, strong) NSMutableDictionary <NSString *, PKPreDefineViewControllerClass> *vcClassMap;
@property(nonatomic, strong) NSMutableDictionary <NSString *, PKPreDefineViewControllerObjc *> *vcObjcMap;
@property(nonatomic, strong) PKNativeServeWindow *nativeServeWindow;
@property(nonatomic, weak) UIViewController *currentShowVc;
- (UIViewController *)rootViewController;
@end

static PKNativeUIManager *_instance = nil;
@implementation PKNativeUIManager

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

- (UIViewController *)rootViewController
{
    return [UIApplication sharedApplication].keyWindow.rootViewController;
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
    // 1. 查找控制器
    PKPreDefineViewControllerObjc *viewController = nil;
    if (data.isReCreat) { // 需要重新创建这个控制器
        [self.vcObjcMap removeObjectForKey:NSStringFromClass(data.vcClass)];
        viewController = [[(Class)data.vcClass alloc] init];
//        self.vcObjcMap[NSStringFromClass(data.vcClass)] = viewController;
    }else{
        PKPreDefineViewControllerObjc *tempVc = self.vcObjcMap[NSStringFromClass(data.vcClass)];
        if (tempVc) {
            viewController = tempVc;
        }else{
            viewController = [[(Class)data.vcClass alloc] init];
            self.vcObjcMap[NSStringFromClass(data.vcClass)] = viewController;
        }
    }
    // 1.1添加控制器
    viewController.param = data.param;
    [self.rootViewController.view.window endEditing:NO];// 先退出键盘
    [self.rootViewController addChildViewController:viewController];
    [self.rootViewController.view addSubview:viewController.view];
    // 给一个初始化的frame
    NSMutableArray *constraints = [NSMutableArray array];
    
    //2.添加约束
    //2.1水平方向的约束
    UIView *rootView = self.rootViewController.view;
    UIView *subView = viewController.view;
    
    subView.translatesAutoresizingMaskIntoConstraints = NO;

    NSString *hVFL = @"H:|-0-[subView]-0-|";
    NSArray *hCons = [NSLayoutConstraint constraintsWithVisualFormat:hVFL options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(subView)];
    [constraints addObjectsFromArray:hCons];
    
    //2.2垂直方向的约束
    NSString *vVFL = @"V:|-0-[subView]-0-|";
    NSArray *vCons = [NSLayoutConstraint constraintsWithVisualFormat:vVFL options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(subView)];
    [constraints addObjectsFromArray:vCons];
    
    // 2.3添加约束
    [rootView addConstraints:constraints];
    
    // 3.强制布局
    [rootView layoutIfNeeded];// 会调用到- (void)viewWillAppear:(BOOL)animated
    
    _currentShowVc = viewController;
    completion ? completion(viewController) : nil;
}

- (void)hiddenServeWindow:(void (^)(void))completion
{
    [_currentShowVc removeFromParentViewController];
    [_currentShowVc.view removeFromSuperview];
    completion ? completion() : nil;
}

#pragma mark - privite method
- (BOOL)_conformsPreDefineCondition:(Class)vcClass
{
    BOOL ret = [vcClass conformsToProtocol:@protocol(PKNativeUIDelegate)]
    && [vcClass instancesRespondToSelector:@selector(param)]
    && [vcClass instancesRespondToSelector:@selector(setParam:)];
    return ret;
}
@end


