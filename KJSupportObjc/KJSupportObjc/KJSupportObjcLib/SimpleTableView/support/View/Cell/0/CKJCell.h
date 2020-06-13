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

NS_ASSUME_NONNULL_BEGIN


@class CKJLeftView, CKJTopBottomView, CKJExtraView, CKJRightView;
@class CKJCellModel, CKJCell, MASConstraintMaker, CKJCellBtnModel;

typedef void(^CKJDidClickBtnHandle)(__kindof CKJCell *cell, CKJCellBtnModel *btnModel);

typedef void(^CKJSwitch6Block)(BOOL switchOn, CKJCellModel *cellModel,  UISwitch *senderSwitch);

typedef void(^CKJCellModelRowBlock)(__kindof CKJCellModel *m);



@interface CKJCellBtnModel : CKJBaseBtnModel

@property (assign, nonatomic) CGFloat rightMargin;
@property (assign, nonatomic) CGFloat centerYOffset;

@property (copy, nonatomic, nullable) CKJDidClickBtnHandle didClickBtnHandle;

+ (instancetype)btnModelWithSize:(CGSize)size normalImage:(nullable UIImage *)normalImage rightMargin:(CGFloat)rightMargin detailSettingBlock:(void(^_Nullable)(CKJCellBtnModel *sender))detailSettingBlock didClickBtnHandle:(nullable CKJDidClickBtnHandle)didClickBtnHandle;


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
+ (instancetype)view5ModelWithTopAttributedText:(nullable NSAttributedString *)topText bottomAttributedText:(nullable NSAttributedString *)bottomText centerMarign:(CGFloat)centerMarign topBottomMargin:(CGFloat)topBottomMargin leftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin;

+ (instancetype)view5ModelWithTopAttributedText:(nullable NSAttributedString *)topText bottomAttributedText:(nullable NSAttributedString *)bottomText topEdge:(UIEdgeInsets)topEdge bottomEdge:(UIEdgeInsets)bottomEdge;

@end





@interface CKJSwitch6Model : CKJBaseModel

@property (assign, nonatomic) BOOL switchOn;

@property (assign, nonatomic) CGFloat left;
@property (assign, nonatomic) CGFloat top;
@property (assign, nonatomic) CGFloat bottom;
@property (copy, nonatomic, nonnull) CKJSwitch6Block swicthBlock;

+ (instancetype)switch6ModelWithSwitchOn:(BOOL)switchOn left:(CGFloat)left top:(CGFloat)top bottom:(CGFloat)bottom callBack:(CKJSwitch6Block)callBack;

@end


@interface CKJLikePriceLabel61Model : CKJBaseModel

@property (copy, nonatomic, nullable) NSAttributedString *attributedText;


@property (assign, nonatomic) CGFloat leftMargin;
@property (assign, nonatomic) CGFloat rightMargin;

+ (instancetype)likePriceModelWithAttText:(nullable NSAttributedString *)text left:(CGFloat)left right:(CGFloat)right;

/** 改变文字 */
- (void)changeText:(nullable NSString *)text;

/// 这个是为了增加Switch右边的距离
+ (instancetype)likePriceModelWithLeftMargin:(CGFloat)leftMargin;

@end


