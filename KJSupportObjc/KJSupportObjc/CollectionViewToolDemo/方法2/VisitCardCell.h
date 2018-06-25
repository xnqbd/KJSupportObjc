//
//  VisitCardCell.h
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/6/25.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "CommonCollectionViewCell.h"

@interface VisitCardCell : CommonCollectionViewCell

/**
 卡类型(健康卡、社保卡)
 */
@property (weak, nonatomic) IBOutlet UILabel *cardTypeLab;
/**
 卡号
 */
@property (weak, nonatomic) IBOutlet UILabel *cardNumLab;

@end
