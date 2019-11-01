//
//  CKJLeftRightCenterEqualCell.m
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/10/26.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJLeftRightCenterEqualCell.h"



@implementation CKJLeftRightCenterEqualCellConfig

+ (nonnull instancetype)configWithDetailSettingBlock:(nullable CKJLeftRightCenterEqualCellConfigBlock)detailSettingBlock {
    return [super configWithDetailSettingBlock:detailSettingBlock];
}

@end


@implementation CKJLeftRightCenterEqualCellModel


+ (instancetype _Nonnull)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJLeftRightCenterEqualCellRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJLeftRightCenterEqualCellRowBlock)didSelectRowBlock {
    return [super modelWithCellHeight:cellHeight cellModel_id:cellModel_id detailSettingBlock:detailSettingBlock didSelectRowBlock:didSelectRowBlock];
}

@end


@implementation CKJLeftRightCenterEqualCell

@end
