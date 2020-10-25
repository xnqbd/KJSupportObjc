//
//  CKJBiometrics.m
//  CKJBiometrics
//
//  Created by admin2 on 2020/6/20.
//  Copyright © 2020 admin2. All rights reserved.
//

#import "CKJAuthID.h"
#import "NSObject+WDYHFCategory.h"

@implementation CKJAuthID

#define kBiometricsAccountPrefix(account)  [CKJAuthID encryptBy_aes:[NSString stringWithFormat:@"kSDBiometricsPrefix_%@", account]]


#define kCKJAuth_OPENED [CKJAuthID encryptBy_aes:@"opened"]
#define kCKJAuth_CLOSED [CKJAuthID encryptBy_aes:@"closed"]


static NSString *udid = nil;

+ (void)authWithLAContext:(LAContext *)context policy:(LAPolicy)policy blockState:(void(^)(CKJBiometricsState state,NSError *error))block {

    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        udid = [[[CKJKeyChain alloc] init] readUDID];
    });
    
    
    
    if (NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_8_0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"系统版本不支持TouchID (必须高于iOS 8.0才能使用)");
            block(CKJBiometricsStateVersionNotSupport, nil);
        });
        return;
    }
    
    NSError *error = nil;
    
    
    NSString *localizedReason = @"";
    if (@available(iOS 11.0, *)) {
          localizedReason = context.localizedReason;
    } else {
        
    }
    
    
    /*
     知识点
     
     LAPolicyDeviceOwnerAuthentication:用TouchID/FaceID/密码验证,  失败后弹出输入系统的密码界面
     生物校验失败三次将弹出设备密码输入框，如果不进行密码输入。再次进来还可以有两次机会进行生物校验，如果都失败则Touch ID（Face ID）被锁住，以后每次进来验证(即使APP杀死后重新启动)都是调用系统的密码直至输入正确的设备密码才能重新使用生物校验
     
     LAPolicyDeviceOwnerAuthenticationWithBiometrics: 用TouchID/FaceID验证， 失败后调用自定义的验证密码处理
     
     如果在支持 人脸识别的设备上， 调用起来确是输入密码， 那应该是Privacy - Face ID Usage Description 这个没有设置
     
     */
    
    /*
     
     - (BOOL)canEvaluatePolicy:(LAPolicy)policy error:(NSError * __autoreleasing *)error
     
     LAPolicyDeviceOwnerAuthenticationWithBiometrics  如果手机指纹/面容被锁定了，这个返回NO
     LAPolicyDeviceOwnerAuthentication                如果手机指纹/面容被锁定了，这个返回YES
     */
    if ([context canEvaluatePolicy:policy error:&error]) {
        
        /*
         - (void)evaluatePolicy:(LAPolicy)policy localizedReason:(NSString *)localizedReason reply:(void(^)(BOOL success, NSError * __nullable error))reply
         
         LAPolicyDeviceOwnerAuthenticationWithBiometrics: 用TouchID/FaceID验证，锁定后，点击自定义的输入密码按钮（不会弹出系统的输入密码界面，会回调自定义的验证密码处理）
         LAPolicyDeviceOwnerAuthentication: 首先用TouchID/FaceID+密码验证, 锁定后,   点击自定义的输入密码按钮（会弹出系统的输入密码界面，会有取消回调)
         */
        [context evaluatePolicy:policy localizedReason:localizedReason reply:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"TouchID 验证成功");
                    block(CKJBiometricsStateSuccess,error);
                });
            } else if(error) {
                switch (error.code) {
                    case LAErrorAuthenticationFailed:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 验证失败");
                            block(CKJBiometricsStateFail,error);
                        });
                        break;
                    }
                    case LAErrorUserCancel:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 被用户手动取消");
                            block(CKJBiometricsStateUserCancel,error);
                        });
                    }
                        break;
                    case LAErrorUserFallback:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"用户不使用TouchID,选择手动输入密码");
                            block(CKJBiometricsStateInputPassword,error);
                        });
                    }
                        break;
                    case LAErrorSystemCancel:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 被系统取消 (如遇到来电,锁屏,按了Home键等)");
                            block(CKJBiometricsStateSystemCancel,error);
                        });
                    }
                        break;
                    case LAErrorPasscodeNotSet:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 无法启动,因为用户没有设置密码");
                            block(CKJBiometricsStatePasswordNotSet,error);
                        });
                    }
                        break;
                    case LAErrorTouchIDNotEnrolled:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 无法启动,因为用户没有设置TouchID");
                            block(CKJBiometricsStateNotSet,error);
                        });
                    }
                        break;
                    case LAErrorTouchIDNotAvailable:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 无效");
                            block(CKJBiometricsStateNotAvailable,error);
                        });
                    }
                        break;
                    case LAErrorTouchIDLockout:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)");
                            block(CKJBiometricsStateLockout,error);
                        });
                    }
                        break;
                    case LAErrorAppCancel:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"当前软件被挂起并取消了授权 (如App进入了后台等)");
                            block(CKJBiometricsStateAppCancel,error);
                        });
                    }
                        break;
                    case LAErrorInvalidContext:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"当前软件被挂起并取消了授权 (LAContext对象无效)");
                            block(CKJBiometricsStateInvalidContext,error);
                        });
                    }
                        break;
                    default:
                        break;
                }
            }
        }];
        
    } else {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"当前设备不支持TouchID");
            block(CKJBiometricsStateNotSupport,error);
        });
    }
}

