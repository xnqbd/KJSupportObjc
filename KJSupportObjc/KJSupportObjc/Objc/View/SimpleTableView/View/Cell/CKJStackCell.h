//
//  CKJStackCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/14.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJCommonTableViewCell.h"
#import "CKJBaseFunctionCell.h"

NS_ASSUME_NONNULL_BEGIN



@interface CKJStackCellConfig : CKJCommonCellConfig



/**
 数据
 */
@property (strong, nonatomic) NSArray <NSArray <CKJFuncModel *>*>*data;

/**
 唯一的onlyStackView的edge
 */
@property (assign, nonatomic) UIEdgeInsets edge;

/**
 水平StackView，Item之间的间距
 */
@property (assign, nonatomic) CGFloat h_itemSpacing;
/**
 垂直StackView之间的间距
 */
@property (assign, nonatomic) CGFloat v_stackViewSpacing;


@end



@interface CKJStackCellModel : CKJCommonCellModel


@end


@interface CKJStackCell : CKJCommonTableViewCell


@end

NS_ASSUME_NONNULL_END
