//
//  RJSelectDateCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/3/12.
//  Copyright © 2019年 Lyc. All rights reserved.
//

#import "CKJCommonTableViewCell.h"



#define BeginDate_Today [[NSDate date] kjwd_YearMonthDayString]
#define EndDate_Today [[NSDate date] kjwd_YearMonthDayString]



@interface SelectDateCellConfig : CKJCommonCellConfig

@property (copy, nonatomic) NSString *beginDate;
@property (copy, nonatomic) NSString *endDate;

/**
 默认开启
 */
@property (assign, nonatomic) BOOL endDateUserInteractionEnabled;

@end

NS_ASSUME_NONNULL_BEGIN


@interface SelectDateCellModel : CKJCommonCellModel

@property (copy, nonatomic) void(^searchBlock)(NSString *startDate, NSString *endDate);

@end

@interface SelectDateCell : CKJCommonTableViewCell //<SelectDateCellModel *>

@end

NS_ASSUME_NONNULL_END
