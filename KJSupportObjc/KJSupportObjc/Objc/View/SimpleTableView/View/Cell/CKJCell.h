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
#import "CKJExtraView.h"

@interface CKJImage2Model : CKJBaseModel

@property (copy, nonatomic) NSString *imageString2;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGFloat leftMargin;
+ (nonnull instancetype)image2ModelWithImageString:(NSString *)imageString size:(CGSize)size left:(CGFloat)leftMargin;

@end


@interface CKJTitle3Model : CKJBaseModel

@property (copy, nonatomic, nullable) NSAttributedString *attributedText;
@property (assign, nonatomic) CGFloat leftMargin;

/**
 宽度，默认为0，自适应宽度
 */
@property (assign, nonatomic) CGFloat width;

/**
 默认自适应宽度
 */
+ (nonnull instancetype)title3ModelWithAttributedText:(nullable NSAttributedString *)text left:(CGFloat)left;

+ (nonnull instancetype)title3ModelWithAttributedText:(nullable NSAttributedString *)text left:(CGFloat)left width:(CGFloat)width;

/** 改变文字 */
- (void)changeText:(nullable NSString *)text;


@end

@interface CKJSubTitle4Model : CKJBaseModel

@property (copy, nonatomic, nullable) NSAttributedString *attributedText;
@property (assign, nonatomic) CGFloat topMargin;
@property (assign, nonatomic) CGFloat leftMargin;
@property (assign, nonatomic) CGFloat bottomMargin;
@property (assign, nonatomic) CGFloat rightMargin;
+ (nonnull instancetype)subTitle4ModelWithAttributedText:(nullable NSAttributedString *)text top:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;


/** 改变文字 */
- (void)changeText:(nullable NSString *)text;

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

@class CKJCellModel, CKJCell, MASConstraintMaker, CKJBtn8Model;


typedef void(^CKJSwitch6Block)(BOOL switchOn, CKJCellModel *_Nonnull cellModel,  UISwitch *_Nonnull senderSwitch);

@interface CKJSwitch6Model : CKJBaseModel

@property (assign, nonatomic) BOOL switchOn;

@property (assign, nonatomic) CGFloat left;
@property (assign, nonatomic) CGFloat top;
@property (assign, nonatomic) CGFloat right;
@property (assign, nonatomic) CGFloat bottom;
@property (copy, nonatomic, nonnull) CKJSwitch6Block swicthBlock;

+ (nonnull instancetype)switch6ModelWithSwitchOn:(BOOL)switchOn left:(CGFloat)left top:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom callBack:(nonnull CKJSwitch6Block)callBack;

@end



@interface CKJLikePriceLabel7Model : CKJBaseModel

@property (copy, nonatomic, nullable) NSAttributedString *attributedText;
@property (assign, nonatomic) CGFloat topMargin;
@property (assign, nonatomic) CGFloat bottomMargin;
@property (assign, nonatomic) CGFloat rightMargin;
+ (nonnull instancetype)likePriceLabel7ModelWithAttributedText:(nullable NSAttributedString *)text top:(CGFloat)top bottom:(CGFloat)bottom right:(CGFloat)right;

/** 改变文字 */
- (void)changeText:(nullable NSString *)text;

@end


typedef void(^CKJDidClickBtn8Handle)(CKJCell *_Nonnull cell, CKJBtn8Model *_Nonnull btn8Model);



@interface CKJBtn8Model : CKJBaseModel

/**
 暂时按钮的所有状态size都一样
 */
+ (nonnull instancetype)btn8ModelWithSize:(CGSize)size normalImage:(nullable UIImage *)normalImage rightMargin:(CGFloat)rightMargin detailSettingBlock:(void(^_Nullable)(CKJBtn8Model *_Nonnull sender))detailSettingBlock didClickBtn8Handle:(nullable CKJDidClickBtn8Handle)didClickBtn8Handle;

