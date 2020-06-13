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
 
 
 
 iOS RSA在传给后台的时候会遇到+加号 空格 无法解析问题， base64也会有相同的问题
 请求%2B 识别成 +
 请求 + 识别成 空格
 
 
 
 终端：
 
 // 可以执行openssl命令，那么下面的命令就可以不用以openssl开头了
 // 用exit退出
 
 

 
 
 
 
 1. 生成模长为1024bit的私钥文件
 openssl genrsa -out rsa_private_key.pem 1024
 2. 从私钥中提取公钥
 openssl rsa -in rsa_private_key.pem -out rsa_public_key.pem -pubout
 3. 这时候的私钥还不能直接被使用，需要进行PKCS#8编码
 openssl pkcs8 -topk8 -in rsa_private_key.pem -out pkcs8_rsa_private_key.pem -nocrypt

 至此，可用的密钥对已经生成好了，私钥一定使用pkcs8_rsa_private_key.pem，公钥采用rsa_public_key.pem。
 可以通过 cat xxx.pem 查看pem里面的内容
 

 示输入国家CN、省份Shanghai、其他不用填写，敲回车，最后是密码
 
 

 NSString *publicKey = @"这里面是cat rsa_public_key.pem查看的值";
 
 
 NSString *en = [CKJRSA encryptString:@"你好Hello😄2020" publicKey:publicKey];
 NSLog(@"加密后 %@   ", en);
 
 NSString *privateKey = @"这里面是pkcs8格式pem文件的值 cat pkcs8_rsa_private_key.pem";
 
 NSString *de = [CKJRSA decryptString:en privateKey:privateKey];
 NSLog(@"解密出 %@   ", de);
 
 */






/**
 公钥加密，返回base64 string
 */
+ (nullable NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;
/**
 公钥加密，返回二进制数据
 */
+ (nullable NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;
/**
 私钥加密，返回base64 string
 */
+ (nullable NSString *)encryptString:(NSString *)str privateKey:(NSString *)privKey;
/**
 私钥加密，返回二进制数据
 */
+ (nullable NSData *)encryptData:(NSData *)data privateKey:(NSString *)privKey;




/**
 公钥解密，返回base64 string
 */
+ (nullable NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey;
/**
 公钥加密，返回二进制数据
 */
+ (nullable NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey;
/**
 私钥解密，返回base64 string
 */
+ (nullable NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;
/**
 私钥解密，返回二进制数据
 */
+ (nullable NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey;





/**
 通过SHA1签名

 @param str 原始字符串
 */
+ (NSString *)signTheDataSHA1WithRSA:(NSString *)str p12FileName:(NSString *)p12FileName p12FilePassword:(NSString *)p12FilePassword;




@end

NS_ASSUME_NONNULL_END
