//
//  YWUnlockView.h
//  YWUnlock
//
//  Created by dyw on 2017/2/24.
//  Copyright © 2017年 dyw. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef enum : NSUInteger {
    CKJGesturesUnlockType_Create,//创建手势密码
    CKJGesturesUnlockType_Verify //验证手势密码
} CKJGesturesUnlockType;


NS_ASSUME_NONNULL_BEGIN

/*
 
 - (IBAction)createGe:(UIButton *)sender {
 
 NSString *account = self.accountTF.text;
 
 
 UIViewController *vc = [[UIViewController alloc] init];
 vc.view.backgroundColor = [UIColor whiteColor];
 
 __weak __typeof(self)weakSelf = self;
 
 CKJGesturesUnlockView *lockView = [CKJGesturesUnlockView createGesturePasswordForAccount:account detail:nil success:^{
 NSLog(@"成功");
 if (weakSelf.navigationController) {
 [weakSelf.navigationController popViewControllerAnimated:YES];
 } else {
 [weakSelf dismissViewControllerAnimated:YES completion:nil];
 }
 }];
 
 
 [lockView kjwd_masWithSuperView:vc.view makeConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
 make.left.right.equalTo(superview);
 make.top.equalTo(superview.kjwdMas_safeAreaTop);
 make.bottom.equalTo(superview.kjwdMas_safeAreaBottom);
 }];
 
 [self.navigationController pushViewController:vc animated:YES];
 
 }
 
 
 - (IBAction)test:(UIButton *)sender {
 NSString *account = self.accountTF.text;
 
 UIViewController *vc = [[UIViewController alloc] init];
 vc.view.backgroundColor = [UIColor whiteColor];
 
 __weak __typeof(self)weakSelf = self;
 
 CKJGesturesUnlockView *lockView = [CKJGesturesUnlockView verifyGesturePasswordForAccount:account detail:nil maxVerifyFail:^{
 [UIAlertController kjwd_alertTitle:@"手势密码已失效" message:@"请重新登录" alertAction_Left:nil leftBlock:nil right:@"重新登录" rightBlock:^(UIAlertController *__weak  _Nonnull a) {
 if (weakSelf.navigationController) {
 [weakSelf.navigationController popViewControllerAnimated:YES];
 } else {
 [weakSelf dismissViewControllerAnimated:YES completion:nil];
 }
 } detail:nil presentingVC:nil];
 } success:^{
 
 if (weakSelf.navigationController) {
 [weakSelf.navigationController popViewControllerAnimated:YES];
 } else {
 [weakSelf dismissViewControllerAnimated:YES completion:nil];
 }
 }];
 
 [lockView kjwd_masWithSuperView:vc.view makeConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
 make.left.right.equalTo(superview);
 make.top.equalTo(superview.kjwdMas_safeAreaTop);
 make.bottom.equalTo(superview.kjwdMas_safeAreaBottom);
 }];
 
 [self.navigationController pushViewController:vc animated:YES];
 }
 
 */


@class CKJGesturesUnlockView;

typedef void(^CKJUnlockSuccess)(__weak CKJGesturesUnlockView *v);

/// 超过最大解锁次数
typedef void(^CKJOverMaxUnlockCount)(__weak CKJGesturesUnlockView *_Nullable v);

/// 输入你的密码成功
typedef void(^CKJInput_yourTruePwd_success)(__weak CKJGesturesUnlockView *weakUnlockView);


@interface CKJGesturesUnlockView : UIView

- (NSString *)account;

/// 当前处理密码类型 (默认是创建密码)
@property (nonatomic, assign) CKJGesturesUnlockType type;


/// 创建手势密码
/// @param account 账户
/// @param success 创建手势密码成功回调
+ (nullable instancetype)createGesturePasswordForAccount:(NSString *)account detail:(void(^_Nullable)(CKJGesturesUnlockView *v))detail success:(CKJUnlockSuccess)success;


/// 验证手势密码
/// @param account 账户
/// @param overMaxUnlockCount 达到最大解锁次数后回调
/// @param success 验证成功后回调
+ (nullable instancetype)verifyGesturePasswordForAccount:(NSString *)account statusInitText:(NSString *_Nullable)statusInitText detail:(void(^_Nullable)(__weak CKJGesturesUnlockView *v))detail overMaxUnlockCount:(CKJOverMaxUnlockCount)overMaxUnlockCount success:(CKJUnlockSuccess)success;



#pragma mark - 验证手势 --- 忘记密码 相关

/// 增加输入密码弹框 (只在验证手势时 达到验证最大次数 才会显示) 注意：你或许应该调
/// @param yourTruePwd 你的登录密码
/// @param input_yourTruePwd_success 验证成功回调
- (void)addInputPwdAlertWithYourTruePwd:(NSString *)yourTruePwd input_yourTruePwd_success:(CKJInput_yourTruePwd_success)input_yourTruePwd_success;

//@property (copy, nonatomic, nullable) CKJSetRemainingUnLockCountToMaxCount setRemainingUnLockCountToMaxCount;

/// 重置剩余解锁次数为最大值，在验证(重置) 手势密码时才会有值（一、输入你的密码成功后可以重置一下）
+ (void)_setRemainingUnLockCountToMaxCountByAccount:(NSString *)account;


/// 展示输入密码框
- (void)showInputPwdAlert;


/// 自定义的展示输入密码事件
@property (copy, nonatomic, nullable) void (^customShowInputPwdAlert)(void);

#pragma mark - 其他

/// Window已经有了手势视图
//+ (BOOL)windowHaveGesturesUnlockView;

- (void)showFromWindowWithAnimation:(BOOL)animation;
- (void)hideFromWindowWithAnimation:(BOOL)animation;



/// 获取手势密码(密文)
+ (NSString *_Nullable)_getPasswordSecretByAccount:(NSString *)account;

/// 获取手势剩余解锁次数
+ (NSString *_Nullable)_getGesturesRemainingUnLockCountByAccount:(NSString *)account;

/// 设置UISwitch开关
+ (void)_setSwitchStatus:(BOOL)openStatus forAccount:(NSString *)account;
/// 获取UISwitch开关
+ (BOOL)_getGesturesSwitchStatusForAccount:(NSString *)account;

/// 否已经达到最大失败次数
+ (BOOL)_moreThanMaxFailCountForAccount:(NSString *)account;



@end




NS_ASSUME_NONNULL_END
