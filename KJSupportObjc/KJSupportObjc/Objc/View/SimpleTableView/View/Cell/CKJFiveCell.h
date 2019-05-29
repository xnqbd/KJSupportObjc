//
//  CKJPayStyleCell.h
//  WDYHFSDK
//
//  Created by chenkaijie on 2018/12/7.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CKJCommonTableViewCell.h"
#import "CKJExtraView.h"


//CKJFiveCellConfig *config = [CKJFiveCellConfig configWithDetailSettingBlock:^(CKJFiveCellConfig * _Nonnull m) {
//    m.leftImageSize = CGSizeMake(40, 40);
//    m.leftImageView_MarginToSuperViewLeft = 15;
//    m.image_margin_title = 10;
//}];

@class CKJFiveCellConfig;


typedef void(^CKJFiveCellConfigBlock)(__kindof CKJFiveCellConfig *_Nonnull m);

// 一般直接使用此类，不需要继承此类
@interface CKJFiveCellConfig : CKJCommonCellConfig


#pragma mark - 上下间距

/** SuperView 和 title 之间的距离 (默认10) */
@property (assign, nonatomic) CGFloat superview_margin_title;

/** title和subTitle之间的距离     (默认0) */
@property (assign, nonatomic) CGFloat title_margin_subTitle;

/** subTitle和thirdLab之间的距离  (默认0) */
@property (assign, nonatomic) CGFloat subTitle_margin_thirdLab;

/** thirdLab和fourthLab之间的距离 (默认0) */
@property (assign, nonatomic) CGFloat thirdLab_margin_fourthLab;

/** fourthLab和fifthLab之间的距离 (默认0) */
@property (assign, nonatomic) CGFloat fourthLab_margin_fifthLab;

/** fifthLab和SuperView之间的距离 (默认10) */
@property (assign, nonatomic) CGFloat fifthLab_margin_SuperView;



#pragma mark - 右边间距
@property (assign, nonatomic) CGFloat title_RightMargin;
@property (assign, nonatomic) CGFloat subTitle_RightMargin;
@property (assign, nonatomic) CGFloat thirdLab_RightMargin;
@property (assign, nonatomic) CGFloat fourthLab_RightMargin;
@property (assign, nonatomic) CGFloat fifthLab_RightMargin;

/** image和title之间的距离 (默认0) */
@property (assign, nonatomic) CGFloat image_margin_title;


#pragma mark - 配置图片
/** 左边图片大小, 默认CGSizeZero */
@property (assign, nonatomic) CGSize leftImageSize;

/** imageV的左边距离的父视图左边距离  */
@property (assign, nonatomic) CGFloat leftImageView_MarginToSuperViewLeft;


+ (nonnull instancetype)fiveCellConfigWithImageSize:(CGSize)imageSize image_margin_title:(CGFloat)image_margin_title topBottomMargin:(CGFloat)topBottomMargin centerMargin:(CGFloat)centerMargin;


+ (nonnull instancetype)configWithDetailSettingBlock:(nullable CKJFiveCellConfigBlock)detailSettingBlock;

@end

@class CKJFiveCellModel;

typedef void(^CKJFiveCellModelRowBlock)(__kindof CKJFiveCellModel *_Nonnull m);


@interface CKJFiveCellModel : CKJCommonCellModel


@property (strong, nonatomic, nullable) UIImage *left_ImageName;


/**
 默认使用SDWebImage进行加载
 */
@property (copy, nonatomic, nullable) NSString *left_Image_URL;
@property (strong, nonatomic, nullable) UIImage *placeholderImage;

@property (copy, nonatomic, nullable) NSAttributedString *title;
@property (copy, nonatomic, nullable) NSAttributedString *subTitle;
@property (copy, nonatomic, nullable) NSAttributedString *thirdTitle;
@property (copy, nonatomic, nullable) NSAttributedString *fourthTitle;
@property (copy, nonatomic, nullable) NSAttributedString *fifthTitle;

@property (assign, nonatomic) BOOL radio_Selected;

+ (nonnull instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJFiveCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJFiveCellModelRowBlock)didSelectRowBlock;


@end



NS_ASSUME_NONNULL_BEGIN


@interface CKJFiveCell : CKJCommonTableViewCell<CKJFiveCellModel *>

/** 点击 右边选择按钮 */
- (void)click_RadioBtn;


#pragma mark - 左边图片
@property (weak, nonatomic) UIImageView *imageV;

#pragma mark - 中间的5个UILabel
@property (weak, nonatomic) UILabel *titleLab;
@property (weak, nonatomic) UILabel *subTitleLab;
@property (weak, nonatomic) UILabel *threeLab;
@property (weak, nonatomic) UILabel *fourLab;
@property (weak, nonatomic) UILabel *fiveLab;


#pragma mark - 右边
@property (weak, nonatomic) UIView *rightWrapperLabel;
/** 右边选择的按钮 */
@property (weak, nonatomic) UIButton *radioBtn;


- (void)installData:(__kindof CKJFiveCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView;


@end

NS_ASSUME_NONNULL_END
