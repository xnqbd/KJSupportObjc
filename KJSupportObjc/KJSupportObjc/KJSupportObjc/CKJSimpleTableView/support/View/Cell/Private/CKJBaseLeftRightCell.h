//
//  CKJLeftRightCell.h
//  Masonry
//
//  Created by chenkaijie on 2019/1/7.
//

#import "CKJCommonTableViewCell.h"
#import "CKJTableViewCell1.h"
#import "CKJEmptyCell.h"

NS_ASSUME_NONNULL_BEGIN


/*
 
 
 
 
 */




UIKIT_EXTERN NSString *_Nonnull const kOLR_Left_Title;
UIKIT_EXTERN NSString *_Nonnull const kOLR_Right_Title;



@interface CKJBaseLeftLabelSetting : CKJBaseModel


/** leftLab 的宽度，自适应左边宽度（nil或者0）可以不设置，那么会自适应左边宽度 */
@property (copy, nonatomic) NSNumber *leftLab_width;

/** leftLab 的宽度相对于父视图的倍数 */
@property (copy, nonatomic) NSNumber *leftLab_width_MultipliedBySuperView;


/** leftLab 和 父视图左边 之间的距离 (默认是kOCell_Left_Margin) */
@property (copy, nonatomic) NSNumber *leftLab_MarginTo_SuperViewLeft;

/** leftLab 和 rightLab之间的距离 (默认是0) */
@property (copy, nonatomic) NSNumber * centerMargin;

@end


@interface CKJBaseRightLabelSetting : CKJBaseModel

/** rightLab 和 父视图右边 之间的距离 (默认是kOCell_Left_Margin) */
@property (copy, nonatomic) NSNumber *rightLab_MarginTo_SuperViewRight;


@end


@class  CKJLeftRightTopEqualCellConfig, CKJLeftRightCenterEqualCellConfig, CKJBaseLeftRightCellModel;


typedef void(^CKJLeftRightTopEqualCellConfigBlock)(CKJLeftRightTopEqualCellConfig *m);
typedef void(^CKJLeftRightCenterEqualCellConfigBlock)(CKJLeftRightCenterEqualCellConfig *m);
typedef void(^CKJBaseLeftRightCellModelRowBlock)(__kindof CKJBaseLeftRightCellModel *m);





@interface CKJBaseLeftRightCellModel : CKJCommonCellModel

@property (weak, nonatomic) UILabel *readOnly_leftLabel;
@property (weak, nonatomic) UILabel *readOnly_rightLabel;

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

@property (strong, nonatomic) __kindof CKJBaseLeftLabelSetting *leftLabelSetting;
@property (strong, nonatomic) __kindof CKJBaseRightLabelSetting *rightLabelSetting;


+ (NSMutableArray <__kindof CKJBaseLeftRightCellModel *>*)lrWithdics:(NSArray <NSDictionary <NSString *, id> *>*)dics detail:(void(^)(__kindof CKJBaseLeftRightCellModel *m))detail;


/// 更新左右间距
- (void)updateLeftRightMargin:(CGFloat)leftRightMargin;

@end


@interface CKJBaseLeftRightCell : CKJCommonTableViewCell // <CKJBaseLeftRightCellModel *>

@property (strong, nonatomic) UILabel *leftLab;
@property (strong, nonatomic) UILabel *rightLab;

@end


NS_ASSUME_NONNULL_END
