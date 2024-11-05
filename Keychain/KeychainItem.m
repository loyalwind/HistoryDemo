//
//  KeychainItem.m
//  PrivacyPolicy
//
//  Created by pengweijian on 2020/5/11.
//  Copyright © 2020 loyalwind. All rights reserved.
//

#import "KeychainItem.h"
#import <Security/Security.h>

NS_ENUM(NSInteger, Error){
     noPassword = 0,
     unexpectedPasswordData = 1,
     unexpectedItemData = 2,
     unhandledError = 3
};


@interface KeychainItem ()
/** description */
@property (nonatomic, copy) NSString *service;
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *accessGroup;
@end

@implementation KeychainItem
- (instancetype)initWithService:(NSString *)service account:(NSString *)account accessGroup:(NSString *)accessGroup
{
    if (self = [super init]) {
        self.service = service;
        self.account = account;
        self.accessGroup = accessGroup;
    }
    return self;
}

- (NSString *)readItem
{
    /*
     Build a query to find the item that matches the service, account and
     access group.
     */
    id ret = nil;
    NSMutableDictionary *query = [KeychainItem keychainQuery:_service account:_account accessGroup:_accessGroup];
    query[(NSString *)kSecMatchLimit] = (id)kSecMatchLimitOne;
    query[(NSString *)kSecReturnAttributes] = (id)kCFBooleanTrue;
    query[(NSString *)kSecReturnData] = (id)kCFBooleanTrue;
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)query, (CFTypeRef *)&keyData) == noErr) {
//        @try {
//            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
//        } @catch (NSException *e) {
//            NSLog(@"Unarchive of %@ failed: %@", _service, e);
//        } @finally {
//        }
        ret= CFBridgingRelease(keyData);
    }
    NSData *d = [ret objectForKey:@"v_Data"];
    ret = [[NSString alloc] initWithData:d encoding:4];
    return ret;
}
    
- (void)saveItem:(NSString *)userIdentifier
{
    NSMutableDictionary *query = [KeychainItem keychainQuery:_service account:_account accessGroup:_accessGroup];
    SecItemDelete((CFDictionaryRef)query);
    query[(NSString*)kSecValueData] = [userIdentifier dataUsingEncoding:NSUTF8StringEncoding];
    SecItemAdd((CFDictionaryRef)query, NULL);
}
    
- (void)deleteItem
{
//     Delete the existing item from the keychain.
    NSMutableDictionary *query = [KeychainItem keychainQuery:_service account:_account accessGroup:_accessGroup];
    OSStatus status = SecItemDelete((CFDictionaryRef)query);
    if (status == noErr || status == errSecItemNotFound) {
        
    }
}
    
+ (NSMutableDictionary *)keychainQuery:(NSString *)service account:(NSString *)account accessGroup:(NSString *)accessGroup
{
    NSMutableDictionary<NSString *, id> *query = [NSMutableDictionary dictionary];
    query[(NSString *)kSecClass] = (id)kSecClassGenericPassword;
    query[(NSString *)kSecAttrService] = service;
    
    if (account){
        query[(NSString *)kSecAttrAccount] = account;
    }
    
    if (accessGroup){
        query[(NSString *)kSecAttrAccessGroup] = accessGroup;
    }

    return query;
}

+ (NSString *)currentUserIdentifier
{
    NSString *service = [self defaultService];
    NSString *account = [self defaultAccount];
    KeychainItem *item = [[KeychainItem alloc] initWithService:service account:account accessGroup:nil];
    return [item readItem];
}
    
+ (void)deleteUserIdentifierFromKeychain
{
    NSString *service = [self defaultService];
    NSString *account = [self defaultAccount];
    KeychainItem *item = [[KeychainItem alloc] initWithService:service account:account accessGroup:nil];
    @try {
       [item deleteItem];
    } @catch (NSException *exception) {
        printf("Unable to delete userIdentifier from keychain\n");
    } @finally {}
}

+ (NSString *)defaultAccount
{
    return @"userIdentifier";
}
+ (NSString *)defaultService
{
    return [NSBundle mainBundle].bundleIdentifier;
}
@end
