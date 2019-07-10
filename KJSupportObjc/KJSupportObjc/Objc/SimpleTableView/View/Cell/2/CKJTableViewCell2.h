//
//  CKJTableViewCell2.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/17.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN


@class CKJTableViewCell2Model;



typedef void(^CKJTableViewCell2RowBlock)(__kindof CKJTableViewCell2Model *_Nonnull m);


@interface CKJTableViewCell2Model : CKJBaseTableViewCellModel

+ (instancetype _Nonnull)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJTableViewCell2RowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJTableViewCell2RowBlock)didSelectRowBlock;

@end


@interface CKJTableViewCell2 : CKJBaseTableViewCell

@end


NS_ASSUME_NONNULL_END
