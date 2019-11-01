//
//  CKJCell.h
//  RAC空项目
//
//  Created by chenkaijie on 2018/1/19.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//


#import "CKJCommonTableViewCell.h"
#import "NSObject+WDYHFCategory.h"
#import "CKJBaseModel.h"

#import "CKJGeneralCell.h"

@class CKJLeftView, CKJTopBottomView, CKJExtraView, CKJRightView;
@class CKJCellModel, CKJCell, MASConstraintMaker, CKJCellBtnModel;

typedef void(^CKJDidClickBtnHandle)(CKJCell *_Nonnull cell, CKJCellBtnModel *_Nonnull btn5Model);

//typedef void(^CKJDidClickbtn7Handle)(CKJCell *_Nonnull cell, CKJBtn7Model *_Nonnull btn7Model);
//typedef void(^CKJDidClickbtn9Handle)(CKJCell *_Nonnull cell, CKJBtn9Model *_Nonnull btn7Model);


typedef void(^CKJSwitch6Block)(BOOL switchOn, CKJCellModel *_Nonnull cellModel,  UISwitch *_Nonnull senderSwitch);

typedef void(^CKJCellModelRowBlock)(__kindof CKJCellModel *_Nonnull m);



@interface CKJCellBtnModel : CKJBaseBtnModel

@property (assign, nonatomic) CGFloat rightMargin;
@property (assign, nonatomic) CGFloat centerYOffset;

@property (copy, nonatomic, nullable) CKJDidClickBtnHandle didClickBtnHandle;

+ (nonnull instancetype)btnModelWithSize:(CGSize)size normalImage:(nullable UIImage *)normalImage rightMargin:(CGFloat)rightMargin detailSettingBlock:(void(^_Nullable)(CKJCellBtnModel *_Nonnull sender))detailSettingBlock didClickBtnHandle:(nullable CKJDidClickBtnHandle)didClickBtnHandle;


@end





@interface CKJView5Model : CKJBaseModel

@property (assign, nonatomic)        NSTextAlignment    topLabelTextAlignment;
@property (assign, nonatomic)        NSTextAlignment    bottomLabelTextAlignment;


@property (copy, nonatomic, nullable) NSAttributedString *topText;
@property (copy, nonatomic, nullable) NSAttributedString *bottomText;


/** 改变顶部文字 */
- (void)changeTopText:(nullable NSString *)text;
/** 改变底部文字 */
- (void)changeBottomText:(nullable NSString *)text;

/**
 该值的 bottom设置的是 topLabel 距离 Cell.centerY的距离
 */
@property (assign, nonatomic) UIEdgeInsets topLabelEdge;
/**
 该值的 top设置的是 bottomLabel 距离 Cell.centerY的距离
 */
@property (assign, nonatomic) UIEdgeInsets bottomLabelEdge;



/**
 推荐使用这个，这个最常用

 @param centerMarign      上下Label之间的间距
 @param topBottomMargin   上Label 距离父视图之间的间距
 @param leftMargin        上下Label 距离父视图Left边的间距
 @param rightMargin       上下Label 距离父视图Right边的间距
 */
+ (nonnull instancetype)view5ModelWithTopAttributedText:(nullable NSAttributedString *)topText bottomAttributedText:(nullable NSAttributedString *)bottomText centerMarign:(CGFloat)centerMarign topBottomMargin:(CGFloat)topBottomMargin leftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin;

+ (nonnull instancetype)view5ModelWithTopAttributedText:(nullable NSAttributedString *)topText bottomAttributedText:(nullable NSAttributedString *)bottomText topEdge:(UIEdgeInsets)topEdge bottomEdge:(UIEdgeInsets)bottomEdge;

@end





@interface CKJSwitch6Model : CKJBaseModel

@property (assign, nonatomic) BOOL switchOn;

@property (assign, nonatomic) CGFloat left;
@property (assign, nonatomic) CGFloat top;
@property (assign, nonatomic) CGFloat bottom;
@property (copy, nonatomic, nonnull) CKJSwitch6Block swicthBlock;

+ (nonnull instancetype)switch6ModelWithSwitchOn:(BOOL)switchOn left:(CGFloat)left top:(CGFloat)top bottom:(CGFloat)bottom callBack:(nonnull CKJSwitch6Block)callBack;

@end


@interface CKJLikePriceLabel61Model : CKJBaseModel

@property (copy, nonatomic, nullable) NSAttributedString *attributedText;


@property (assign, nonatomic) CGFloat leftMargin;
@property (assign, nonatomic) CGFloat rightMargin;

+ (nonnull instancetype)likePriceModelWithAttText:(nullable NSAttributedString *)text left:(CGFloat)left right:(CGFloat)right;

/** 改变文字 */
- (void)changeText:(nullable NSString *)text;

@end




@interface CKJCellModel : CKJGeneralCellModel

@property (strong, nonatomic, nullable) CKJSubTitle4Model *subTitle4Model;

@property (strong, nonatomic, nullable) CKJCellBtnModel *btn5Model;

@property (strong, nonatomic, nullable) CKJView5Model *view5Model;

/** 如果不设置此值，那么就是隐藏Switch */
@property (strong, nonatomic, nullable) CKJSwitch6Model *switch6Model;

@property (strong, nonatomic, nullable) CKJLikePriceLabel61Model *likePrice61Model;

@property (strong, nonatomic, nullable) CKJCellBtnModel *btn7Model;


@property (strong, nonatomic, nullable) CKJCellBtnModel *btn9Model;

+ (nonnull instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJCellModelRowBlock)didSelectRowBlock;


@end




@interface CKJCell : CKJGeneralCell

@property (nonnull, strong, nonatomic, readonly) UILabel *subTitle4;

@property (nonnull, strong, nonatomic, readonly) UIButton *btn5;

@property (nonnull, strong, nonatomic, readonly) CKJTopBottomView *view5;
@property (nonnull, strong, nonatomic, readonly) UILabel *view5_topLabel;
@property (nonnull, strong, nonatomic, readonly) UILabel *view5_bottomLabel;

@property (nonnull, strong, nonatomic, readonly) UIView *kjSwitch6;

@property (nonnull, strong, nonatomic, readonly) UIButton *btn7;

- (UIView *_Nonnull)tfWrapperView;

@end

