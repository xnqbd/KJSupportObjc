//
//  RJBillDetailModel.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/20.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseModel.h"
#import "CKJCombineCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface RJBillDetailModel : CKJBaseModel<CKJCombineCellProtocol>

@property (copy, nonatomic) NSString *ProjectType;
@property (copy, nonatomic) NSString *ProjectName;
@property (copy, nonatomic) NSString *Spec;
@property (copy, nonatomic) NSString *Unit;
@property (copy, nonatomic) NSNumber *Price;


@end

NS_ASSUME_NONNULL_END
