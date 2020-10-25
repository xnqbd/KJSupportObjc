//
//  CKJRSA.m
//  WDYHFSDK
//
//  Created by chenkaijie on 2019/5/21.
//  Copyright © 2019 chenkaijie. All rights reserved.
//

#import "CKJSecret.h"
#import <Security/Security.h>

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WebKit.h>

@implementation ZMCertificateDescriptor

- (NSString *)description {
//    NSLog(@"%@   ", descriptor.subjectSummary, descriptor.publicKey, descriptor.serialNumber);
    NSString *publicKey = @"";
    if (self.publicKey) {
        publicKey = [[NSString alloc] initWithData:self.publicKey encoding:NSUTF8StringEncoding];
    }
    
    NSString *serialNumber = @"";
    if (self.serialNumber) {
        serialNumber = [[NSString alloc] initWithData:self.serialNumber encoding:NSUTF8StringEncoding];
    }
    
    return [NSString stringWithFormat:@"证书主题摘要:%@   证书公钥:%@   证书序列号:%@", self.subjectSummary, publicKey, serialNumber];
}

@end


@implementation CKJSecret

/// 获取crt文件的 主要数据
+ (NSString *)kjwd_getMainData_ByCRTFileName:(NSString *)crtFileName {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:crtFileName ofType:@"crt"];
    
    if (path == nil || [path isEqualToString:@""]) {
        return @"";
    }
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (dataStr) {
        dataStr = [dataStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        dataStr = [dataStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        dataStr = [dataStr stringByReplacingOccurrencesOfString:@"-----BEGIN CERTIFICATE-----" withString:@""];
        dataStr = [dataStr stringByReplacingOccurrencesOfString:@"-----END CERTIFICATE-----" withString:@""];
    }
    return dataStr;
}


/// 一般用在获取证书Sha1指纹
+ (NSString *)kjwd_getSha1ByData:(NSData *)certData {
    unsigned char sha1Buffer[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(certData.bytes, certData.length, sha1Buffer);
    NSMutableString *fingerprint = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 3];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; ++i)
        [fingerprint appendFormat:@"%02x ",sha1Buffer[i]];
    return [fingerprint stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}


/// 一般用在获取 .cer证书 Sha256指纹
+ (NSString *)kjwd_getSha256ByData:(NSData *)certData {
    unsigned char sha256Buffer[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(certData.bytes, certData.length, sha256Buffer);
    NSMutableString *fingerprint = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 3];
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; ++i)
        [fingerprint appendFormat:@"%02x ",sha256Buffer[i]];
    return [fingerprint stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}



+ (NSData *)kjwd_getDataByChallenge:(NSURLAuthenticationChallenge *)challenge {
    // https://www.sohu.com/a/127985387_604699
    // challenge.protectionSpace.serverTrust 表示需要验证的信任对象(Trust Object)，包含待验证的证书和支持的验证方法等
    
    SecTrustRef servertrust = challenge.protectionSpace.serverTrust;
    SecCertificateRef certi = SecTrustGetCertificateAtIndex(servertrust, 0);
    NSData *remoteCertificateData = CFBridgingRelease(CFBridgingRetain(CFBridgingRelease(SecCertificateCopyData(certi))));
    return remoteCertificateData;
}


//+ (NSString)kjwd_look

+ (ZMCertificateDescriptor *)lookCertificateByTrust:(SecTrustRef)trust {
    SecCertificateRef cert = SecTrustGetCertificateAtIndex(trust, 0);
    
    ZMCertificateDescriptor *descriptor = [ZMCertificateDescriptor new];
//    CFErrorRef error = NULL;
//
//    CFStringRef commonName = NULL;
//    CFArrayRef emailAddresses = NULL;
//
//    CFStringRef certLongDesc = NULL;
//    CFStringRef certShortDesc = NULL;
    
    descriptor.typeId = SecCertificateGetTypeID();
    
    {   // 返回一个简单的字符串，代表人类易于理解的摘要
        CFStringRef certSummary = SecCertificateCopySubjectSummary(cert);
        NSString *summaryString = [[NSString alloc] initWithString:(__bridge NSString *)certSummary];
        descriptor.subjectSummary = summaryString;
        CFRelease(certSummary);
    }
    {   // 检索给定证书主题的通用名称
        CFStringRef commonName = NULL;
        if (@available(iOS 10.3, *)) {
            SecCertificateCopyCommonName(cert, &commonName);
        } else {
        }
        descriptor.commonName = [[NSString alloc] initWithString:(__bridge NSString *)commonName];
        CFRelease(commonName);
    }
    {   // 公钥
        CFErrorRef error = NULL;
        CFDataRef publicKeyRef = NULL;
        if (@available(iOS 12.0, *)) {
            publicKeyRef = SecKeyCopyExternalRepresentation(SecCertificateCopyKey(cert), &error);
        } else if(@available(iOS 10.3, *)) {
            publicKeyRef = SecKeyCopyExternalRepresentation(SecCertificateCopyPublicKey(cert), &error);
        }
        if (!error){
            descriptor.publicKey = (__bridge NSData * _Nonnull)(publicKeyRef);
        }
    }
    {   // 证书序列号
        CFErrorRef error = NULL;
        CFDataRef serialNumber = NULL;
        if (@available(iOS 11.0, *)) {
            serialNumber = SecCertificateCopySerialNumberData(cert, &error);
        } else if(@available(iOS 10.3, *)) {
            serialNumber = SecCertificateCopySerialNumber(cert);
        }
        if (!error){
            descriptor.serialNumber = (__bridge NSData * _Nonnull)(serialNumber);
            //        descriptor.serialNumber = [[NSString alloc] initWithData:(__bridge NSData * _Nonnull)(serialNumber) encoding:NSUTF8StringEncoding];
        }
    }
    
    
//    // 给定证书主题的零个或多个电子邮件地址的数组
//    SecCertificateCopyEmailAddresses(cert, &emailAddresses);
//    descriptor.emailAddresses = (__bridge NSArray * _Nonnull)(emailAddresses);
//    // 证书的规范化颁发者
//    descriptor.normalizedIssuer = (__bridge NSData * _Nonnull)(SecCertificateCopyNormalizedIssuerSequence(cert));
//    // 证书的规范化主题
//    descriptor.normalizedSubject = (__bridge NSData * _Nonnull)(SecCertificateCopyNormalizedSubjectSequence(cert));
//    // 证书的公钥
    
    
//              // 证书内容的字典
//              CFDictionaryRef dicRef = SecCertificateCopyValues(cert, NULL, &error);
//              if (!error) {
//        NSDictionary *dic = (__bridge_transfer NSDictionary *)dicRef;
//        descriptor.certContent = [ZMCertificateObject certObjectWithCertVal:dic];
//    } else {
//        NSLog(@"[获取证书内容失败]:%@", error);
//    }
    
    return descriptor;
}

    
    
//
//    if (trust != NULL) {
//        SecCertificateRef certi = SecTrustGetCertificateAtIndex(trust, 0);
//        {
//            CFStringRef certSummary = SecCertificateCopySubjectSummary(certi);
//            NSString* summaryString = [[NSString alloc] initWithString:(__bridge NSString *)certSummary];
//            CFRelease(certSummary);
//        }
//        {
//            CFStringRef commonName = NULL;
//            SecCertificateCopyCommonName(certi, &commonName);
//            NSString *commonNameString = [[NSString alloc] initWithString:(__bridge NSString *)commonName];
//            CFRelease(commonName);
//        }
//        {
//            SecKeyRef publicKeyRef = nil;
//
//            if (@available(iOS 12.0, *)) {
//                publicKeyRef = SecCertificateCopyKey(cert);
//            } else {
//                publicKeyRef = SecCertificateCopyPublicKey(cert);
//            }
//
////            SecKeyRef publicKey = SecCertificateCopyKey(certi);
////            NSString* publicKeyString = [[NSString alloc] initWithString:(__bridge NSString *)certSummary];
////            CFRelease(certSummary);
//        }
//
//        CFStringRef certSummary = SecCertificateCopySubjectSummary(certi);
//        NSString* summaryString = [[NSString alloc] initWithString:(__bridge NSString *)certSummary];
//        CFRelease(certSummary);
//
//
//
//
//        NSLog(@"证书信息：%@  %@ ", certSummary, errorStr );
//
//
//
////         NSString *message = [NSString stringWithFormat:@" 是否通过来自%@标识为 %@证书为%@的验证. \n%@" , @"我的app",hostName,certSummary, errorStr];
//    }
//}

/// 校验 授权挑战的证书 和 本地的证书 是否一致
/// @param certificateResource 本地证书 比如 server.cer
/// @param challenge 授权挑战
+ (BOOL)verifyCertificateResource:(NSString *)certificateResource forAuthenticationWithChallenge:(NSURLAuthenticationChallenge *)challenge {

    // 证书认证
    static CFArrayRef certs;
    if (!certs) {
        // 获取cer格式CA证书路径
        NSString *cerPath = [[NSBundle mainBundle] pathForResource:certificateResource ofType:nil];
        // 提取二进制内容
        NSData *certData = [NSData dataWithContentsOfFile:cerPath];
        // 根据二进制内容提取证书信息
        SecCertificateRef rootcert =SecCertificateCreateWithData(kCFAllocatorDefault,CFBridgingRetain(certData));
        // 形成钥匙链
        const void *array[1] = { rootcert };
        certs = CFArrayCreate(NULL, array, 1, &kCFTypeArrayCallBacks);
        CFRelease(rootcert);    // for completeness, really does not matter
    }
    // 取出服务器证书
    SecTrustRef trust = [[challenge protectionSpace] serverTrust];
    int err;
    SecTrustResultType trustResult = 0;
    // 设置为我们自有的CA证书钥匙链
    err = SecTrustSetAnchorCertificates(trust, certs);
    if (err == noErr) {
        // 用CA证书验证服务器证书
        err = SecTrustEvaluate(trust,&trustResult);
    }
    //    CFRelease(trust); // !!!!千万不能调用这个release!!!!!
    // 检查结果
    BOOL trusted = (err == noErr) && ((trustResult == kSecTrustResultProceed)||(trustResult == kSecTrustResultConfirm) || (trustResult == kSecTrustResultUnspecified));

    return trusted;
}




//- (BOOL)myCustomVa:(NSURLAuthenticationChallenge *)challenge {
//    SecTrustRef challengeTrust = challenge.protectionSpace.serverTrust;
//    SecTrustResultType result;
//
////    NSArray *paths = [[NSBundle mainBundle] pathsForResourcesOfType:@"cer" inDirectory:@"."];
//
//    NSMutableArray *temp = [NSMutableArray array];
//
////    for (NSString *path in paths) {
//
//
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"jianshu" ofType:@"crt"];
//
//        NSData *data = [NSData dataWithContentsOfFile:path];
//        NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        if (dataStr) {
//            dataStr = [dataStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//            dataStr = [dataStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//            dataStr = [dataStr stringByReplacingOccurrencesOfString:@"-----BEGIN CERTIFICATE-----" withString:@""];
//            dataStr = [dataStr stringByReplacingOccurrencesOfString:@"-----END CERTIFICATE-----" withString:@""];
//            NSData *resultData = [[NSData alloc] initWithBase64EncodedString:dataStr options:0];
//            if (resultData) {
//                SecCertificateRef cerRef = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)resultData);
//                [temp addObject:(__bridge_transfer id)(cerRef)];
//            }
//        }
////    }
//
//    NSLog(@"本地证书信息是  %@  ", dataStr);
//
//    SecTrustSetAnchorCertificates(challengeTrust, (__bridge CFArrayRef)temp);
//    OSStatus status = SecTrustEvaluate(challengeTrust, &result);
//    if (status == errSecSuccess && (result == kSecTrustResultProceed || result == kSecTrustResultUnspecified)) {
//        return YES;
//    }
//    return NO;
//}


