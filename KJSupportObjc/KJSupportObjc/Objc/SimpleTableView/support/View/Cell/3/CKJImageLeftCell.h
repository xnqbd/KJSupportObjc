//
//  CKJImageLeftCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/7/8.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseImageLeftRightCell.h"

NS_ASSUME_NONNULL_BEGIN



@class CKJImageLeftCellModel;

typedef void(^CKJImageLeftCellModelRowBlock)(__kindof CKJImageLeftCellModel *_Nonnull __weak m);



@interface CKJImageLeftCellConfig : CKJBaseImageLeftRightCellConfig

+ (instancetype)imageLeftCellConfigWithDetail:(void(^)(__kindof CKJImageLeftCellConfig * _Nonnull m))detail;

@end

@interface CKJImageLeftCellModel : CKJBaseImageLeftRightCellModel

+ (nonnull instancetype)imageLeftWithCellHeight:(nullable NSNumber *)cellHeight cellModel_id:(nullable NSString *)cellModel_id detailSettingBlock:(nullable CKJImageLeftCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJImageLeftCellModelRowBlock)didSelectRowBlock;


@end

@interface CKJImageLeftCell : CKJBaseImageLeftRightCell

@property (weak, nonatomic, readonly) UIView *rightWrapper;

@end

NS_ASSUME_NONNULL_END
