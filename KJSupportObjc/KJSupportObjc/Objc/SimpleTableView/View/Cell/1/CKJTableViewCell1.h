//
//  CKJTableViewCell1.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/12.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseTableViewCell.h"
#import "CKJCombineCellProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@class CKJTableViewCell1Model;

typedef void(^CKJTableViewCell1RowBlock)(__kindof CKJTableViewCell1Model *_Nonnull m);


@interface CKJTableViewCell1Model : CKJBaseTableViewCellModel

+ (instancetype _Nonnull)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJTableViewCell1RowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJTableViewCell1RowBlock)didSelectRowBlock;

@end


@interface CKJTableViewCell1 : CKJBaseTableViewCell

@end

NS_ASSUME_NONNULL_END
