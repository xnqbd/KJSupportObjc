//
//  CKJRSA.h
//  WDYHFSDK
//
//  Created by chenkaijie on 2019/5/21.
//  Copyright © 2019 chenkaijie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CKJRSA : NSObject





/*
 在iOS中使用RSA加密解密，需要用到.der和.p12后缀格式的文件
 
 public_key.der  公钥
 private_key.p12  私钥
 
 
 
 Java用下面两个文件
 rsa_public_key.pem  公钥
 pkcs8_private_key.pem   私钥
 
 
 
 */





/**
 公钥加密，返回base64 string
 */
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;
/**
 公钥加密，返回二进制数据
 */
+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;
/**
 私钥加密，返回base64 string
 */
+ (NSString *)encryptString:(NSString *)str privateKey:(NSString *)privKey;
/**
 私钥加密，返回二进制数据
 */
+ (NSData *)encryptData:(NSData *)data privateKey:(NSString *)privKey;




/**
 公钥解密，返回base64 string
 */
+ (NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey;
/**
 公钥加密，返回二进制数据
 */
+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey;
/**
 私钥解密，返回base64 string
 */
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;
/**
 私钥解密，返回二进制数据
 */
+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey;





/**
 通过SHA1签名

 @param str 原始字符串
 */
+ (NSString *)signTheDataSHA1WithRSA:(NSString *)str p12FileName:(NSString *)p12FileName p12FilePassword:(NSString *)p12FilePassword;




@end

NS_ASSUME_NONNULL_END
