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


@interface CKJImage2Model : CKJBaseModel

@property (copy, nonatomic) NSString *imageString2;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGFloat leftMargin;
+ (instancetype)image2ModelWithImageString:(NSString *)imageString size:(CGSize)size left:(CGFloat)leftMargin;

@end


@interface CKJTitle3Model : CKJBaseModel


@property (copy, nonatomic, nullable) NSAttributedString *attributedText;
@property (assign, nonatomic) CGFloat leftMargin;

+ (instancetype)title3ModelWithAttributedText:(nullable NSAttributedString *)text left:(CGFloat)left;

/** 改变文字 */
- (void)changeText:(nullable NSString *)text;


@end

@interface CKJSubTitle4Model : CKJBaseModel

@property (copy, nonatomic, nullable) NSAttributedString *attributedText;
@property (assign, nonatomic) CGFloat topMargin;
@property (assign, nonatomic) CGFloat leftMargin;
@property (assign, nonatomic) CGFloat bottomMargin;
@property (assign, nonatomic) CGFloat rightMargin;
+ (instancetype)subTitle4ModelWithAttributedText:(nullable NSAttributedString *)text top:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;

@end


@interface CKJView5Model : CKJBaseModel

@property (assign, nonatomic)        NSTextAlignment    topLabelTextAlignment;
@property (assign, nonatomic)        NSTextAlignment    bottomLabelTextAlignment;


@property (copy, nonatomic, nullable) NSAttributedString *topText;
@property (copy, nonatomic, nullable) NSAttributedString *bottomText;

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
+ (instancetype)view5ModelWithTopAttributedText:(nullable NSAttributedString *)topText bottomAttributedText:(nullable NSAttributedString *)bottomText centerMarign:(CGFloat)centerMarign topBottomMargin:(CGFloat)topBottomMargin leftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin;

+ (instancetype)view5ModelWithTopAttributedText:(nullable NSAttributedString *)topText bottomAttributedText:(nullable NSAttributedString *)bottomText topEdge:(UIEdgeInsets)topEdge bottomEdge:(UIEdgeInsets)bottomEdge;

@end

@class CKJCellModel, CKJCell, MASConstraintMaker, CKJBtn8Model;


typedef void(^CKJSwitch6Block)(BOOL switchOn, CKJCellModel *cellModel, UISwitch *senderSwitch);

@interface CKJSwitch6Model : CKJBaseModel

@property (assign, nonatomic) BOOL switchOn;

@property (assign, nonatomic) CGFloat left;
@property (assign, nonatomic) CGFloat top;
@property (assign, nonatomic) CGFloat right;
@property (assign, nonatomic) CGFloat bottom;
@property (copy, nonatomic) CKJSwitch6Block swicthBlock;

+ (instancetype)switch6ModelWithSwitchOn:(BOOL)switchOn left:(CGFloat)left top:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom callBack:(CKJSwitch6Block)callBack;

@end



@interface CKJLikePriceLabel7Model : CKJBaseModel

@property (copy, nonatomic) NSAttributedString *attributedText;
@property (assign, nonatomic) CGFloat topMargin;
@property (assign, nonatomic) CGFloat bottomMargin;
@property (assign, nonatomic) CGFloat rightMargin;
+ (instancetype)likePriceLabel7ModelWithAttributedText:(NSAttributedString *)text top:(CGFloat)top bottom:(CGFloat)bottom right:(CGFloat)right;

@end


typedef void(^CKJDidClickBtn8Handle)(CKJCell *cell, CKJBtn8Model *btn8Model);



@interface CKJBtn8Model : CKJBaseModel

+ (instancetype)btn8ModelWithNormalImage:(NSString *)normalImage size:(CGSize)size rightMargin:(CGFloat)rightMargin detailSettingBlock:(void(^)(CKJBtn8Model *sender))detailSettingBlock didClickBtn8Handle:(CKJDidClickBtn8Handle)didClickBtn8Handle;


@property (copy, nonatomic) NSAttributedString *normalAttributedTitle;
@property (copy, nonatomic) NSAttributedString *selectedAttributedTitle;

@property (copy, nonatomic) NSString *normalBackgroundImage;
@property (copy, nonatomic) NSString *selectedBackgroundImage;

@property (copy, nonatomic) NSString *normalImage;
@property (copy, nonatomic) NSString *selectedImage;



/** 是否选中 */
@property (assign, nonatomic) BOOL selected;
/** 是否开启用户交互，默认开启 */
@property (assign, nonatomic) BOOL userInteractionEnabled;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGFloat cornerRadius;

@property (assign, nonatomic) CGFloat rightMargin;
@property (assign, nonatomic) CGFloat centerYOffset;

@property (copy, nonatomic) CKJDidClickBtn8Handle didClickBtn8Handle;

@end

@interface CKJArrow9Model : CKJBaseModel

/**
 默认距右边15
 */
@property (assign, nonatomic) CGFloat right;
@property (strong, nonatomic) UIImage *image;

/**
 right默认为15
 */
+ (instancetype)arrow9ModelWithImage:(UIImage *)image right:(nullable NSNumber *)right;

@end


typedef void(^CKJCellModelRowBlock)(__kindof CKJCellModel *_Nonnull m);


@interface CKJCellModel : CKJCommonCellModel

@property (strong, nonatomic) CKJImage2Model *image2Model;
@property (strong, nonatomic) CKJTitle3Model *title3Model;
@property (strong, nonatomic) CKJSubTitle4Model *subTitle4Model;

@property (strong, nonatomic) CKJView5Model *view5Model;

/** 如果不设置此值，那么就是隐藏Switch */
@property (strong, nonatomic) CKJSwitch6Model *switch6Model;

@property (strong, nonatomic) CKJLikePriceLabel7Model *likePrice7Model;

@property (strong, nonatomic) CKJBtn8Model *btn8Model;

@property (strong, nonatomic) CKJArrow9Model *arrow9Model;

/** 是否显示分割线 */
@property (assign, nonatomic) BOOL showLine;


+ (instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJCellModelRowBlock)didSelectRowBlock;


@end

@class CKJLeftView, CKJTopBottomView, CKJRightView;


@interface CKJCell : CKJCommonTableViewCell <CKJCellModel *>

@property (strong, nonatomic, readonly) CKJLeftView *leftWrapView;
@property (strong, nonatomic, readonly) UIButton *imageBtn2;
@property (strong, nonatomic, readonly) UILabel *title3;
@property (strong, nonatomic, readonly) UILabel *subTitle4;

@property (strong, nonatomic, readonly) CKJTopBottomView *view5;
@property (strong, nonatomic, readonly) UILabel *view5_topLabel;
@property (strong, nonatomic, readonly) UILabel *view5_bottomLabel;

@property (strong, nonatomic, readonly) CKJRightView *rightWrapView;
@property (strong, nonatomic, readonly) UIView *kjSwitch6;
@property (strong, nonatomic, readonly) UILabel *alikePriceLabel7;
@property (strong, nonatomic, readonly) UIButton *btn8;

@property (strong, nonatomic, readonly) UIImageView *arrowImageView9;


@end

