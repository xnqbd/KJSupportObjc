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

+ (void)kjwd_showMessage:(NSString *)msg;
+ (void)kjwd_showMessage:(NSString *)msg toView:(nullable UIView *)view;

+ (CKJHUD *)addHudMessage:(NSString *)msg toView:(UIView *)view;
+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end

NS_ASSUME_NONNULL_END