/*

 CKJCellModel *model1 = [CKJCellModel ckjCellWithCellHeight:@40 cellModel_id:nil detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
     m.image2Model = [CKJImage2Model image2ModelWithImageString:@"touxiang.jpg" size:CGSizeMake(25, 25) left:0];
     m.title3Model = [CKJTitle3Model title3ModelWithText:WDAttTitle(@"title3") left:0];
     m.subTitle4Model = [CKJSubTitle4Model subTitle4ModelWithAttributedText:WDCKJAttributed2(@"sub4", [UIColor kjwd_subTitle], @14) top:0 left:0 bottom:0 right:0];
     m.btn5Model = [CKJCellBtnModel btnModelWithSize:CGSizeMake(40, 40) normalImage:nil rightMargin:0 detailSettingBlock:^(CKJCellBtnModel * _Nonnull sender) {
         [sender changeNormalText:@"btn5"];
     } didClickBtnHandle:^(CKJCell * _Nonnull cell, CKJCellBtnModel * _Nonnull btn5Model) {
         NSLog(@"当前分区%ld  %ld行,  点击了btn5", (long)cell.section, (long)cell.row);
     }];
     m.view5Model = [CKJView5Model view5ModelWithTopAttributedText:WDCKJAttributed2(@"topText5", [UIColor kjwd_title], @14) bottomAttributedText:WDCKJAttributed2(@"bottomTex5", [UIColor kjwd_subTitle], @14) centerMarign:5 topBottomMargin:3 leftMargin:0 rightMargin:0];
     m.switch6Model = [CKJSwitch6Model switch6ModelWithSwitchOn:YES left:0 top:0 bottom:0 callBack:^(BOOL switchOn, CKJCellModel * _Nonnull cellModel, UISwitch * _Nonnull senderSwitch) {
         NSLog(@"当前分区%ld  %ld行,  点击了UISwitch，当前状态是 %@ ", (long)cellModel.cell.section, (long)cellModel.cell.row, switchOn ? @"开" : @"关");
     }];
     m.likePrice61Model = [CKJLikePriceLabel61Model likePriceModelWithAttText:WDCKJAttributed2(@"price61", [UIColor kjwd_subTitle], @14) left:0 right:0];

     m.btn7Model = [CKJCellBtnModel btnModelWithSize:CGSizeMake(30, 30) normalImage:[UIImage kjwd_imageNamed:@"touxiang.jpg"] rightMargin:0 detailSettingBlock:nil didClickBtnHandle:^(CKJCell * _Nonnull cell, CKJCellBtnModel * _Nonnull btn7Model) {
         NSLog(@"当前分区%ld  %ld行,  点击了btn7", (long)cell.section, (long)cell.row);
     }];
     m.likePrice8Model = [CKJLikePriceLabel8Model likePriceLabel8ModelWithAttText:WDCKJAttributed2(@"price8", [UIColor kjwd_subTitle], @14) left:0 right:0];
     m.arrow9Model = [CKJArrow9Model arrow9SystemModel];
 } didSelectRowBlock:nil];
 
 */


@interface CKJCellModel : CKJGeneralCellModel

@property (strong, nonatomic, nullable) CKJSubTitle4Model *subTitle4Model;

@property (strong, nonatomic, nullable) CKJCellBtnModel *btn5Model;

@property (strong, nonatomic, nullable) CKJView5Model *view5Model;

/** 如果不设置此值，那么就是隐藏Switch */
@property (strong, nonatomic, nullable) CKJSwitch6Model *switch6Model;

@property (strong, nonatomic, nullable) CKJLikePriceLabel61Model *likePrice61Model;

@property (strong, nonatomic, nullable) CKJCellBtnModel *btn7Model;


@property (strong, nonatomic, nullable) CKJCellBtnModel *btn9Model;

+ (instancetype)ckjCellWithCellHeight:(nullable NSNumber *)cellHeight cellModel_id:(nullable NSString *)cellModel_id detailSettingBlock:(nullable CKJCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJCellModelRowBlock)didSelectRowBlock;

@end




@interface CKJCell : CKJGeneralCell

@property (strong, nonatomic, readonly) UILabel *subTitle4;

@property (strong, nonatomic, readonly) UIButton *btn5;

@property (strong, nonatomic, readonly) CKJTopBottomView *view5;
@property (strong, nonatomic, readonly) UILabel *view5_topLabel;
@property (strong, nonatomic, readonly) UILabel *view5_bottomLabel;

@property (strong, nonatomic, readonly) UIView *kjSwitch6;

@property (strong, nonatomic, readonly) UIButton *btn7;

- (UIView *)tfWrapperView;

@end



NS_ASSUME_NONNULL_END
