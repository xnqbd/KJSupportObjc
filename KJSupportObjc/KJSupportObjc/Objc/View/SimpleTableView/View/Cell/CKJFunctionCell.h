//
//  CKJFunctionCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/14.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJCommonTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN


@interface CKJFunctionCellModel : CKJCommonCellModel

@property (copy, nonatomic) NSArray <NSDictionary *>*data;

@end


@interface CKJFunctionCell : CKJCommonTableViewCell

@end

NS_ASSUME_NONNULL_END
