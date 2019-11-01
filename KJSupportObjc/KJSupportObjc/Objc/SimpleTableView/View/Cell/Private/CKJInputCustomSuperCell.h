//
//  CKJInputCustomSuperCell.h
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/10/24.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJInputCell.h"

NS_ASSUME_NONNULL_BEGIN

@class CKJInputCustomSuperCellModel;


@interface CKJInputCustomSuperCellModel : CKJCommonCellModel

@property (strong, nonatomic, nonnull) CKJTFModel *tfModel;
- (void)updateTFModel:(void(^_Nullable)(CKJTFModel *_Nonnull tfModel))block;

/// 输入框的限制
@property (strong, nonatomic, nullable) NSArray <CKJInputExpressionRequiredModel *>*expressionRequiredArray;

/// 增加限制
- (void)addRequired:(CKJInputExpressionRequiredModel *)model;

@end

/// 自定义输入框父类Cell， 要注意Cell的重用带来的问题
@interface CKJInputCustomSuperCell : CKJCommonTableViewCell

@property (strong, nonatomic) IBOutlet UITextField *tf;

@end

NS_ASSUME_NONNULL_END
