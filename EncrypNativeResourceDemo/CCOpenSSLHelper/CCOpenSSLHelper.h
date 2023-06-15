//
//  CCOpenSSLHelper.h
//  EncrypNativeResourceDemo
//
//  Created by YuNuo on 2023/6/15.
//  Copyright © 2023 CocoaKier. All rights reserved.
//

//解密脚本加密的文件

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCOpenSSLHelper : NSObject

/// 解密脚本加密的文件
/// - Parameters:
///   - data: 脚本加密后的文件
///   - password: 密码
+ (nullable NSData *)decryptData:(NSData *)data password:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
