//
//  CCOpenSSLHelper.m
//  EncrypNativeResourceDemo
//
//  Created by YuNuo on 2023/6/15.
//  Copyright © 2023 CocoaKier. All rights reserved.
//

#import "CCOpenSSLHelper.h"
#import <CommonCrypto/CommonDigest.h>   //SHA256
#import <CommonCrypto/CommonCrypto.h>   //MD5
#import "NSData+AES256Encryption.h"

@implementation CCOpenSSLHelper

/// 解密脚本加密的文件
/// - Parameters:
///   - data: 脚本加密后的文件
///   - password: 密码
+ (NSData *)decryptData:(NSData *)data password:(NSString *)password
{
    if (!data || !password) {
        return nil;
    }
    NSString *key = [[self sha256ForString:password] uppercaseString];
    NSString *iv = [[self MD5HashForString:password] uppercaseString];
//    NSLog(@"key=%@\niv=%@",key,iv);
    NSData *originalData = [data originalDataWithHexKey:key hexIV:iv];
    return originalData;
}

// SHA256加密
+ (NSString *)sha256ForString:(NSString *)srcString
{
    const char *string = [srcString UTF8String];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(string, (CC_LONG)strlen(string), result);

    NSMutableString *hashed = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
      [hashed appendFormat:@"%02x", result[i]];
    }
    return hashed;
}

//MD5加密
+ (NSString *)MD5HashForString:(NSString *)str
{
    if(str.length == 0) {
        return nil;
    }
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]];
}

@end
