//
//  CKJBaseFunctionCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/14.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJCommonTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN



@class CKJStackCellConfig, CKJStackCell;






@interface CKJBaseFunctionCellConfig : CKJCommonCellConfig

//@property (copy, nonatomic) NSArray <CKJFuncModel *>*data;


/**
 item之间的距离
 */
@property (assign, nonatomic) CGFloat itemSpace;

/**
 item宽度
 */
@property (assign, nonatomic) CGFloat itemWidth;

/**
 上下左右 距离
 */
@property (assign, nonatomic) UIEdgeInsets edge;



@end

@interface CKJBaseFunctionCellModel : CKJCommonCellModel


@end

@interface CKJBaseFunctionCell : CKJCommonTableViewCell

@end

NS_ASSUME_NONNULL_END
