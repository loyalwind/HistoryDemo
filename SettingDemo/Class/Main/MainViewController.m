//
//  MainViewController.m
//  ToolsDemo
//
//  Created by pengweijian on 2017/8/29.
//  Copyright © 2017年 pengweijian. All rights reserved.
//

#import "MainViewController.h"
#import "SettingViewController.h"

@interface MainViewController ()

@end

static NSString * const CellID = @"MainCellID";


@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    self.title = @"主页功能";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-15, 0, -15, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%zd组--第%zd行",indexPath.section,indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SettingViewController *settingVc = [[SettingViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    [self.navigationController pushViewController:settingVc animated:YES];
}


@end
