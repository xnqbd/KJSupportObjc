//
//  CKJPayBottomView.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/17.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKJBaseModel.h"

@interface CKJPayBottomViewConfig : CKJBaseModel

@property (assign, nonatomic) CGFloat priceLab_leftMargin;
@property (assign, nonatomic) CGFloat confimBtn_width;


/**
 是否显示顶部的线 （默认显示）
 */
@property (assign, nonatomic) BOOL showTopLine;


// 一般不设置，默认是0
@property (assign, nonatomic) CGFloat confimBtn_rightMargin;

@property (strong, nonatomic, nullable) UIColor *priceWrapperColor;

+ (nonnull instancetype)configWithDetailSetting:(void(^_Nullable)(CKJPayBottomViewConfig *_Nonnull m))detailSetting;


@end

@class CKJPayBottomView;

@protocol CKJPayBottomViewDelegate <NSObject>

@optional;
- (void)bottomViewBtnActionWithRealValue:(nullable NSString *)realValue view:(nonnull CKJPayBottomView *)view;

@end


NS_ASSUME_NONNULL_BEGIN

@interface CKJPayBottomView : UIView

@property (strong, nonatomic) UILabel *priceLab;
@property (strong, nonatomic) UIButton *confimBtn;


/**
 真正的值 (纯粹的 值)
 */
@property (copy, nonatomic, readonly) NSString *realValue;

- (void)changePriceText:(nullable NSAttributedString *)displayText realValue:(nullable NSString *)realValue;

+ (nonnull instancetype)bottomViewWithConfirmBtnSetting:(void(^_Nullable)(UIButton *confirmBtn))confirmBtnBlock config:(nonnull CKJPayBottomViewConfig *)config delegate:(__weak id<CKJPayBottomViewDelegate>)delegate;


@end

NS_ASSUME_NONNULL_END
