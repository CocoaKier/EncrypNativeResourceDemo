//
//  ViewController.m
//  EncrypNativeResourceDemo
//
//  Created by Cocoakier on 2019/5/23.
//  Copyright © 2019 CocoaKier. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "CCOpenSSLHelper.h"

#define MAIN_BUNDLE_FILE_PATH(fileName) [[NSBundle mainBundle] pathForResource:fileName ofType:nil]     //!< 获取mainBundle中文件路径,fileName带后缀

#define PASS_WORD @"fwe&*^123213"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //解密plist
    NSString *filePath = MAIN_BUNDLE_FILE_PATH(@"myPlist");
    NSDictionary *myPlist = [self decodeResourceFilePath:filePath fileType:@"plist"];
    NSLog(@"%@",myPlist);
    
    //解密image
    filePath = MAIN_BUNDLE_FILE_PATH(@"myImage");
    UIImage *myImage = [self decodeResourceFilePath:filePath fileType:@"image"];
    NSLog(@"%@",myImage);
    
    //解密html
    filePath = MAIN_BUNDLE_FILE_PATH(@"baidu");
    NSString *html = [self decodeResourceFilePath:filePath fileType:@"string"];
    NSLog(@"%@",html);
    
    //解密MP3
    filePath = MAIN_BUNDLE_FILE_PATH(@"button");
    NSData *mp3Data = [self decodeResourceFilePath:filePath fileType:nil];
    //注意,系统播放音乐的方法都只支持播放本地音乐文件,不支持播放内存中的音乐,所以这里是解密后保存文件到沙盒在去播放。如何播放内存中的音乐，不在本文讨论范围内，不过我找了篇博客可以参考下 https://www.jianshu.com/p/b62778ce5763
    filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/button.mp3"];
    [mp3Data writeToFile:filePath atomically:YES];
    SystemSoundID soundID = 0;
    OSStatus err = AudioServicesCreateSystemSoundID((__bridge CFURLRef)([NSURL URLWithString:filePath]), &soundID);
    if (err) {
        NSLog(@"播放音效出错");
    }
    //    AudioServicesAddSystemSoundCompletion(soundID,NULL,NULL,soundCompleteCallBack,NULL);
    AudioServicesPlaySystemSound(soundID);
}

//解密资源文件
- (id)decodeResourceFilePath:(NSString *)filePath fileType:(NSString *)fileType
{
    if (!filePath) {
        return nil;
    }
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    NSData *dataDecrypted = [CCOpenSSLHelper decryptData:data password:PASS_WORD];
    if ([fileType isEqualToString:@"plist"]) {
        id plist = [NSPropertyListSerialization propertyListWithData:dataDecrypted options:(NSPropertyListImmutable) format:nil error:&error];
        return plist;
    }
    else if ([fileType isEqualToString:@"string"]) {
        NSString *decodeStr = [[NSString alloc] initWithData:dataDecrypted encoding:(NSUTF8StringEncoding)];
        return decodeStr;
    }
    else if ([fileType isEqualToString:@"image"]) {
        UIImage *image = [UIImage imageWithData:dataDecrypted];
        return image;
    }
    return dataDecrypted;
}

@end