// 判断设备支持哪种认证方式 TouchID & FaceID
+ (CKJBiometricsSupperType)supperBiometrics:(LAPolicy)policy {
    LAContext *context = [[LAContext alloc] init];
    
    NSError *error;
    if ([context canEvaluatePolicy:policy error:&error]) {
        if (error != nil) {
            return CKJBiometricsSupperTypeNone;
        }
        if (@available(iOS 11.0, *)) {
            return context.biometryType == LABiometryTypeFaceID ? CKJBiometricsSupperTypeFaceID : CKJBiometricsSupperTypeTouchID;
        }
    }
    return CKJBiometricsSupperTypeNone;
}


+ (NSString *)supperStringBiometrics:(LAPolicy)policy {
    switch ([self supperBiometrics:policy]) {
        case CKJBiometricsSupperTypeFaceID:
            return @"面容";
            break;
        case CKJBiometricsSupperTypeTouchID:
            return @"指纹";
            break;
        default:
            return @"";
            break;
    }
}

+ (void)_setSwitchStatus:(BOOL)openStatus forAccount:(NSString *)account {
    if (WDKJ_IsEmpty_Str(account)) {
        return;
    }
    
    NSString *status = openStatus ? kCKJAuth_OPENED : kCKJAuth_CLOSED;
    
    [[NSUserDefaults standardUserDefaults] setObject:status forKey:kBiometricsAccountPrefix(account)];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self _getBiometricsSwitchStatusForAccount:account];
}

+ (CKJBiometricsUISwitchStatus)_getBiometricsSwitchStatusForAccount:(NSString *)account {
    if (WDKJ_IsEmpty_Str(account)) {
        return CKJBiometricsUISwitchStatus_Empty;
    }
    __block NSString *status = [[NSUserDefaults standardUserDefaults] stringForKey:kBiometricsAccountPrefix(account)];
    
    WDCKJ_ifDEBUG(^{
//        status = ;
        NSLog(@"只在DEBUG状态下打印 生物认证信息  账户:%@  status:%@", account, [self decryptBy_aes:status]);
    }, nil);
    
    if (WDKJ_IsEmpty_Str(status)) {
        return CKJBiometricsUISwitchStatus_Empty;
    }
    if ([status isEqualToString:kCKJAuth_OPENED]) {
        return CKJBiometricsUISwitchStatus_Opened;
    } else {
        return CKJBiometricsUISwitchStatus_Closed;
    }
}



+ (NSString *)decryptBy_aes:(NSString *)str {
    NSString *res = [CKJAES AES128Decrypt:str key:udid];
    return res;
}

+ (NSString *)encryptBy_aes:(NSString *)str { // AES
    NSString *res = [CKJAES AES128Encrypt:str key:udid];
    return res;
}



@end
