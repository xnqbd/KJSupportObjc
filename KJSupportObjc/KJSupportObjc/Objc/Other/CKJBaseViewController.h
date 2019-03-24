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


/**
 增加补充数据
 */
- (void)installComplementData;

@end


