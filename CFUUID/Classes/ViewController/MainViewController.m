//
//  MainViewController.m
//  CFUUID
//
//  Created by pengweijian on 2017/11/16.
//  Copyright © 2017年 pengweijian. All rights reserved.
//

#import "MainViewController.h"
#import "IDFAViewController.h"
#import "IDFVViewController.h"
#import "UUIDViewController.h"
//获取mac
#include <sys/sysctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>
struct CTResult
{
    int flag;
    int a;
};

@interface MainViewController ()
{
    NSArray *_ids;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _ids = @[@"IDFAViewController", @"IDFVViewController", @"UUIDViewController", @"MacViewController"];//,@"UDIDViewController"];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _ids.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *mainCellID = @"mainCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mainCellID];
    }
    // Configure the cell...
    cell.textLabel.text = _ids[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == _ids.count -1) {
//        [self dy_getDeviceMAC];
//    }else{
        Class cls = NSClassFromString(_ids[indexPath.row]);
        UIViewController *vc = [[cls alloc] init];
        vc.title = _ids[indexPath.row];
    NSLog(@"loading-push");
    [self.navigationController pushViewController:vc animated:YES];
//    UIViewController* vc2 = [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"loaded-push");
//    }
}
- (NSString*)dy_getDeviceMAC{
    
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *macStr = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",*ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    NSLog(@"macStr=%@",macStr);
    return macStr;
}
@end
