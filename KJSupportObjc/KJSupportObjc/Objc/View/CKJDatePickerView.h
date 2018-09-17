//
//  CKJDatePickerView.h
//  WDYHFSDK
//
//  Created by chenkaijie on 2018/9/15.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CKJToolView.h"

@interface CKJDatePickerView : CKJToolView <UIDatePicker *>

/**
 默认时间
 */
@property (strong, nonatomic) NSDate *defaultDate;

@end
