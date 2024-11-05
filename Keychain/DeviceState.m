
#define UUIDKEY @"UUIDKEY"
#import "DeviceState.h"
#import "CHKeychain.h"
#import "FrogOpenUDID.h"

@implementation DeviceState

#pragma mark --获取设备UUID
+ (NSString *)uuid {
    NSString *_openUDID = [CHKeychain load:UUIDKEY];
    if (_openUDID) {
        NSLog(@"----CHKeychain, _openUDID = %@", _openUDID);
        return _openUDID;
    } else {
        _openUDID = [FrogOpenUDID value];
        [CHKeychain save:UUIDKEY data:_openUDID];
        NSLog(@"----FrogOpenUDID, _openUDID = %@", _openUDID);
        return _openUDID;
    }
    return nil;
}

@end
