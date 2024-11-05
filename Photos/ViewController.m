//
//  ViewController.m
//  Picture
//
//  Created by 彭维剑 on 2020/9/21.
//  Copyright © 2020 loyalwind. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import "ViewController2.h"
#import "ViewController3.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn .frame = CGRectMake(50, 50, 50, 50);
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn2.frame = CGRectMake(100, 100, 50, 50);
    [self.view addSubview:btn2];
    
    [btn2 addTarget:self action:@selector(addClick2) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addClick
{
    ViewController3 *v2 = [[ViewController3 alloc] init];
    [self presentViewController:v2 animated:YES completion:nil];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"save2.png" ofType:nil];
//    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
//
//    UIImage *img = [UIImage imageWithData:data];
//
//    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

- (void)addClick2
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"save2.png" ofType:nil];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    
    UIImage *img = [UIImage imageWithData:data];
    
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)img didFinishSavingWithError:(NSError *)err contextInfo:(void*)context
{
    NSLog(@"--------");
}

- (void)asyncSaveImageWithPhotos:(UIImage *)image{
    // 必须在 block 中调用
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 异步执行保存图片操作
        [PHAssetChangeRequest creationRequestForAssetFromImage:image];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        // 保存结束后，回调
        if (error) {
            NSLog(@"保存失败！");
        } else {

            NSLog(@"保存成功！");
        }
    }];
}

- (void)test
{
 
    
}
@end
