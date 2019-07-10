//
//  CKJImageRightCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/7/8.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseImageLeftRightCell.h"

NS_ASSUME_NONNULL_BEGIN

@class CKJImageRightCellModel;

typedef void(^CKJImageRightCellModelRowBlock)(__kindof CKJImageRightCellModel *_Nonnull __weak m);



@interface CKJImageRightCellConfig : CKJBaseImageLeftRightCellConfig


@end

@interface CKJImageRightCellModel : CKJBaseImageLeftRightCellModel

+ (nonnull instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJImageRightCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJImageRightCellModelRowBlock)didSelectRowBlock;

@end

@interface CKJImageRightCell : CKJBaseImageLeftRightCell

@end

NS_ASSUME_NONNULL_END
