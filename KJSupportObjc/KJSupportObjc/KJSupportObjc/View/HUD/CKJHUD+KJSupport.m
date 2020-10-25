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

+ (void)kjwd_showMessageAutoHide:(NSString *)msg {
    [self kjwd_showMessageAutoHide:msg toView:[UIWindow kjwd_appdelegateWindow]];
}
+ (void)kjwd_showMessageAutoHide:(NSString *)msg toView:(nullable UIView *)view {
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
        delay = 3.5;
    }
    [hud hide:YES afterDelay:delay];
}


+ (CKJHUD *)kjwd_showMsg:(NSString *)msg {
    return [self kjwd_showMsg:msg toView:nil];
}
+ (CKJHUD *)kjwd_showMsg:(NSString *)msg toView:(nullable UIView *)view {
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
    return hud;
}

+ (CKJHUD *)kjwd_showLoadingMessage:(NSString *)msg toView:(UIView *)view {
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


+ (void)kjwd_showMessageAutoHide:(NSString *)msg icon:(NSString *)icon {
    [self kjwd_showMessageAutoHide:msg icon:icon toView:nil];
}
+ (void)kjwd_showMessageAutoHide:(NSString *)msg icon:(NSString *)icon toView:(nullable UIView *)view {
    CKJHUD *hud = [self kjwd_showMsg:msg icon:icon toView:view];
    NSTimeInterval delay = 2;
    if (msg.length > 10) {
        delay = 3.5;
    }
    [hud hide:YES afterDelay:delay];
}

+ (CKJHUD *)kjwd_showMsg:(NSString *)msg icon:(NSString *)icon {
    return [self kjwd_showMsg:msg icon:icon toView:nil];
}

+ (CKJHUD *)kjwd_showMsg:(NSString *)msg icon:(NSString *)icon toView:(nullable UIView *)view {
    if (WDKJ_IsNullObj(view, [UIView class])) {
        view = [UIWindow kjwd_appdelegateWindow];
    }
    msg = WDKJ_ConfirmString(msg);
    CKJHUD *hud = [CKJHUD showHUDAddedTo:view animated:YES];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    
    hud.detailsLabelText = msg;
    hud.detailsLabelFont = [UIFont systemFontOfSize:14];
    
    hud.mode = CKJHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

+ (void)hideHUDForView:(UIView *)view {
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD {
    [self hideHUDForView:nil];
}


@end
