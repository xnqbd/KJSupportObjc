//
//  CKJBaseViewController.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/2/28.
//  Copyright © 2019年 Lyc. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CKJBaseViewController : UIViewController

@property (weak, nonatomic) UIAlertController *alert;


- (void)popAction:(id)sender;

- (void)firstNetwork;

- (void)reloadUI;

- (void)clearCache;

- (void)kj_addNotification;
- (void)kj_removeNotification;

- (void)_set_subViews;

/**
 增加补充数据
 */
- (void)installComplementData;


/// 实心的
- (UIView *)footerViewWithBtnTitle:(NSString *)title clickHandle:(void(^_Nullable)(UIButton * _Nonnull sender))clickHandle;


/// 镂空的
- (UIView *)strokeFooterViewWithBtnTitle:(NSString *)title clickHandle:(void(^_Nullable)(UIButton * _Nonnull sender))clickHandle;





@end