///// 需要响应身份验证时调用 同样在block中需要传入用户身份凭证
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
//
//
//    // 证书验证
////    BOOL trusted = [CKJSecret verifyCertificateResource:@"server.cer" forAuthenticationWithChallenge:challenge];
//
//
//
////    SecTrustRef servertrust = challenge.protectionSpace.serverTrust;
////
////    SecCertificateRef certi= SecTrustGetCertificateAtIndex(servertrust, 0);
////
////    NSData *certidata = CFBridgingRelease(CFBridgingRetain(CFBridgingRelease(SecCertificateCopyData(certi))));
////
////    NSString *path = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"der"];
////
////
////    NSData *localCertiData = [NSData dataWithContentsOfFile:path];
////
////
////
////
////    if ([certidata isEqualToData:localCertiData]) {
////        NSLog(@"验证证书通过");
////        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
////        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
////        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
////    }else{
////        NSLog(@"验证证书不通过");
////        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
////
////        [CKJHUD kjwd_showMessageAutoHide:@"此服务器证书不受信任，您可能正连接到一个伪装的网站，请确保你的网络安全"];
////    }
//
//    //弹窗版
//
//    NSString *hostName = webView.URL.host;
//
//    NSString *authenticationMethod = [[challenge protectionSpace] authenticationMethod];
//
//    if ([authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
//        SecTrustRef secTrustRef = challenge.protectionSpace.serverTrust;
//        if (secTrustRef != NULL) {
//
//            SecTrustResultType result;
//
//            OSErr er = SecTrustEvaluate(secTrustRef, &result);
//
//            if (er != noErr) {
//                completionHandler(NSURLSessionAuthChallengeRejectProtectionSpace, nil);
//                return;
//            }
//            if (result == kSecTrustResultRecoverableTrustFailure) {
//                //证书不受信任
//
//                CFArrayRef secTrustProperties = SecTrustCopyProperties(secTrustRef);
//
//                NSArray *arr = CFBridgingRelease(secTrustProperties);
//                NSMutableString *errorStr = [NSMutableString string];
//                for (int i=0;i<arr.count;i++){
//                    NSDictionary *dic = [arr objectAtIndex:i];
//                    if (i != 0 ) [errorStr appendString:@" "];
//                    [errorStr appendString:(NSString*)dic[@"value"]];
//                }
//
//                NSLog(@"证书验证错误信息 %@   ", errorStr);
//
//                SecCertificateRef certRef = SecTrustGetCertificateAtIndex(secTrustRef, 0);
//
//                CFStringRef cfCertSummaryRef = SecCertificateCopySubjectSummary(certRef);
//                NSString *certSummary = (NSString *)CFBridgingRelease(cfCertSummaryRef);
//
//                NSString *title = @"该服务器无法验证";
//
//                NSString *message = [NSString stringWithFormat:@" 是否通过来自%@标识为 %@证书为%@的验证. \n%@" , @"我的app",hostName,certSummary, errorStr];
//
//                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
//
//                [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                    completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
//                }]];
//                [alertController addAction:[UIAlertAction actionWithTitle:@"Continue" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//                    NSURLCredential* credential = [NSURLCredential credentialForTrust:secTrustRef];
//                    completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
//                }]];
//
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self presentViewController:alertController animated:YES completion:^{}];
//                });
//                return;
//            }
//            NSURLCredential* credential = [NSURLCredential credentialForTrust:secTrustRef];
//            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
//            return;
//        }
//        completionHandler(NSURLSessionAuthChallengeRejectProtectionSpace, nil);
//    }
//    else {
//        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
//    }
//}


