//
//  CKJHUD+KJSupport.h
//  Demo
//
//  Created by admin2 on 2020/3/7.
//  Copyright © 2020 admin2. All rights reserved.
//

#import "CKJHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface CKJHUD (KJSupport)

+ (void)kjwd_showMessageAutoHide:(NSString *)msg;
+ (void)kjwd_showMessageAutoHide:(NSString *)msg toView:(nullable UIView *)view;

+ (CKJHUD *)kjwd_showMsg:(NSString *)msg;
+ (CKJHUD *)kjwd_showMsg:(NSString *)msg toView:(nullable UIView *)view;




+ (void)kjwd_showMessageAutoHide:(NSString *)msg icon:(NSString *)icon;
+ (void)kjwd_showMessageAutoHide:(NSString *)msg icon:(NSString *)icon toView:(nullable UIView *)view;

+ (CKJHUD *)kjwd_showMsg:(NSString *)msg icon:(NSString *)icon;
+ (CKJHUD *)kjwd_showMsg:(NSString *)msg icon:(NSString *)icon toView:(nullable UIView *)view;


+ (CKJHUD *)kjwd_showLoadingMessage:(NSString *)msg toView:(nullable UIView *)view;
+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end

NS_ASSUME_NONNULL_END
