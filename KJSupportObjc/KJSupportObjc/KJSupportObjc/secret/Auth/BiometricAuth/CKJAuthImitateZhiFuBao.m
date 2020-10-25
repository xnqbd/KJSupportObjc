//
//  CKJAuthImitateZhiFuBao.m
//  TDTouchID
//
//  Created by admin2 on 2020/6/20.
//  Copyright © 2020 admin2. All rights reserved.
//

#import "CKJAuthImitateZhiFuBao.h"
#import <UIKit/UIKit.h>
#import "NSObject+WDYHFCategory.h"


@interface CKJAuthImitateZhiFuBao ()

@end

@implementation CKJAuthImitateZhiFuBao


+ (instancetype)firstAuthWithYourTruePwd:(nullable NSString *)yourTruePwd auth_Success:(CKJAuthSuccess)auth_Success auth_unrecognized:(CKJAuthUnrecognized)auth_unrecognized {
    CKJAuthImitateZhiFuBao *model = [[self alloc] init];
    
    __weak CKJAuthImitateZhiFuBao *weakModle = model;
    
    model.auth_success = ^{
        if (auth_Success) {
            auth_Success();
        }
    };
    model.auth_unrecognized = ^{
        if (auth_unrecognized) {
            auth_unrecognized();
        }
    };
    model.auth_handleCustomInputPwdBtn = ^(CKJAuthSuccess  _Nonnull succ) {
        [weakModle alertInputPwd:yourTruePwd];
    };
    
    model.localizedFallbackTitle = @"验证登录密码";  // 默认是 ”输入密码“
    if (![model canEvaluateBiometrics]) {
        if (auth_unrecognized) auth_unrecognized();
    }
    return model;
}

- (void)alertInputPwd:(NSString *)pwd {
    NSString *message = @"请输入登录密码";
    [UIAlertController kjwd_alertTitle:nil message:@"请输入登录密码" alertAction_Left:@"取消" leftBlock:^(UIAlertController *__weak  _Nonnull a) {
        [self canEvaluateBiometrics];
    } right:@"确定" rightBlock:^(UIAlertController *__weak  _Nonnull a) {
        UITextField *t = a.textFields.firstObject;
        
        NSLog(@"%@  %@ ", t.text, pwd);
        
        if (pwd) {
            if ([t.text isEqualToString:pwd]) {
                NSLog(@"%@   ", @"验证通过");
                if (self.auth_success) self.auth_success();
            } else {
//                [CKJHUD kjwd_showMessageAutoHide:@"密码不匹配"];
                [self alertWithPwd:pwd];
            }
        }
    } detail:^(UIAlertController * _Nonnull a) {
        [a addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = message;
        }];
    } presentingVC:nil];
}


- (void)alertWithPwd:(NSString *)pwd {
    [UIAlertController kjwd_alertTitle:nil message:@"密码输入错误" alertAction_Left:@"取消" leftBlock:^(UIAlertController *__weak  _Nonnull a) {
        [self canEvaluateBiometrics];
    } right:@"确定" rightBlock:^(UIAlertController *__weak  _Nonnull a) {
        [self alertInputPwd:pwd];
    } detail:^(UIAlertController * _Nonnull a) {
    } presentingVC:nil];
}

+ (instancetype)authInterfaceAuth_Success:(CKJAuthSuccess)auth_Success auth_unrecognized:(CKJAuthUnrecognized)auth_unrecognized customInputPwdBtnTitle:(nullable NSString *)customInputPwdBtnTitle auth_handleCustomInputPwdBtn:(CKJAuthHandleCustomInputPwdBtn)auth_handleCustomInputPwdBtn {
    CKJAuthImitateZhiFuBao *model = [[self alloc] init];
    
    model.auth_success = auth_Success;
    model.auth_unrecognized = auth_unrecognized;
    model.auth_handleCustomInputPwdBtn = auth_handleCustomInputPwdBtn;
    
    if (WDKJ_IsEmpty_Str(customInputPwdBtnTitle)) {
        NSString *displayName = [CKJAuthImitateZhiFuBao displayName];
        model.localizedFallbackTitle = [NSString stringWithFormat:@"重新登录%@", displayName];  // 默认是 ”输入密码“
    } else {
        model.localizedFallbackTitle = customInputPwdBtnTitle;
    }
    
    if (![model canEvaluateBiometrics]) {
        if (auth_unrecognized) auth_unrecognized();
    }
    return model;
}

