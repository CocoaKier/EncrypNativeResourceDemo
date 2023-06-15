//
//  NSData+AES256Encryption.h
//  EncrypNativeResourceDemo
//
//  Created by YuNuo on 2023/5/12.
//  Copyright © 2023 CocoaKier. All rights reserved.
//

//配合openssl脚本使用的AES256加解密库

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (AES256Encryption)

- (NSData *)encryptedDataWithHexKey:(NSString*)hexKey hexIV:(NSString *)hexIV;
- (NSData *)originalDataWithHexKey:(NSString*)hexKey hexIV:(NSString *)hexIV;

@end

NS_ASSUME_NONNULL_END
