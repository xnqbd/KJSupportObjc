//
//  CKJRSA.h
//  WDYHFSDK
//
//  Created by chenkaijie on 2019/5/21.
//  Copyright © 2019 chenkaijie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class WKWebView;

@interface ZMCertificateDescriptor : NSObject

@property(nonatomic, assign) unsigned long typeId;                         // 证书类型标识符
@property(nonatomic, copy) NSString *subjectSummary;                       // 证书主题摘要
@property(nonatomic, copy) NSString *commonName;                           // 证书主题的通用名称
@property(nonatomic, strong) NSArray *emailAddresses;                      // 证书的电子邮件地址
@property(nonatomic, strong) NSData *normalizedIssuer;                     // 规范化颁发者
@property(nonatomic, strong) NSData *normalizedSubject;                    // 规范化主题
@property(nonatomic, assign) NSData *publicKey;                            // 证书公钥
@property(nonatomic, strong) NSData *serialNumber;                         // 证书序列号
@property(nonatomic, copy) NSString *certLongDesc;                         // 证书长描述
@property(nonatomic, copy) NSString *certShortDesc;                        // 证书短描述
@property(nonatomic, strong) NSArray *certContent;  // 证书详细内容

@end


/*
 
 可从Safari和Chrome 拖动证书图标到本地获取证书
 
 
 cat  server.crt  // crt文件能打印出，der和cer打印不出来
 
 shasum -a 256 /tmp/hello.txt   // SHA-256 校验和
 shasum -a 1   /tmp/hello.txt   // SHA-1 校验和
 md5           /tmp/hello.txt   // md5 校验和




 
 
 
 // crt转cer
 openssl x509 -in ca.crt -out server.cer -outform der
 
 // crt转der
 openssl x509 -in ca.crt -out server.der -outform der
 
 // cer转crt
 openssl x509 -inform DER -in wd.cer -out wd.crt
 
 */

@interface CKJSecret : NSObject


/// 获取crt文件的 主要数据
+ (NSString *)kjwd_getMainData_ByCRTFileName:(NSString *)crtFileName;

/// 一般用在获取证书Sha1指纹
+ (NSString *)kjwd_getSha1ByData:(NSData *)certData;


/// 一般用在获取 .cer证书 Sha256指纹
+ (NSString *)kjwd_getSha256ByData:(NSData *)certData;



/// 获取challenge的Data
+ (NSData *)kjwd_getDataByChallenge:(NSURLAuthenticationChallenge *)challenge;





+ (ZMCertificateDescriptor *)lookCertificateByTrust:(SecTrustRef)trust;


/// 校验 授权挑战的证书 和 本地的证书 是否一致
/// @param certificateResource 本地证书 比如 server.cer
/// @param challenge 授权挑战
//+ (BOOL)verifyCertificateResource:(NSString *)certificateResource forAuthenticationWithChallenge:(NSURLAuthenticationChallenge *)challenge;

@end




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
 
 

 
 
 // 这边生成的私钥是 PKCS#8 格式的，网上有工具可以把PKCS#1 转成 PKCS#8
 
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




/// 公用的加密  每次加密出来的数据都是不一样的
+ (nullable NSString *)encrypt1_forText:(nullable NSString *)text;
/// 公用的解密
+ (nullable NSString *)decrypt1_forText:(NSString *)text;


@end




@interface CKJAES : NSObject

+ (nullable NSString *)AES128Encrypt:(NSString *)plainText key:(NSString *)key;
+ (nullable NSString *)AES128Decrypt:(NSString *)encryptText key:(NSString *)key;


/*
 调用js的AES  CBC
 
 资源在KJSupportObjc.bundle里
 
 

 JSContext *ctx = [[JSContext alloc] init];
 ctx.exceptionHandler = ^(JSContext *context, JSValue *exception) {
     NSLog(@"出现异常，异常信息：%@", exception);
 };
 
 ctx[@"alert"] = ^(id args){
     NSArray *arr = [JSContext currentArguments];
     NSMutableString *result = [NSMutableString string];
     for (int i = 0; i < arr.count; i++) {
         id objc = arr[i];
         [result appendFormat:@"%@ ", objc];
     }
     NSLog(@"%@   ", result);
     
 };
 
 [ctx evaluateScript:@"var NativeEncrypt = null;"];
 
 NSLog(@"读取文件开始");
 
 NSBundle *resourcesBundle = [CKJWorker kjbundle];
 
 NSString *filePath = [resourcesBundle pathForResource:@"js_aes" ofType:@"js"];
 NSString *script = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
 [ctx evaluateScript:script];
 
 NSLog(@"读取文件结束");
 
 
 JSValue *val = [ctx evaluateScript:@"NativeEncrypt.aesEncrypt({'name':'ckj'},'1621bb7dc160c1da')"];
 NSLog(@"加密后是  %@   ", [val toString]);
 
 
 
 */




@end

// 国密
// 要特别注意，init方法里 读取html文档需要时间， 如果需要使用该类的 方法，需要提前初始化好CKJGMSecret对象，如果刚初始化完成就使用 本类的对象方法，可能html还没有读取完毕
@interface CKJGMSecret : NSObject


/// 生成公私钥（注意：请提前初始化本类对象，不然可能html还没有读取完毕）
/// @param curve 有sm2、secp256r1、secp256k1、secp384r1 这几种， 传nil默认是sm2
- (void)sm2_generate_publicKey_privateKeyWithCurve:(NSString *_Nullable)curve completion:(void(^_Nullable)(NSString *publicKey, NSString *privateKey))completion;



/// 加密（注意：请提前初始化本类对象，不然可能html还没有读取完毕）
/// @param cipherMode  0是C1C2C3    1是C1C3C2
- (void)sm2_encryptWithStr:(NSString *)str publicKey:(NSString *)publicKey cipherMode:(NSString *_Nullable)cipherMode completion:(void(^_Nullable)(NSString *encryptStr))completion;


// 如果出现 The WKWebView was invalidated 情况，那是因为 本对象 释放了
//2020-10-14 15:20:26.635928+0800 DYCity[2738:1914529] SM2解密 失败 Error Domain=WKErrorDomain Code=3 "The WKWebView was invalidated" UserInfo={NSLocalizedDescription=The WKWebView was invalidated}



/// 解密（注意：请提前初始化本类对象，不然可能html还没有读取完毕）
/// @param cipherMode  0是C1C2C3    1是C1C3C2
- (void)sm2_decryptWithEncryptStr:(NSString *)encryptStr privateKey:(NSString *)privateKey cipherMode:(NSString *_Nullable)cipherMode completion:(void(^_Nullable)(NSString *decryptStr))completion;


@end



NS_ASSUME_NONNULL_END
