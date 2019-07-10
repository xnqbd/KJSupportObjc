//
//  MBProgressHUD+WJ.h
//  healthYinZhou
//
//  Created by will on 15/8/11.
//  Copyright (c) 2015年 Wonders Information Co., LTD. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (WJ)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;
@end
