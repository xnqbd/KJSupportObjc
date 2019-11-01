//
//  CKJEmptyCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/13.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJCommonTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN


/**
 不要继承此类
 */
@interface CKJEmptyCellModel : CKJCommonCellModel

+ (instancetype)emptyCellModelWithHeight:(CGFloat)cellHeight showLine:(BOOL)showLine;

@end

@interface CKJEmptyCell : CKJCommonTableViewCell

@end

NS_ASSUME_NONNULL_END