////发送客户端证书交由服务器验证
//static private func sendClientCer() -> (URLSession.AuthChallengeDisposition, URLCredential?) {
//
//    let disposition = URLSession.AuthChallengeDisposition.useCredential
//    var credential: URLCredential?
//
//    //获取项目中P12证书文件的路径
//    let path: String = Bundle.main.path(forResource: "你本地的p12证书文件名", ofType: "p12")!
//    let PKCS12Data = NSData(contentsOfFile:path)!
//    let key : NSString = kSecImportExportPassphrase as NSString
//    let options : NSDictionary = [key : "p12证书的密码"] //客户端证书密码
//
//    var items: CFArray?
//    let error = SecPKCS12Import(PKCS12Data, options, &items)
//
//    if error == errSecSuccess {
//
//        let itemArr = items! as Array
//        let item = itemArr.first!
//
//        let identityPointer = item["identity"];
//        let secIdentityRef = identityPointer as! SecIdentity
//
//        let chainPointer = item["chain"]
//        let chainRef = chainPointer as? [Any]
//
//        credential = URLCredential.init(identity: secIdentityRef, certificates: chainRef, persistence: URLCredential.Persistence.forSession)
//
//    }
//
//    return (disposition, credential)
//
//}

@end



@implementation CKJRSA


