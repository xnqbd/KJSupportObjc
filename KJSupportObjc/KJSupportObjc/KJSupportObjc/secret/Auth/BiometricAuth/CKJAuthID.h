//
//  CKJBiometrics.h
//  CKJBiometrics
//
//  Created by admin2 on 2020/6/20.
//  Copyright © 2020 admin2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>


/**
 *  设备支持的生物验证方式
 */
typedef enum : NSUInteger {
    /**
     *  支持TouchID验证
     */
    CKJBiometricsSupperTypeTouchID = 1,
    /**
     *  支持FaceID验证
     */
    CKJBiometricsSupperTypeFaceID,
    /**
     *  不支持支持验证
     */
    CKJBiometricsSupperTypeNone,
} CKJBiometricsSupperType;


/**
 *  TouchID 状态
 */
typedef enum : NSUInteger {
    /**
     *  当前设备不支持生物验证 (或者因为多次识别后，被锁定了)
     */
    CKJBiometricsStateNotSupport = 1,
    /**
     *  生物验证 验证成功
     */
    CKJBiometricsStateSuccess,
    /**
     *  生物验证 验证失败
     */
    CKJBiometricsStateFail,
    /**
     *  生物验证 被用户手动取消
     */
    CKJBiometricsStateUserCancel,
    /**
     *  用户不使用生物验证,选择手动输入密码
     */
    CKJBiometricsStateInputPassword,
    /**
     *  生物验证 被系统取消 (如遇到来电,锁屏,按了Home键等)
     */
    CKJBiometricsStateSystemCancel,
    /**
     *  生物验证 无法启动,因为用户没有设置密码
     */
    CKJBiometricsStatePasswordNotSet,
    /**
     *  生物验证 无法启动,因为用户没有设置生物验证
     */
    CKJBiometricsStateNotSet,
    /**
     *  生物验证 无效
     */
    CKJBiometricsStateNotAvailable,
    /**
     *  生物验证 被锁定(连续多次验证生物验证失败,系统需要用户手动输入密码)
     */
    CKJBiometricsStateLockout,
    /**
     *  当前软件被挂起并取消了授权 (如App进入了后台等)
     */
    CKJBiometricsStateAppCancel,
    /**
     *  当前软件被挂起并取消了授权 (LAContext对象无效)
     */
    CKJBiometricsStateInvalidContext,
    /**
     *  系统版本不支持生物验证 (必须高于iOS 8.0才能使用)
     */
    CKJBiometricsStateVersionNotSupport,
} CKJBiometricsState;


typedef enum : NSUInteger { // 不要改变这0，1，2的值
    CKJBiometricsUISwitchStatus_Empty = 0,
    CKJBiometricsUISwitchStatus_Closed = 1,
    CKJBiometricsUISwitchStatus_Opened = 2
} CKJBiometricsUISwitchStatus;



NS_ASSUME_NONNULL_BEGIN


/// 生物认证（人脸、指纹）
@interface CKJAuthID : NSObject

+ (void)authWithLAContext:(LAContext *)context policy:(LAPolicy)policy blockState:(void(^)(CKJBiometricsState state,NSError *error))block;

+ (CKJBiometricsSupperType)supperBiometrics:(LAPolicy)policy;

+ (NSString *)supperStringBiometrics:(LAPolicy)policy;


/// 设置UISwitch生物认证状态(开启/关闭)
+ (void)_setSwitchStatus:(BOOL)openStatus forAccount:(NSString *)account;

/// 获取UISwitch生物认证状态(开启/关闭)
+ (CKJBiometricsUISwitchStatus)_getBiometricsSwitchStatusForAccount:(NSString *)account;

@end

NS_ASSUME_NONNULL_END
