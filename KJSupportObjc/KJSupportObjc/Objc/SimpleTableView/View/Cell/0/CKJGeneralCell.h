//
//  CKJGeneralCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/7/6.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJCommonTableViewCell.h"

#import "KJSupportHeader.h"

NS_ASSUME_NONNULL_BEGIN

@class CKJGeneralCellModel, CKJGeneralCell;
typedef void(^CKJGeneralCellModelRowBlock)(__kindof CKJGeneralCellModel * __weak _Nonnull m);



@interface CKJImage2Model : CKJBaseModel

@property (strong, nonatomic, nullable) UIImage *normalImage;
@property (assign, nonatomic) CGFloat cornerRadius;
@property (strong, nonatomic) NSValue *sizeValue;
@property (assign, nonatomic) CGFloat leftMargin;
+ (nonnull instancetype)image2ModelWithNormalImage:(nullable UIImage *)normalImage size:(nullable NSValue *)size left:(CGFloat)leftMargin;
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



@interface CKJLikePriceLabel8Model : CKJBaseModel

@property (copy, nonatomic, nullable) NSAttributedString *attributedText;


@property (assign, nonatomic) CGFloat leftMargin;
@property (assign, nonatomic) CGFloat rightMargin;

+ (nonnull instancetype)likePriceLabel8ModelWithAttText:(nullable NSAttributedString *)text left:(CGFloat)left right:(CGFloat)right;

/** 改变文字 */
- (void)changeText:(nullable NSString *)text;

@end



@interface CKJArrow9Model : CKJBaseModel

/**
 默认距右边5
 */
@property (assign, nonatomic) CGFloat right;
/**
 默认是 箭头样式，自带大小
 */
@property (strong, nonatomic, nullable) UIImage *image;

/**
 right默认为5，默认是箭头图片
 */
+ (nonnull instancetype)arrow9ModelWithImage:(nullable UIImage *)image right:(nullable NSNumber *)right;

+ (nonnull instancetype)arrow9SystemModel;

@end



/*
CKJGeneralCellModel *model3 = [CKJGeneralCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(__kindof CKJGeneralCellModel *__weak  _Nonnull m) {
    m.image2Model = [CKJImage2Model image2ModelWithImageString:@"new_personal_添加" size:CGSizeMake(23, 23) left:15];
    m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDAtt15_5(@"添加就诊人") left:5];
    m.arrow9Model = [CKJArrow9Model arrow9SystemModel];
} didSelectRowBlock:nil];

*/


@interface CKJGeneralCellModel : CKJCommonCellModel

@property (strong, nonatomic, nullable) CKJImage2Model *image2Model;
@property (strong, nonatomic, nullable) CKJTitle3Model *title3Model;

- (NSString *_Nullable)title3Text;

@property (strong, nonatomic, nullable) CKJLikePriceLabel8Model *likePrice8Model;
@property (strong, nonatomic, nullable) CKJArrow9Model *arrow9Model;

+ (nonnull instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJGeneralCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJGeneralCellModelRowBlock)didSelectRowBlock;


@end


@interface CKJGeneralCell : CKJCommonTableViewCell<CKJGeneralCellModel *>

@property (nonnull, strong, nonatomic, readonly) CKJLeftView *leftWrapView;
@property (nonnull, strong, nonatomic, readonly) UIButton *imageBtn2;
@property (nonnull, strong, nonatomic, readonly) UILabel *title3;

@property (nonnull, strong, nonatomic, readonly) CKJRightView *rightWrapView;
@property (nonnull, strong, nonatomic, readonly) UIImageView *arrowImageView9;


@end

NS_ASSUME_NONNULL_END