/*
 static NSString *base64_encode(NSString *str){
 NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
 if(!data){
 return nil;
 }
 return base64_encode_data(data);
 }
 */

static NSString *base64_encode_data(NSData *data){
    data = [data base64EncodedDataWithOptions:0];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

static NSData *base64_decode(NSString *str){
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return data;
}

+ (NSData *)stripPublicKeyHeader:(NSData *)d_key{
    // Skip ASN.1 public key header
    if (d_key == nil) return(nil);
    
    unsigned long len = [d_key length];
    if (!len) return(nil);
    
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    unsigned int  idx     = 0;
    
    if (c_key[idx++] != 0x30) return(nil);
    
    if (c_key[idx] > 0x80) idx += c_key[idx] - 0x80 + 1;
    else idx++;
    
    // PKCS #1 rsaEncryption szOID_RSA_RSA
    static unsigned char seqiod[] =
    { 0x30,   0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01,
        0x01, 0x05, 0x00 };
    if (memcmp(&c_key[idx], seqiod, 15)) return(nil);
    
    idx += 15;
    
    if (c_key[idx++] != 0x03) return(nil);
    
    if (c_key[idx] > 0x80) idx += c_key[idx] - 0x80 + 1;
    else idx++;
    
    if (c_key[idx++] != '\0') return(nil);
    
    // Now make a new NSData from this buffer
    return([NSData dataWithBytes:&c_key[idx] length:len - idx]);
}

//credit: http://hg.mozilla.org/services/fx-home/file/tip/Sources/NetworkAndStorage/CryptoUtils.m#l1036
+ (NSData *)stripPrivateKeyHeader:(NSData *)d_key{
    // Skip ASN.1 private key header
    if (d_key == nil) return(nil);
    
    unsigned long len = [d_key length];
    if (!len) return(nil);
    
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    unsigned int  idx     = 22; //magic byte at offset 22
    
    if (0x04 != c_key[idx++]) return nil;
    
    //calculate length of the key
    unsigned int c_len = c_key[idx++];
    int det = c_len & 0x80;
    if (!det) {
        c_len = c_len & 0x7f;
    } else {
        int byteCount = c_len & 0x7f;
        if (byteCount + idx > len) {
            //rsa length field longer than buffer
            return nil;
        }
        unsigned int accum = 0;
        unsigned char *ptr = &c_key[idx];
        idx += byteCount;
        while (byteCount) {
            accum = (accum << 8) + *ptr;
            ptr++;
            byteCount--;
        }
        c_len = accum;
    }
    
    // Now make a new NSData from this buffer
    return [d_key subdataWithRange:NSMakeRange(idx, c_len)];
}

+ (SecKeyRef)addPublicKey:(NSString *)key{
    NSRange spos = [key rangeOfString:@"-----BEGIN PUBLIC KEY-----"];
    NSRange epos = [key rangeOfString:@"-----END PUBLIC KEY-----"];
    if(spos.location != NSNotFound && epos.location != NSNotFound){
        NSUInteger s = spos.location + spos.length;
        NSUInteger e = epos.location;
        NSRange range = NSMakeRange(s, e-s);
        key = [key substringWithRange:range];
    }
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@" "  withString:@""];
    
    // This will be base64 encoded, decode it.
    NSData *data = base64_decode(key);
    data = [self stripPublicKeyHeader:data];
    if(!data){
        return nil;
    }
    
    //a tag to read/write keychain storage
    NSString *tag = @"RSAUtil_PubKey";
    NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
    
    // Delete any old lingering key with the same tag
    NSMutableDictionary *publicKey = [[NSMutableDictionary alloc] init];
    [publicKey setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass];
    [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [publicKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    SecItemDelete((__bridge CFDictionaryRef)publicKey);
    
    // Add persistent version of the key to system keychain
    [publicKey setObject:data forKey:(__bridge id)kSecValueData];
    [publicKey setObject:(__bridge id) kSecAttrKeyClassPublic forKey:(__bridge id)
     kSecAttrKeyClass];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)
     kSecReturnPersistentRef];
    
    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)publicKey, &persistKey);
    if (persistKey != nil){
        CFRelease(persistKey);
    }
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        return nil;
    }
    
    [publicKey removeObjectForKey:(__bridge id)kSecValueData];
    [publicKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    
    // Now fetch the SecKeyRef version of the key
    SecKeyRef keyRef = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)publicKey, (CFTypeRef *)&keyRef);
    if(status != noErr){
        return nil;
    }
    return keyRef;
}

