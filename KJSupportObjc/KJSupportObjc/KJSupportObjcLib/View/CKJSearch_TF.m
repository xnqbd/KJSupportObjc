//
//  CKJSearch_TF.m
//  MobileManage
//
//  Created by admin2 on 2020/4/14.
//  Copyright © 2020 admin2. All rights reserved.
//

#import "CKJSearch_TF.h"


@interface CKJSearch_TFConfig ()

@property (weak, nonatomic) UIButton *btn;
@property (weak, nonatomic) CKJSearch_TF *tf;

@end

@implementation CKJSearch_TFConfig

//- (instancetype)init {
//    if (self = [super init]) {
////        self.left_or_right_margin = 7;
////        self.btnSize = CGSizeMake(18, 18);
//    }
//    return self;
//}

@end

@interface CKJSearch_TF ()

@property (strong, nonatomic) CKJSearch_TFConfig *leftConfig;
@property (strong, nonatomic) CKJSearch_TFConfig *rightConfig;

@end


@implementation CKJSearch_TF


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _kjinit];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self _kjinit];
    }
    return self;
}
- (void)_kjinit {
    self.backgroundColor = [UIColor whiteColor];
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor kjwd_rbg:230 alpha:1].CGColor;
    self.layer.borderWidth = 1;
    
    CKJSearch_TFConfig *leftConfig = [[CKJSearch_TFConfig alloc] init];
    leftConfig.left_Margin = 8;
    leftConfig.right_Margin = 8;
    leftConfig.btnSize = CGSizeMake(18, 18);
    leftConfig.tf = self;
    self.leftConfig = leftConfig;
    
    CKJSearch_TFConfig *rightConfig = [[CKJSearch_TFConfig alloc] init];
    rightConfig.right_Margin = 8;
    rightConfig.tf = self;
    self.rightConfig = rightConfig;
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.userInteractionEnabled = NO;
    NSBundle *resourcesBundle = [CKJWorker kjbundle];
    UIImage *arrow = [UIImage imageNamed:@"kj_ic_search_gray" inBundle:resourcesBundle compatibleWithTraitCollection:nil];
    //    arrow = [arrow kjwd_scaleToSize:CGSizeMake(16, 16)];
    [leftBtn setImage:arrow forState:UIControlStateNormal];
    [self addSubview:leftBtn];
    
    
    UITextField *tf = [[UITextField alloc] init];
    tf.textColor = [UIColor darkGrayColor];
    
    tf.font = [UIFont systemFontOfSize:15];
    tf.borderStyle = UITextBorderStyleNone;
    [self addSubview:tf];
    
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:rightBtn];
    
    
    
    self.leftBtn = leftBtn;
    self.tf = tf;
    self.rightBtn = rightBtn;
    
    leftConfig.btn = leftBtn;
    rightConfig.btn = rightBtn;
    
    [self updateUI];
    
    BOOL debug = YES;
//        debug = NO;
    if (debug) {
//        self.backgroundColor = [UIColor kjwd_arc4Color];
//        leftBtn.backgroundColor = [UIColor kjwd_arc4Color];
//        rightBtn.backgroundColor = [UIColor kjwd_arc4Color];
//        tf.backgroundColor = [UIColor kjwd_arc4Color];
//        WDCKJBGColor_Arc4Color(self);
//        WDCKJBGColor_Arc4Color(leftBtn);
//        WDCKJBGColor_Arc4Color(rightBtn);
//        WDCKJBGColor_Arc4Color(tf);
    }
}

- (void)updateConfig:(void (^)(CKJSearch_TFConfig * _Nonnull, CKJSearch_TFConfig * _Nonnull))configBlock {
    if (configBlock) {
        configBlock(_leftConfig, _rightConfig);
        [self updateUI];
    }
}

- (void)updateUI {
    [_leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(_leftConfig.left_Margin);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(_leftConfig.btnSize);
    }];
    [_tf mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.greaterThanOrEqualTo(@30); // 最低高度30
        make.left.equalTo(_leftBtn.mas_right).offset(_leftConfig.right_Margin);
        make.top.bottom.equalTo(self);
        make.centerY.equalTo(self);
    }];
    [_rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tf.mas_right).offset(_rightConfig.left_Margin);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(_rightConfig.btnSize);
        make.right.equalTo(self).offset(-(_rightConfig.right_Margin));
    }];
}


@end