- (void)noPwd {
    LAPolicy policy = LAPolicyDeviceOwnerAuthenticationWithBiometrics;
    [self _initConfigWithPolicy:policy];
    
    [CKJAuthID authWithLAContext:self policy:policy blockState:^(CKJBiometricsState state, NSError * _Nonnull error) {
        if (state == CKJBiometricsStateNotSupport) {    //不支持TouchID/FaceID
        } else if (state == CKJBiometricsStateSuccess) {    //TouchID/FaceID验证成功
            [self success];
        } else if (state == CKJBiometricsStateInputPassword) { //用户选择手动输入密码
            [self handleCustomBtn];
        } else if (state == CKJBiometricsStateLockout) {
            [self havePwd];
        }
    }];
}

- (void)havePwd {
    //    __weak typeof(self) weakSelf = self;
    LAPolicy policy = LAPolicyDeviceOwnerAuthentication;
    [self _initConfigWithPolicy:policy];
    
    [CKJAuthID authWithLAContext:self policy:policy blockState:^(CKJBiometricsState state, NSError * _Nonnull error) {
        if (state == CKJBiometricsStateNotSupport) {    //不支持TouchID/FaceID
            
        } else if (state == CKJBiometricsStateSuccess) {    //TouchID/FaceID验证成功
            [self noPwd];
        } else if (state == CKJBiometricsStateInputPassword) { //用户选择手动输入密码
            
            NSLog(@"不可能来到这里");
        }
    }];
    
}


/// 这里只有 LAPolicyDeviceOwnerAuthenticationWithBiometrics 情况才会来处理自定义按钮的情况
// LAPolicyDeviceOwnerAuthenticationWithBiometrics: 用TouchID/FaceID验证，锁定后，点击自定义的输入密码按钮（不会弹出系统的输入密码界面，会回调自定义的验证密码处理）
// LAPolicyDeviceOwnerAuthentication: 首先用TouchID/FaceID+密码验证, 锁定后,   点击自定义的输入密码按钮（会弹出系统的输入密码界面，会有取消回调)
- (void)handleCustomBtn {
    NSLog(@"自己处理  手动输入情况");
    if (self.auth_handleCustomInputPwdBtn) {
        self.auth_handleCustomInputPwdBtn(self.auth_success);
    }
}

- (void)success {
    NSLog(@"%@   ", @"真正的成功");
    if (self.auth_success) {
        self.auth_success();
    }
}

#pragma mark - 其他
- (void)_initConfigWithPolicy:(LAPolicy)policy {
    
    CKJBiometricsSupperType supperType = [CKJAuthID supperBiometrics:policy];
    
    NSString *localizedReason = @"进行生物认证";
    if (supperType == CKJBiometricsSupperTypeTouchID) {
        localizedReason = @"通过Home键验证已有指纹";
    } else if (supperType == CKJBiometricsSupperTypeFaceID) {
        localizedReason = [NSString stringWithFormat:@"面容ID短时间内失败多次，需重新登录%@", [CKJAuthImitateZhiFuBao displayName]];
    }
    
    if (@available(iOS 11.0, *)) {
        self.localizedReason = localizedReason;
    } else {
        
    }
}

- (void)dealloc {
    NSLog(@"%@   dealloc", self);
}



+ (NSString *)displayName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}

- (BOOL)canEvaluateBiometrics {
    if ([CKJAuthID supperBiometrics:LAPolicyDeviceOwnerAuthenticationWithBiometrics] != CKJBiometricsSupperTypeNone) {
        [self noPwd];
        return YES;
    } else if ([CKJAuthID supperBiometrics:LAPolicyDeviceOwnerAuthentication] != CKJBiometricsSupperTypeNone) {
        [self havePwd];
        return YES;
    }
    NSLog(@"不能识别");
    return NO;
}

@end
