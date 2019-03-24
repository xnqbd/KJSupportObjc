//
//  CKJToolPickerView.h
//  WDYHFSDK
//
//  Created by chenkaijie on 2018/9/15.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CKJToolView.h"
#import "CKJPickerView.h"

@interface CKJToolPickerView : CKJToolView <CKJPickerView *>

- (instancetype)initWithFrame:(CGRect)frame pickerView:(CKJPickerView *)pickerView;

@end
