//
//  VisitCardModel.h
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/6/25.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "CommonCellModel.h"

@interface VisitCardModel : CommonCellModel


/**
 卡类型(健康卡、社保卡)
 */
@property (copy, nonatomic) NSString *cardType;

/**
 卡号
 */
@property (copy, nonatomic) NSString *cardNum;

@end