@property (copy, nonatomic, nullable) NSAttributedString *normalAttributedTitle;
@property (copy, nonatomic, nullable) NSAttributedString *selectedAttributedTitle;

/** 改变Normal状态下的文字 */
- (void)changeNormalText:(nullable NSString *)text;

/** 改变Normal状态下的文字 */
- (void)changeSelectedText:(nullable NSString *)text;



@property (strong, nonatomic, nullable) UIImage *normalBackgroundImage;
@property (strong, nonatomic, nullable) UIImage *selectedBackgroundImage;

@property (strong, nonatomic, nullable) UIImage *normalImage;
@property (strong, nonatomic, nullable) UIImage *selectedImage;



/** 是否选中 */
@property (assign, nonatomic) BOOL selected;
/** 是否开启用户交互，默认开启 */
@property (assign, nonatomic) BOOL userInteractionEnabled;

@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGFloat cornerRadius;

@property (assign, nonatomic) CGFloat rightMargin;
@property (assign, nonatomic) CGFloat centerYOffset;

@property (copy, nonatomic, nullable) CKJDidClickBtn8Handle didClickBtn8Handle;

@end

@interface CKJArrow9Model : CKJBaseModel

/**
 默认距右边15
 */
@property (assign, nonatomic) CGFloat right;
@property (strong, nonatomic, nullable) UIImage *image;

/**
 right默认为15
 */
+ (nonnull instancetype)arrow9ModelWithImage:(nullable UIImage *)image right:(nullable NSNumber *)right;

@end


typedef void(^CKJCellModelRowBlock)(__kindof CKJCellModel *_Nonnull m);


@interface CKJCellModel : CKJCommonCellModel

@property (strong, nonatomic, nullable) CKJImage2Model *image2Model;
@property (strong, nonatomic, nullable) CKJTitle3Model *title3Model;
@property (strong, nonatomic, nullable) CKJSubTitle4Model *subTitle4Model;

@property (strong, nonatomic, nullable) CKJView5Model *view5Model;

/** 如果不设置此值，那么就是隐藏Switch */
@property (strong, nonatomic, nullable) CKJSwitch6Model *switch6Model;

@property (strong, nonatomic, nullable) CKJLikePriceLabel7Model *likePrice7Model;

@property (strong, nonatomic, nullable) CKJBtn8Model *btn8Model;

@property (strong, nonatomic, nullable) CKJArrow9Model *arrow9Model;


+ (nonnull instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJCellModelRowBlock)didSelectRowBlock;


@end

@class CKJLeftView, CKJTopBottomView, CKJExtraView, CKJRightView;


@interface CKJCell : CKJCommonTableViewCell <CKJCellModel *>

@property (nonnull, strong, nonatomic, readonly) CKJLeftView *leftWrapView;
@property (nonnull, strong, nonatomic, readonly) UIButton *imageBtn2;
@property (nonnull, strong, nonatomic, readonly) UILabel *title3;
@property (nonnull, strong, nonatomic, readonly) UILabel *subTitle4;

@property (nonnull, strong, nonatomic, readonly) CKJTopBottomView *view5;
@property (nonnull, strong, nonatomic, readonly) UILabel *view5_topLabel;
@property (nonnull, strong, nonatomic, readonly) UILabel *view5_bottomLabel;

/**
 中间的附加View
 */
@property (nonnull, strong, nonatomic, readonly) CKJExtraView *centerExtraView;

@property (nonnull, strong, nonatomic, readonly) CKJRightView *rightWrapView;
@property (nonnull, strong, nonatomic, readonly) UIView *kjSwitch6;
@property (nonnull, strong, nonatomic, readonly) UILabel *alikePriceLabel7;
@property (nonnull, strong, nonatomic, readonly) UIButton *btn8;

@property (nonnull, strong, nonatomic, readonly) UIImageView *arrowImageView9;


- (__kindof UIButton *)__privateMethodOfCreateBtn8;

@end

