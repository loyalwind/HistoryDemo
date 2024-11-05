//
//  ViewController.m
//  WKWebViewTest
//
//  Created by pengweijian on 2022/5/17.
//

#import "ViewController.h"
#import "ShowWebViewController.h"

#define KEY_URLS @"KEY_URLS"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *openBtn;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray <NSString *> *urlArray;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    NSArray *urls = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_URLS];
    if (urls) {
        self.urlArray = [NSMutableArray arrayWithArray:urls];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (NSMutableArray <NSString *>*)urlArray {
    if (!_urlArray) {
        _urlArray = [NSMutableArray array];
    }
    return _urlArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (IBAction)openBtnClick:(id)sender {
    if (!self.textView.hasText) return;
    
    if (![self.urlArray containsObject:self.textView.text]) {
        [self.urlArray addObject:self.textView.text];
        [self saveUrl];
        [self.tableView reloadData];
    }
            
    NSString *urlStr = [self.textView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    ShowWebViewController *webVC = [UIStoryboard storyboardWithName:@"ShowWebViewController" bundle:nil].instantiateInitialViewController;
    webVC.url = [NSURL URLWithString:urlStr];
    [self presentViewController:webVC animated:YES completion:nil];
}


#pragma mark - <UITextViewDelegate>
- (void)textViewDidChange:(UITextView *)textView {
    self.placeholderLabel.hidden = textView.hasText;
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"URL_CELL_ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"URL_CELL_ID"];
    }
    cell.textLabel.text = self.urlArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.urlArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.textView.text = self.urlArray[indexPath.row];
    [self textViewDidChange:self.textView];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return true;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.urlArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self saveUrl];
    }
}

- (void)saveUrl {
    [[NSUserDefaults standardUserDefaults] setObject:self.urlArray forKey:KEY_URLS];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
