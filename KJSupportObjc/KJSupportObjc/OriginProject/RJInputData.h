//
//  RJInputData.h
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/12/12.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJInputData.h"


#define JianHuPersonName         @"JianHuPersonName"
#define JianHuPersonidCardNumber @"JianHuPersonidCardNumber"



NS_ASSUME_NONNULL_BEGIN

@interface RJInputData : CKJInputData

@property (copy, nonatomic) NSString *Guardian;
@property (copy, nonatomic) NSString *GuardianIdCardNo;

@end

NS_ASSUME_NONNULL_END
