//
//  CKJAuthImitateZhiFuBao.h
//  TDTouchID
//
//  Created by admin2 on 2020/6/20.
//  Copyright © 2020 admin2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKJAuthID.h"

NS_ASSUME_NONNULL_BEGIN




/*
 
支付宝登录

（面容/指纹 LAPolicyDeviceOwnerAuthenticationWithBiometrics）识别失败两三次，
 
 第一回. 1. 指纹 失败  2.指纹 失败  3. 指纹 失败 后消失(提示指纹不匹配)
 
 第二回. 1. 指纹 失败
        1. 指纹 成功  进入
 
        2. 指纹 失败后 弹出系统的输入密码
           a.密码输入成功后，回到第一回
           b.密码输入取消，再次调用会 进入第二回的2步骤
            

 
 第一回. 1. 面容 失败(msg:再试一次 btnTitle:再次尝试面容ID)   2. 面容 失败(msg:面容ID短时间内失败多次，需重新登录支付宝 btnTitle:重新登录支付宝)
 第二回. 1. 面容 失败(msg:再试一次 btnTitle:再次尝试面容ID)   2. 面容 失败(msg:面容ID短时间内失败多次，需重新登录支付宝 btnTitle:重新登录支付宝)
 第三回. 1. 无法使用面容ID(msg:无法使用面容ID btnTitle:重新登录支付宝)
 第四回. 1. 输入密码
            a.密码输入成功后，回到第一回
            b.密码输入取消， 回到第四回

 
 
 开启和关闭UISwitch时
 效果和首次授权一样  + (instancetype)firstAuth
 
 
 */




typedef void(^CKJAuthSuccess)(void);
typedef void(^CKJAuthUnrecognized)(void);
typedef void(^CKJAuthHandleCustomInputPwdBtn)(CKJAuthSuccess succ);

@interface CKJAuthImitateZhiFuBao : LAContext


/// 识别成功
@property (copy, nonatomic) CKJAuthSuccess auth_success;

/// 不能识别
@property (copy, nonatomic) CKJAuthUnrecognized auth_unrecognized;

/// 处理 自定义的（密码）按钮点击事件
@property (copy, nonatomic) CKJAuthHandleCustomInputPwdBtn auth_handleCustomInputPwdBtn;



/// 首次授权，开启和关闭UISwitch都是这个方法
/// @param yourTruePwd 你真实的登录密码
+ (instancetype)firstAuthWithYourTruePwd:(nullable NSString *)yourTruePwd auth_Success:(CKJAuthSuccess)auth_Success auth_unrecognized:(CKJAuthUnrecognized)auth_unrecognized;

/// 其他次授权
+ (instancetype)authInterfaceAuth_Success:(CKJAuthSuccess)auth_Success auth_unrecognized:(CKJAuthUnrecognized)auth_unrecognized customInputPwdBtnTitle:(nullable NSString *)customInputPwdBtnTitle auth_handleCustomInputPwdBtn:(CKJAuthHandleCustomInputPwdBtn)auth_handleCustomInputPwdBtn;

@end

NS_ASSUME_NONNULL_END
