//
//  CKJGesturesVC.h
//  MobileManage
//
//  Created by admin2 on 2020/7/6.
//  Copyright © 2020 admin2. All rights reserved.
//

#import "CKJBaseViewController.h"
#import "CKJGesturesUnlockView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CKJGesturesVC : CKJBaseViewController

@property (strong, nonatomic) CKJGesturesUnlockView *unlockView;

- (instancetype)initWithUnlockView:(CKJGesturesUnlockView *)unlockView;


@end

NS_ASSUME_NONNULL_END