+ (SecKeyRef)addPrivateKey:(NSString *)key{
    NSRange spos;
    NSRange epos;
    spos = [key rangeOfString:@"-----BEGIN RSA PRIVATE KEY-----"];
    if(spos.length > 0){
        epos = [key rangeOfString:@"-----END RSA PRIVATE KEY-----"];
    }else{
        spos = [key rangeOfString:@"-----BEGIN PRIVATE KEY-----"];
        epos = [key rangeOfString:@"-----END PRIVATE KEY-----"];
    }
    if(spos.location != NSNotFound && epos.location != NSNotFound){
        NSUInteger s = spos.location + spos.length;
        NSUInteger e = epos.location;
        NSRange range = NSMakeRange(s, e-s);
        key = [key substringWithRange:range];
    }
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@" "  withString:@""];
    
    // This will be base64 encoded, decode it.
    NSData *data = base64_decode(key);
    data = [CKJRSA stripPrivateKeyHeader:data];
    if(!data){
        return nil;
    }
    
    //a tag to read/write keychain storage
    NSString *tag = @"RSAUtil_PrivKey";
    NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
    
    // Delete any old lingering key with the same tag
    NSMutableDictionary *privateKey = [[NSMutableDictionary alloc] init];
    [privateKey setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass];
    [privateKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [privateKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    SecItemDelete((__bridge CFDictionaryRef)privateKey);
    
    // Add persistent version of the key to system keychain
    [privateKey setObject:data forKey:(__bridge id)kSecValueData];
    [privateKey setObject:(__bridge id) kSecAttrKeyClassPrivate forKey:(__bridge id)
     kSecAttrKeyClass];
    [privateKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)
     kSecReturnPersistentRef];
    
    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)privateKey, &persistKey);
    if (persistKey != nil){
        CFRelease(persistKey);
    }
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        return nil;
    }
    
    [privateKey removeObjectForKey:(__bridge id)kSecValueData];
    [privateKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [privateKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    [privateKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    
    // Now fetch the SecKeyRef version of the key
    SecKeyRef keyRef = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)privateKey, (CFTypeRef *)&keyRef);
    if(status != noErr){
        return nil;
    }
    return keyRef;
}

/* START: Encryption & Decryption with RSA private key */

+ (NSData *)encryptData:(NSData *)data withKeyRef:(SecKeyRef) keyRef isSign:(BOOL)isSign {
    const uint8_t *srcbuf = (const uint8_t *)[data bytes];
    size_t srclen = (size_t)data.length;
    
    size_t block_size = SecKeyGetBlockSize(keyRef) * sizeof(uint8_t);
    void *outbuf = malloc(block_size);
    size_t src_block_size = block_size - 11;
    
    NSMutableData *ret = [[NSMutableData alloc] init];
    for(int idx=0; idx<srclen; idx+=src_block_size){
        //NSLog(@"%d/%d block_size: %d", idx, (int)srclen, (int)block_size);
        size_t data_len = srclen - idx;
        if(data_len > src_block_size){
            data_len = src_block_size;
        }
        
        size_t outlen = block_size;
        OSStatus status = noErr;
        
        if (isSign) {
            status = SecKeyRawSign(keyRef,
                                   kSecPaddingPKCS1,
                                   srcbuf + idx,
                                   data_len,
                                   outbuf,
                                   &outlen
                                   );
        } else {
            status = SecKeyEncrypt(keyRef,
                                   kSecPaddingPKCS1,
                                   srcbuf + idx,
                                   data_len,
                                   outbuf,
                                   &outlen
                                   );
        }
        if (status != 0) {
            NSLog(@"SecKeyEncrypt fail. Error Code: %d", status);
            ret = nil;
            break;
        }else{
            [ret appendBytes:outbuf length:outlen];
        }
    }
    
    free(outbuf);
    CFRelease(keyRef);
    return ret;
}

+ (NSString *)encryptString:(NSString *)str privateKey:(NSString *)privKey{
    NSData *data = [CKJRSA encryptData:[str dataUsingEncoding:NSUTF8StringEncoding] privateKey:privKey];
    NSString *ret = base64_encode_data(data);
    return ret;
}

+ (NSData *)encryptData:(NSData *)data privateKey:(NSString *)privKey{
    if ([self dataIsEmpty:data] || [self strIsEmpty:privKey]) {
        return nil;
    }
    SecKeyRef keyRef = [CKJRSA addPrivateKey:privKey];
    if(!keyRef){
        return nil;
    }
    return [CKJRSA encryptData:data withKeyRef:keyRef isSign:YES];
}

