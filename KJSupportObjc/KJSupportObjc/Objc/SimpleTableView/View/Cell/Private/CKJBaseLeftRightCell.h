//
//  CKJLeftRightCell.h
//  Masonry
//
//  Created by chenkaijie on 2019/1/7.
//

#import "CKJCommonTableViewCell.h"
#import "CKJTableViewCell1.h"
#import "CKJEmptyCell.h"


@interface CKJBaseLeftRightCellConfig : CKJCommonCellConfig


/** leftLab 的宽度，如果设置为0，可以不设置，那么会自适应左边宽度 */
@property (assign, nonatomic) CGFloat leftLab_width;

/** leftLab 的宽度相对于父视图的倍数 */
@property (assign, nonatomic) CGFloat leftLab_width_MultipliedBySuperView;

/** rightLab 距离底部的距离，如果不设置此值，默认是5  */
@property (assign, nonatomic) CGFloat rightLabel_BottomMarginToSuperView;

@end


@class  CKJLeftRightTopEqualCellConfig, CKJLeftRightCenterEqualCellConfig, CKJBaseLeftRightCellModel;


typedef void(^CKJLeftRightTopEqualCellConfigBlock)(CKJLeftRightTopEqualCellConfig *_Nonnull m);
typedef void(^CKJLeftRightCenterEqualCellConfigBlock)(CKJLeftRightCenterEqualCellConfig *_Nonnull m);
typedef void(^CKJBaseLeftRightCellModelRowBlock)(__kindof CKJBaseLeftRightCellModel *_Nonnull m);








@interface CKJBaseLeftRightCellModel : CKJCommonCellModel


@property(assign, nonatomic) NSTextAlignment leftLab_textAlignment;
@property(assign, nonatomic) NSTextAlignment rightLab_textAlignment;

/**
 如果发现异常或空字符串，会自动设置为 @" " 以撑开Label的高度
 */
@property (copy, nonatomic, nullable) NSAttributedString *leftAttStr;
/**
 如果发现异常或空字符串，会自动设置为 @" " 以撑开Label的高度
 */
@property (copy, nonatomic, nullable) NSAttributedString *rightAttStr;


/** leftLab 和 父视图左边 之间的距离 (默认是0) */
@property (assign, nonatomic) CGFloat leftLab_MarginTo_SuperViewLeft;

/** leftLab 和 rightLab之间的距离 (默认是0) */
@property (assign, nonatomic) CGFloat centerMargin;

/** rightLab 和 父视图右边 之间的距离 (默认是0) */
@property (assign, nonatomic) CGFloat rightLab_MarginTo_SuperViewRight;

/**
 构造方法 设置左中右的margin
 
 @param leftMargin leftLab 和 父视图 之间的距离
 @param centerMargin leftLab 和 rightLab之间的距离
 @param rightMargin rightLab 和 父视图 之间的距离
 @return 创建出的对象
 */
+ (instancetype _Nonnull)modelWithLeftMargin:(CGFloat)leftMargin centerMargin:(CGFloat)centerMargin rightMargin:(CGFloat)rightMargin;

+ (instancetype _Nonnull)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJBaseLeftRightCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJBaseLeftRightCellModelRowBlock)didSelectRowBlock;


@end


@interface CKJBaseLeftRightCell : CKJCommonTableViewCell <CKJBaseLeftRightCellModel *>

@property (strong, nonatomic, nonnull) UILabel *leftLab;
@property (strong, nonatomic, nonnull) UILabel *rightLab;

@end





