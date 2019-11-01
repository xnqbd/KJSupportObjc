//
//  CKJLeftRightTopEqualCell.h
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/10/26.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseLeftRightCell.h"

NS_ASSUME_NONNULL_BEGIN

@class CKJLeftRightTopEqualCellModel;

typedef void(^CKJLeftRightTopEqualCellRowBlock)(__kindof CKJLeftRightTopEqualCellModel *_Nonnull m);


@interface CKJLeftRightTopEqualCellConfig : CKJBaseLeftRightCellConfig

/// leftLabel 和 SuperView 垂直方向之间的距离
@property (assign, nonatomic) CGFloat leftLabel_TopMarginToSuperView;

+ (nonnull instancetype)configWithLeftLabelTopMargin:(CGFloat)LeftLabelTopMargin detailSettingBlock:(nullable CKJLeftRightTopEqualCellConfigBlock)detailSettingBlock;

@end


@interface CKJLeftRightTopEqualCellModel : CKJBaseLeftRightCellModel


+ (instancetype _Nonnull)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJLeftRightTopEqualCellRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJLeftRightTopEqualCellRowBlock)didSelectRowBlock;


@end


@interface CKJLeftRightTopEqualCell : CKJBaseLeftRightCell

@end

NS_ASSUME_NONNULL_END
