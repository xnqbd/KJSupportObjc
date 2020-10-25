//
//  CKJGesturesVC.m
//  MobileManage
//
//  Created by admin2 on 2020/7/6.
//  Copyright © 2020 admin2. All rights reserved.
//

#import "CKJGesturesVC.h"

@interface CKJGesturesVC ()

@end

@implementation CKJGesturesVC

- (instancetype)initWithUnlockView:(CKJGesturesUnlockView *)unlockView {
    if (self = [super init]) {
        self.unlockView = unlockView;
    }
    return self;
}

- (void)setUnlockView:(CKJGesturesUnlockView *)unlockView {
    _unlockView = unlockView;
    [_unlockView kjwd_masWithSuperView:self.view makeConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
        make.edges.equalTo(superview);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}


@end
