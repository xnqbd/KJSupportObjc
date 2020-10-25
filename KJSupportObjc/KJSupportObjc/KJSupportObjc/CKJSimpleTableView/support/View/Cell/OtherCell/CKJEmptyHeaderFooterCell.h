//
//  CKJEmptyHeaderFooterCell.h
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/11/6.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJCommonTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN


@interface CKJEmptyHeaderFooterCellModel : CKJCommonCellModel

/// 默认高度10
+ (instancetype)emptyHeaderFooterWithCellHeight:(NSNumber *_Nullable)cellHeight  detailSettingBlock:(void(^_Nullable)(CKJEmptyHeaderFooterCellModel *m))detailSettingBlock;

@end

@interface CKJEmptyHeaderFooterCell : CKJCommonTableViewCell

@end

NS_ASSUME_NONNULL_END
