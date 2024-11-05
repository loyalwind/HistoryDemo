//
//  SettingViewController.m
//  ToolsDemo
//
//  Created by pengweijian on 2017/8/29.
//  Copyright © 2017年 pengweijian. All rights reserved.
//

#import "SettingViewController.h"
#import "GotoSettingTools.h"

@interface SettingViewController ()

@end


static NSString * const SettingCellID = @"SettingCellID";

@implementation SettingViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    self.title = @"跳转设置";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SettingCellID];
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-15, 0, -15, 0);
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [GotoSettingTools shareTools].settings.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingCellID];
    
    cell.textLabel.text = [GotoSettingTools shareTools].settings[indexPath.row];
    
    return cell;
}
#define NSLog(FORMAT, ...) NSLog(@"%@ %s line:%d %@\n",[NSString stringWithUTF8String:__FILE__].lastPathComponent, __FUNCTION__, __LINE__,[NSString stringWithFormat:FORMAT, ##__VA_ARGS__]);
#define NSLog1(FORMAT, ...) printf("%s %s line:%d %s\n",[NSString stringWithUTF8String:__FILE__].lastPathComponent.UTF8String, __FUNCTION__, __LINE__,[NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NSLog(@"");
//    [[GotoSettingTools shareTools] jumpToSettingType:indexPath.row];
}

@end
