//
//  ViewController.m
//  GameCenter
//
//  Created by pengweijian on 2019/6/12.
//  Copyright © 2019 loyalwind. All rights reserved.
//

#import "ViewController.h"
#import <GameKit/GameKit.h>
#import <AuthenticationServices/AuthenticationServices.h>

@interface ViewController ()<ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding>

@property (nonatomic, strong) ASAuthorizationAppleIDButton *authorizationButton;
@property (nonatomic, strong) UILabel *gameLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.backgroundColor = [UIColor redColor];
//    [btn setTitle:@"GameCenter" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
//    [btn addTarget:self action:@selector(gameCenterClick) forControlEvents:UIControlEventTouchUpInside];
//    btn.frame = CGRectMake(50, 50, 150, 50);
//    [self.view addSubview:btn];
//
//    UILabel *gameLabel = [[UILabel alloc] init];
//    gameLabel.numberOfLines = 0;
//    gameLabel.text = @"";
//    gameLabel.textColor = [UIColor redColor];
//    gameLabel.frame = CGRectMake(50, 100, 300, 500);
//    [self.view addSubview:gameLabel];
//    _gameLabel = gameLabel;
    [self configUI];
}

- (void)gameCenterClick
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    __weak typeof(GKLocalPlayer *) wPlayer = localPlayer;
    localPlayer.authenticateHandler = ^(UIViewController * _Nullable viewController, NSError * _Nullable error) {
        NSLog(@"%@",error);
        if (wPlayer.isAuthenticated) {
            NSString *playerID = wPlayer.playerID;//G:8358811976
            NSString *alias =wPlayer.alias;
            NSString *displayName =wPlayer.displayName;
            NSLog(@"%@--%@--%@",playerID, alias, displayName);
            NSString *info = [NSString stringWithFormat:@"playerID=%@\nalias=%@\ndisplayName=%@",playerID, alias, displayName];
            self.gameLabel.text = info;
        }
    };
}

-(void)configUI{
//    if (@available(iOS 13.0, *)) {
        self.authorizationButton = [[ASAuthorizationAppleIDButton alloc]init];
        [self.authorizationButton addTarget:self action:@selector(click) forControlEvents:(UIControlEventTouchUpInside)];
        self.authorizationButton.frame = CGRectMake(50, 50, 200, 50);
        self.authorizationButton.center = self.view.center;
        [self.view addSubview:self.authorizationButton];
//    } else {
        // Fallback on earlier versions
//    }
}

-(void)click API_AVAILABLE(ios(13.0)){
    ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc]init];
    ASAuthorizationAppleIDRequest *request = [appleIDProvider createRequest];
    request.requestedScopes = @[ASAuthorizationScopeFullName,ASAuthorizationScopeEmail];
    ASAuthorizationController *auth = [[ASAuthorizationController alloc]initWithAuthorizationRequests:@[request]];
    auth.delegate = self;
    auth.presentationContextProvider = self;
    [auth performRequests];
}
-(void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)){
        if([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]){
            ASAuthorizationAppleIDCredential *apple = authorization.credential;
            ///将返回得到的user 存储起来
            NSString *userIdentifier = apple.user;
            NSPersonNameComponents *fullName = apple.fullName;
            NSString *email = apple.email;
            //用于后台像苹果服务器验证身份信息
            NSData *identityToken = apple.identityToken;
            
            
            NSLog(@"%@%@%@%@",userIdentifier,fullName,email,identityToken);
        }else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]){
            
            //// Sign in using an existing iCloud Keychain credential.
            ASPasswordCredential *pass = authorization.credential;
            NSString *username = pass.user;
            NSString *passw = pass.password;
        }
}

///代理主要用于展示在哪里
-(ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller API_AVAILABLE(ios(13.0)){
    return self.view.window;
}

///回调失败
-(void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)){
    NSLog(@"%@",error);
}
@end
