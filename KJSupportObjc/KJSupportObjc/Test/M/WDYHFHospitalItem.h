//
//  WDYHFSelectHospitalModel.h
//  WDYHFSDK
//
//  Created by chenkaijie on 2018/9/15.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CKJPickerView.h"

@class WDYHFAreaItem;

@interface WDYHFHospitalItem : CKJPickerRowModel


/** 医院代码 */
@property (copy, nonatomic) NSString *org_code;
/** 医院名称 */
@property (copy, nonatomic) NSString *org_name;

@end


@interface WDYHFAreaItem : CKJPickerRowModel

@property (strong, nonatomic) NSArray <WDYHFHospitalItem *>*hospitals;

/** 330500 */
@property (copy, nonatomic) NSString *area;
/** 湖州市 */
@property (copy, nonatomic) NSString *area_name;

@end



@interface WDYHFSelectHospitalPickerView : CKJPickerView

@end

