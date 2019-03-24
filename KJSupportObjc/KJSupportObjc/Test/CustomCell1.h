//
//  CustomCell1.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/3/22.
//  Copyright © 2019年 Lyc. All rights reserved.
//

#import "CKJCommonTableViewCell.h"


@interface CustomCell1Model : CKJCommonCellModel


@property (copy, nonatomic) NSString *Date;
@property (copy, nonatomic) NSString *ItemName;

/** 数量 */
@property (strong, nonatomic) NSNumber *Qty;
@property (strong, nonatomic) NSNumber *Amount;

@end

NS_ASSUME_NONNULL_BEGIN

@interface CustomCell1 : CKJCommonTableViewCell<CustomCell1Model *>

@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *projectLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UILabel *amountLab;

@property (weak, nonatomic) IBOutlet UIView *wrapV;


@end

NS_ASSUME_NONNULL_END
