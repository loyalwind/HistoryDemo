//
//  UUIDViewController.m
//  CFUUID
//
//  Created by pengweijian on 2017/11/15.
//  Copyright © 2017年 pengweijian. All rights reserved.
//

#import "UUIDViewController.h"
#import "FrogOpenUDID.h"
#import "CHKeychain.h"
#import <CommonCrypto/CommonDigest.h>
@interface UUIDViewController ()
@property (weak, nonatomic) IBOutlet UILabel *uuidLabe;
@property (weak, nonatomic) IBOutlet UILabel *genUuidLabel;

@end
#define UUIDKEY @"UUIDKEY"

@implementation UUIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSString *openUDID = [CHKeychain load:UUIDKEY];
//    if (!openUDID) {
     NSString *openUDID = [FrogOpenUDID value];
//        [CHKeychain save:UUIDKEY data:openUDID];
        NSLog(@"----FrogOpenUDID, _openUDID = %@", openUDID);
//    }
  
    self.uuidLabe.text = openUDID;
}

- (IBAction)genUUID:(id)sender {
    
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef cfstring = CFUUIDCreateString(kCFAllocatorDefault, uuid);
    const char *cStr = CFStringGetCStringPtr(cfstring,CFStringGetFastestEncoding(cfstring));//"2C766049-FB0D-43B6-A25E-3335FE545B38"  67ED6A26-F8C3-44C6-B1D6-FEB3E5A711FB"
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    CFRelease(uuid);
    
    NSString *openUDID1 = [NSString stringWithFormat:
                           @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%08x",
                           result[0], result[1], result[2], result[3],
                           result[4], result[5], result[6], result[7],
                           result[8], result[9], result[10], result[11],
                           result[12], result[13], result[14], result[15],
                           arc4random() % 4294967295];
//    NSString *openUDID = [FrogOpenUDID value];
//    [CHKeychain save:UUIDKEY data:openUDID];
//    self.genUuidLabel.text = openUDID;
    NSLog(@"%@",openUDID1);
}

//4d8617271cd3079445dea656dc0d59a02ebade78
//ed4c2a33d69397788691f0cff19c72ee63fb39ab
@end
