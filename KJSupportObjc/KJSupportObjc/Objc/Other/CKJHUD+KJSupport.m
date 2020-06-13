//
//  CKJHUD+KJSupport.m
//  Demo
//
//  Created by admin2 on 2020/3/7.
//  Copyright © 2020 admin2. All rights reserved.
//

#import "CKJHUD+KJSupport.h"
#include "NSObject+WDYHFCategory.h"

@implementation CKJHUD (KJSupport)

+ (void)kjwd_showMessage:(NSString *)msg {
    [self kjwd_showMessage:msg toView:[UIWindow kjwd_appdelegateWindow]];
}
+ (void)kjwd_showMessage:(NSString *)msg toView:(nullable UIView *)view {
    if (WDKJ_IsNullObj(view, [UIView class])) {
        view = [UIWindow kjwd_appdelegateWindow];
    }
    msg = WDKJ_ConfirmString(msg);
    CKJHUD *hud = [CKJHUD showHUDAddedTo:view animated:YES];
    
    hud.detailsLabelText = msg;
    hud.detailsLabelFont = [UIFont systemFontOfSize:14];
    
    hud.mode = CKJHUDModeText;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    NSTimeInterval delay = 2;
    if (msg.length > 10) {
        delay = 4;
    }
    [hud hide:YES afterDelay:delay];
}


+ (CKJHUD *)addHudMessage:(NSString *)msg toView:(UIView *)view {
    if (WDKJ_IsNullObj(view, [UIView class])) {
        view = [UIWindow kjwd_appdelegateWindow];
    }
    // 快速显示一个提示信息
    CKJHUD *hud = [CKJHUD showHUDAddedTo:view animated:YES];
    hud.labelText = msg;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
//    hud.dimBackground = YES;
    return hud;
}


+ (void)hideHUDForView:(UIView *)view {
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD {
    [self hideHUDForView:nil];
}


@end
