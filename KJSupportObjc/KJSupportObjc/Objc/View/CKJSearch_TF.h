//
//  CKJSearch_TF.h
//  MobileManage
//
//  Created by admin2 on 2020/4/14.
//  Copyright © 2020 admin2. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CKJSearch_TF;

@interface CKJSearch_TFConfig : NSObject

@property (assign, nonatomic) CGSize btnSize;
@property (assign, nonatomic) CGFloat left_Margin;
@property (assign, nonatomic) CGFloat right_Margin;

@property (readonly, weak, nonatomic) UIButton *btn;
@property (readonly, weak, nonatomic) CKJSearch_TF *tf;

@end

/*
    CKJSearch_TF *tf = [[CKJSearch_TF alloc] init];
    [tf kjwd_masWithSuperView:self.view makeConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
        make.center.equalTo(superview);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
    [tf updateConfig:^(CKJSearch_TFConfig * _Nonnull left, CKJSearch_TFConfig * _Nonnull right) {
    }];
 */

@interface CKJSearch_TF : UIView

@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) UITextField *tf;
@property (strong, nonatomic) UIButton *rightBtn;

@property (strong, nonatomic, readonly) CKJSearch_TFConfig *leftConfig;
@property (strong, nonatomic, readonly) CKJSearch_TFConfig *rightConfig;


// right默认大小为CGSizeZero
- (void)updateConfig:(void(^)(CKJSearch_TFConfig *left, CKJSearch_TFConfig *right))configBlock;

@end

NS_ASSUME_NONNULL_END
