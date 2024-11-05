//
//  KeychainItem.h
//  PrivacyPolicy
//
//  Created by pengweijian on 2020/5/11.
//  Copyright © 2020 loyalwind. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeychainItem : NSObject
+ (NSString *)defaultAccount;
+ (NSString *)defaultService;
+ (NSString *)currentUserIdentifier;
+ (void)deleteUserIdentifierFromKeychain;

- (instancetype)initWithService:(NSString *)service
                        account:(NSString *)account
                    accessGroup:(NSString * _Nullable)accessGroup NS_DESIGNATED_INITIALIZER;
- (void)saveItem:(NSString *)userIdentifier;

- (nonnull instancetype)init NS_UNAVAILABLE;
+ (nonnull instancetype)new NS_UNAVAILABLE;
@end

NS_ASSUME_NONNULL_END
