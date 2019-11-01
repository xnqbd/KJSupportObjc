//
//  CKJLeftRightCenterEqualCell.h
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/10/26.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseLeftRightCell.h"

NS_ASSUME_NONNULL_BEGIN


@class CKJLeftRightCenterEqualCellModel;

typedef void(^CKJLeftRightCenterEqualCellRowBlock)(__kindof CKJLeftRightCenterEqualCellModel *_Nonnull m);


@interface CKJLeftRightCenterEqualCellConfig : CKJBaseLeftRightCellConfig


+ (nonnull instancetype)configWithDetailSettingBlock:(nullable CKJLeftRightCenterEqualCellConfigBlock)detailSettingBlock;

@end

@interface CKJLeftRightCenterEqualCellModel : CKJBaseLeftRightCellModel

+ (instancetype _Nonnull)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJLeftRightCenterEqualCellRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJLeftRightCenterEqualCellRowBlock)didSelectRowBlock;

@end


@interface CKJLeftRightCenterEqualCell : CKJBaseLeftRightCell

@end

NS_ASSUME_NONNULL_END