+ (NSData *)decryptData:(NSData *)data withKeyRef:(SecKeyRef) keyRef{
    if ([self dataIsEmpty:data]) {
        return nil;
    }
    
    const uint8_t *srcbuf = (const uint8_t *)[data bytes];
    size_t srclen = (size_t)data.length;
    
    size_t block_size = SecKeyGetBlockSize(keyRef) * sizeof(uint8_t);
    UInt8 *outbuf = malloc(block_size);
    size_t src_block_size = block_size;
    
    NSMutableData *ret = [[NSMutableData alloc] init];
    for(int idx=0; idx<srclen; idx+=src_block_size){
        //NSLog(@"%d/%d block_size: %d", idx, (int)srclen, (int)block_size);
        size_t data_len = srclen - idx;
        if(data_len > src_block_size){
            data_len = src_block_size;
        }
        
        size_t outlen = block_size;
        OSStatus status = noErr;
        status = SecKeyDecrypt(keyRef,
                               kSecPaddingNone,
                               srcbuf + idx,
                               data_len,
                               outbuf,
                               &outlen
                               );
        if (status != 0) {
            NSLog(@"SecKeyEncrypt fail. Error Code: %d", status);
            ret = nil;
            break;
        }else{
            //the actual decrypted data is in the middle, locate it!
            int idxFirstZero = -1;
            int idxNextZero = (int)outlen;
            for ( int i = 0; i < outlen; i++ ) {
                if ( outbuf[i] == 0 ) {
                    if ( idxFirstZero < 0 ) {
                        idxFirstZero = i;
                    } else {
                        idxNextZero = i;
                        break;
                    }
                }
            }
            
            [ret appendBytes:&outbuf[idxFirstZero+1] length:idxNextZero-idxFirstZero-1];
        }
    }
    
    free(outbuf);
    CFRelease(keyRef);
    return ret;
}


