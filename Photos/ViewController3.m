//
//  ViewController3.m
//  Picture
//
//  Created by 彭维剑 on 2020/9/22.
//  Copyright © 2020 loyalwind. All rights reserved.
//

#import "ViewController3.h"

@interface ViewController3 ()

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn .frame = CGRectMake(50, 100, 200, 50);
    [self.view addSubview:btn];
    [btn setTitle:@"获取信息" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(fetchClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];

    btn2 .frame = CGRectMake(50, 200, 200, 50);
    [self.view addSubview:btn2];
    [btn2 setTitle:@"修改信息" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(motifyClick) forControlEvents:UIControlEventTouchUpInside];
    
//    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
//
//    btn3 .frame = CGRectMake(50, 250, 200, 50);
//    [self.view addSubview:btn3];
//    [btn3 setTitle:@"重新查看信息" forState:UIControlStateNormal];
//    [btn3 addTarget:self action:@selector(refetchClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)fetchClick
{
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
//    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"IMG_0211" withExtension:@"JPG"];
//    CGImageSourceRef imageSource = CGImageSourceCreateWithURL((CFURLRef)fileUrl, NULL);
//    CFDictionaryRef imageInfo = CGImageSourceCopyPropertiesAtIndex(imageSource, 0,NULL);
//
//    NSDictionary *exifDic = (__bridge NSDictionary *)CFDictionaryGetValue(imageInfo, kCGImagePropertyExifDictionary) ;
//
//    NSDictionary *appleDic = (__bridge NSDictionary *)CFDictionaryGetValue(imageInfo, kCGImagePropertyMakerAppleDictionary) ;
//
//    NSLog(@"All Exif Info:%@",imageInfo);
//    NSLog(@"EXIF:%@",exifDic);
//
//    NSLog(@"MakerApple:%@",appleDic);
}


- (void)refetchClick
{
    
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"IMG_0211" withExtension:@"JPG"];
    CGImageSourceRef imageSource = CGImageSourceCreateWithURL((CFURLRef)fileUrl, NULL);
    CFDictionaryRef imageInfo = CGImageSourceCopyPropertiesAtIndex(imageSource, 0,NULL);

    NSDictionary *exifDic = (__bridge NSDictionary *)CFDictionaryGetValue(imageInfo, kCGImagePropertyExifDictionary) ;
    
    NSDictionary *appleDic = (__bridge NSDictionary *)CFDictionaryGetValue(imageInfo, kCGImagePropertyMakerAppleDictionary) ;
    
    NSLog(@"All Exif Info:%@",imageInfo);
    NSLog(@"EXIF:%@",exifDic);
    
//    NSLog(@"MakerApple:%@",appleDic);
}

- (void)motifyClick
{
    //1. 获取图片中的EXIF文件和GPS文件
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"Icon" withExtension:@"png"];
    
     CGImageSourceRef source = CGImageSourceCreateWithURL((CFURLRef)fileUrl, NULL);
     
    NSDictionary *imageInfo = (__bridge NSDictionary*)CGImageSourceCopyPropertiesAtIndex(source, 0, NULL);
     
    NSMutableDictionary *metaDataDic = [imageInfo mutableCopy];
//    NSMutableDictionary *exifDic =[[metaDataDic objectForKey:(NSString*)kCGImagePropertyExifDictionary]mutableCopy];
//    NSMutableDictionary *GPSDic =[[metaDataDic objectForKey:(NSString*)kCGImagePropertyGPSDictionary]mutableCopy];
//    NSMutableDictionary *appleDic =[[metaDataDic objectForKey:(NSString*)kCGImagePropertyMakerAppleDictionary]mutableCopy];
    
//    NSMutableDictionary *pngDic =[[metaDataDic objectForKey:(NSString*)kCGImagePropertyPNGDictionary]mutableCopy];
    NSMutableDictionary *exifDic =[NSMutableDictionary dictionary];
    
//    [appleDic setObject:@"123456789987654321" forKey:@"17"];
    [exifDic setObject:@"123456789987654321" forKey:(NSString *)kCGImagePropertyExifLensModel];//

    //2. 修改EXIF文件和GPS文件中的部分信息
//    [exifDic setObject:[NSNumber numberWithFloat:1234.3] forKey:(NSString *)kCGImagePropertyExifExposureTime];
//    [exifDic setObject:@"SenseTime" forKey:(NSString *)kCGImagePropertyExifLensModel];
//
//    [GPSDic setObject:@"N" forKey:(NSString*)kCGImagePropertyGPSLatitudeRef];
//    [GPSDic setObject:[NSNumber numberWithFloat:116.29353] forKey:(NSString*)kCGImagePropertyGPSLatitude];
     
    [metaDataDic setObject:exifDic forKey:(NSString*)kCGImagePropertyExifDictionary]; //
//    [metaDataDic setObject:GPSDic forKey:(NSString*)kCGImagePropertyGPSDictionary];
//    [metaDataDic setObject:appleDic forKey:(NSString*)kCGImagePropertyMakerAppleDictionary];
    
//    [metaDataDic setObject:pngDic forKey:(NSString*)kCGImagePropertyPNGDictionary];


    //3. 将修改后的文件写入至图片中
    CFStringRef UTI = CGImageSourceGetType(source);
    NSMutableData *newImageData = [NSMutableData data];
    CGImageDestinationRef destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)newImageData, UTI, 1,NULL);
     
    //add the image contained in the image source to the destination, overidding the old metadata with our modified metadata
    CGImageDestinationAddImageFromSource(destination, source, 0, (__bridge CFDictionaryRef)metaDataDic);
    CGImageDestinationFinalize(destination);
    
    // 4. 保存图片
    NSString *directoryDocuments =  NSTemporaryDirectory();
    [newImageData writeToFile: directoryDocuments atomically:YES];
    
    // 5. 查看修改后图片的Exif信息
    CIImage *testImage = [CIImage imageWithData:newImageData];
    NSDictionary *propDict = [testImage properties];
    NSLog(@"Properties %@", propDict);
}
@end
