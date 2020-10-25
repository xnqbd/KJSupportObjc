//
//  CKJLibraryHelper.h
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/10/24.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseModel.h"
#import "CKJInputCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CKJLibraryHelper : CKJBaseModel


+ (void)commomCode1WithTFModel:(CKJTFModel *)tfModel tf:(UITextField *)tf;
+ (void)commomCode2WithTFModel:(CKJTFModel *)tfModel tf:(UITextField *)tf;


@end

NS_ASSUME_NONNULL_END