+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey{
    if ([self strIsEmpty:str] || [self strIsEmpty:privKey]) {
        return nil;
    }
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    if ([self dataIsEmpty:data]) {
        return nil;
    }
    
    data = [self decryptData:data privateKey:privKey];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey{
    if ([self dataIsEmpty:data] || [self strIsEmpty:privKey]) {
        return nil;
    }
    SecKeyRef keyRef = [self addPrivateKey:privKey];
    if(!keyRef){
        return nil;
    }
    return [self decryptData:data withKeyRef:keyRef];
}

/* END: Encryption & Decryption with RSA private key */

/* START: Encryption & Decryption with RSA public key */

+ (nullable NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey{
    if ([self strIsEmpty:str] || [self strIsEmpty:pubKey]) {
        return nil;
    }
    NSData *data = [self encryptData:[str dataUsingEncoding:NSUTF8StringEncoding] publicKey:pubKey];
    NSString *ret = base64_encode_data(data);
    return ret;
}

+ (nullable NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey{
    if ([self dataIsEmpty:data] || [self strIsEmpty:pubKey]) {
        return nil;
    }
    
    SecKeyRef keyRef = [self addPublicKey:pubKey];
    if(!keyRef){
        return nil;
    }
    return [self encryptData:data withKeyRef:keyRef isSign:NO];
}

+ ( NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey{
    if ([self strIsEmpty:str] || [self strIsEmpty:pubKey]) {
        return nil;
    }
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    data = [self decryptData:data publicKey:pubKey];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey{
    if ([self dataIsEmpty:data] || [self strIsEmpty:pubKey]) {
        return nil;
    }
    SecKeyRef keyRef = [self addPublicKey:pubKey];
    if(!keyRef){
        return nil;
    }
    return [self decryptData:data withKeyRef:keyRef];
}

/* END: Encryption & Decryption with RSA public key */




+ (NSData *)getHashBytes:(NSData *)plainText {
    CC_SHA1_CTX ctx;
    uint8_t * hashBytes = NULL;
    NSData * hash = nil;
    
    // Malloc a buffer to hold hash.
    hashBytes = malloc( CC_SHA1_DIGEST_LENGTH * sizeof(uint8_t) );
    memset((void *)hashBytes, 0x0, CC_SHA1_DIGEST_LENGTH);
    // Initialize the context.
    CC_SHA1_Init(&ctx);
    // Perform the hash.
    CC_SHA1_Update(&ctx, (void *)[plainText bytes], (CC_LONG)[plainText length]);
    // Finalize the output.
    CC_SHA1_Final(hashBytes, &ctx);
    
    // Build up the SHA1 blob.
    hash = [NSData dataWithBytes:(const void *)hashBytes length:(NSUInteger)CC_SHA1_DIGEST_LENGTH];
    if (hashBytes) free(hashBytes);
    
    return hash;
}

+ (NSString *)signTheDataSHA1WithRSA:(NSString *)str p12FileName:(NSString *)p12FileName p12FilePassword:(NSString *)p12FilePassword {
    uint8_t* signedBytes = NULL;
    size_t signedBytesSize = 0;
    OSStatus sanityCheck = noErr;
    NSData* signedHash = nil;
    
    NSString * path = [[NSBundle mainBundle] pathForResource:p12FileName ofType:@"p12"];
    NSData * data = [NSData dataWithContentsOfFile:path];
    NSMutableDictionary * options = [[NSMutableDictionary alloc] init]; // Set the private key query dictionary.
    [options setValue:p12FilePassword forKey:(id)kSecImportExportPassphrase];
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    OSStatus securityError = SecPKCS12Import((CFDataRef) data, (CFDictionaryRef)options, &items);
    if (securityError!=noErr) {
        return nil ;
    }
    CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
    SecIdentityRef identityApp =(SecIdentityRef)CFDictionaryGetValue(identityDict,kSecImportItemIdentity);
    SecKeyRef privateKeyRef=nil;
    SecIdentityCopyPrivateKey(identityApp, &privateKeyRef);
    signedBytesSize = SecKeyGetBlockSize(privateKeyRef);
    
    NSData *plainTextBytes = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    signedBytes = malloc( signedBytesSize * sizeof(uint8_t) ); // Malloc a buffer to hold signature.
    memset((void *)signedBytes, 0x0, signedBytesSize);
    
    sanityCheck = SecKeyRawSign(privateKeyRef,
                                kSecPaddingPKCS1SHA1,
                                (const uint8_t *)[[self getHashBytes:plainTextBytes] bytes],
                                CC_SHA1_DIGEST_LENGTH,
                                (uint8_t *)signedBytes,
                                &signedBytesSize);
    
    if (sanityCheck == noErr)
    {
        signedHash = [NSData dataWithBytes:(const void *)signedBytes length:(NSUInteger)signedBytesSize];
    }
    else
    {
        return nil;
    }
    
    if (signedBytes)
    {
        free(signedBytes);
    }
    NSString *signatureResult=[NSString stringWithFormat:@"%@",[signedHash base64EncodedStringWithOptions:0]];
    return signatureResult;
}


+ (BOOL)strIsEmpty:(NSString *)str {
    if (str == nil || ![str isKindOfClass:[NSString class]]) {
        return YES;
    }
    return NO;
}

+ (BOOL)dataIsEmpty:(NSData *)data {
    if (data == nil || ![data isKindOfClass:[NSData class]]) {
        return YES;
    }
    return NO;
}


+ (nullable NSString *)encrypt1_forText:(nullable NSString *)text {
    NSString *en = [CKJRSA encryptString:text publicKey:@"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDJRyOO0uyQeLCbfeaZxd1CkLne2vD2BUzCTi2CNugtDLeprbdkXmVsQ0YbnX08wKIWwL1Gp3RuXKieyCImjv1mvw+ztNzuTBIy2t9I4QeYi4j9zI4Nm82n09kFD8OUKf3b+mxr0n+uGy0c81CcdRC/0JyaRiH5lYZV4QTkrtCArQIDAQAB"];
    return en;
}

+ (nullable NSString *)decrypt1_forText:(NSString *)text {
    NSString *clearDe = [CKJRSA decryptString:text privateKey:@"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAMlHI47S7JB4sJt95pnF3UKQud7a8PYFTMJOLYI26C0Mt6mtt2ReZWxDRhudfTzAohbAvUandG5cqJ7IIiaO/Wa/D7O03O5MEjLa30jhB5iLiP3Mjg2bzafT2QUPw5Qp/dv6bGvSf64bLRzzUJx1EL/QnJpGIfmVhlXhBOSu0ICtAgMBAAECgYEAoThYJPiSAA6L96Ba62Tvm3ftSbI5O/Z2y1RvY1OzmRIMst6wfLaXqqYgK9J0FAuASZVMhqFuw094yOYpZJU4Jn5I5yliRK/nea/nLaVPsrxNIWGspJ9oxgBxuBhieG0wTuyyRheg9nzMVDf7u0TrMQhaev4q0P9Uo/uKhFd6XUkCQQDvrBWgRNCiJeBVahBOCocDfiL44e+RpR3ob8rSdGZwlLWIa3Dfqrv9oa+fFeaunENhZGZcznUDwizfa67vH6b3AkEA1v1zzDJgdvDZlzv63IX6YulX5FnG4dchEsSL/icT+giohdYrF6BpscY3V4a5ApzCLJYGXAS+MTzX8a2nYwT4ewJBAM+V0clVsQqwGaSBUAv4DEaXKr08G56fT88xfI9ZqBxcgPrebA4dt+OO9iio9HtJ9wZUymAZpboSpYEBqKuOU7MCQA2ksfeQbty9diGJ1eauvfAO/Nvp8pwcaeXmAThUxIjGieNMbxmlvW9hs9tjGlSXHB92OdsXFfbL9KxKp+e5xgcCQQDszIWZ+YJe8udXicHdyS16nGX1iLdFJnFjMtLGUkyP6y+yB4vxcC9v2rXEGWS3RwhgWDurudkiUcniBDfMmHIm"];
    return clearDe;
}


@end




@implementation CKJAES


+ (BOOL)strIsEmpty:(NSString *)str {
    if (str == nil || ![str isKindOfClass:[NSString class]]) {
        return YES;
    }
    return NO;
}

+ (BOOL)dataIsEmpty:(NSData *)data {
    if (data == nil || ![data isKindOfClass:[NSData class]]) {
        return YES;
    }
    return NO;
}




//AES加密解密#import <CommonCrypto/CommonCrypto.h>#import <CommonCrypto/CommonDigest.h>//AES128位加密 base64编码 注：kCCKeySizeAES128点进去可以更换256位加密
+(nullable NSString *)AES128Encrypt:(NSString *)plainText key:(NSString *)key
{
    if ([self strIsEmpty:plainText] || [self strIsEmpty:key]) {
          return nil;
      }
    
    
    char keyPtr[kCCKeySizeAES128+1];//
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        
        NSString *stringBase64 = [resultData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed]; // base64格式的字符串
        return stringBase64;
        
    }
    free(buffer);
    return nil;
}

//解密
+(nullable NSString *)AES128Decrypt:(NSString *)encryptText key:(NSString *)key {
    if ([self strIsEmpty:encryptText] || [self strIsEmpty:key]) {
             return nil;
         }
    
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:encryptText options:NSDataBase64DecodingIgnoreUnknownCharacters];//base64解码
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        
        return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    }
    free(buffer);
    return nil;
}



+ (JSContext *)commonJSContext {
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
        NSLog(@"弹出 %@   ", result);
    };
    return ctx;
}

//+ (nullable NSString *)js_aes_cbc_encrypt  WithData:(id)data iv:(NSString *)iv key:(NSString *)key {
//    
//}


@end

@interface CKJGMSecret ()

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation CKJGMSecret

- (instancetype)init {
    if (self = [super init]) {
        WKWebView *webView = [[WKWebView alloc] init];
        webView.frame = [UIScreen mainScreen].bounds;
//        webView.UIDelegate = self;
//        webView.navigationDelegate = self;
        NSBundle *resourcesBundle = [CKJWorker kjbundle];
        NSString *path = [resourcesBundle pathForResource:@"SM2 Algorithm Encryption and Decryption sample" ofType:@"html" inDirectory:@"SM2"]; // 这个www文件夹拖入项目中时Added folders选择 Create folder references，并且放在根目录里
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        [webView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
        self.webView = webView;
    }
    return self;
}


/// 生成公私钥（注意：请提前初始化本类对象，不然可能html还没有读取完毕）
/// @param curve 有sm2、secp256r1、secp256k1、secp384r1 这几种， 传nil默认是sm2
- (void)sm2_generate_publicKey_privateKeyWithCurve:(NSString *_Nullable)curve completion:(void(^_Nullable)(NSString *publicKey, NSString *privateKey))completion {
   
    if (WDKJ_IsEmpty_Str(curve)) {
        curve = @"sm2";
    }
    
    NSString *exe = [NSString stringWithFormat:@"sm2_generate_publicKey_privateKey('sm2')"];
    
    [self.webView evaluateJavaScript:exe completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        if (error) {
            NSLog(@"SM2获取 公私钥 错误 %@   ", error);
            return;
        }
        if (completion) {
            completion(obj[@"publicKey"], obj[@"privateKey"]);
        }
    }];
}


/// 加密（注意：请提前初始化本类对象，不然可能html还没有读取完毕）
/// @param cipherMode  0是C1C2C3    1是C1C3C2
- (void)sm2_encryptWithStr:(NSString *)str publicKey:(NSString *)publicKey cipherMode:(NSString *_Nullable)cipherMode completion:(void(^_Nullable)(NSString *encryptStr))completion {
    
     if (WDKJ_IsEmpty_Str(cipherMode)) {   // 0是C1C2C3    1是C1C3C2
         cipherMode = @"0";
     }
     
    NSString *exe = [NSString stringWithFormat:@"sm2_encrypt('%@', '%@', '%@')", str, publicKey, cipherMode];

     
     [self.webView evaluateJavaScript:exe completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
         if (error) {
             NSLog(@"SM2加密 失败 %@   ", error);
             return;
         }
         if (completion) {
             completion(obj);
         }
     }];
}


/// 解密（注意：请提前初始化本类对象，不然可能html还没有读取完毕）
/// @param cipherMode  0是C1C2C3    1是C1C3C2
- (void)sm2_decryptWithEncryptStr:(NSString *)encryptStr privateKey:(NSString *)privateKey cipherMode:(NSString *_Nullable)cipherMode completion:(void(^_Nullable)(NSString *decryptStr))completion {
    
     if (WDKJ_IsEmpty_Str(cipherMode)) {   // 0是C1C2C3    1是C1C3C2
         cipherMode = @"0";
     }
     
    NSString *exe = [NSString stringWithFormat:@"sm2_decrypt('%@', '%@', '%@')", encryptStr, privateKey, cipherMode];

     [self.webView evaluateJavaScript:exe completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
         if (error) {
             NSLog(@"SM2解密 失败 %@   ", error);
             return;
         }
         if (completion) {
             completion(obj);
         }
     }];
}

- (void)dealloc {
    NSLog(@"%@  dealloc  ", self);
}


+ (BOOL)strIsEmpty:(NSString *)str {
    if (str == nil || ![str isKindOfClass:[NSString class]] || [str isEqualToString:@""]) {
        return YES;
    }
    return NO;
}


@end

