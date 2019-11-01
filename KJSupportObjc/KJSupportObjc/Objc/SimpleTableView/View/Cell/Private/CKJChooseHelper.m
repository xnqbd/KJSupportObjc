//
//  CKJStringChooseHelper.m
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/9/27.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJChooseHelper.h"
#import <ActionSheetPicker_3_0/ActionSheetPicker.h>
#import "NSObject+WDYHFCategory.h"

@implementation CKJStringChooseItem

+ (nonnull instancetype)itemWithContent:(NSString *_Nonnull)content takeStr:(NSString *_Nonnull)takeStr {
    CKJStringChooseItem *item = [[self alloc] init];
    item.takeStringValue = takeStr;
    item.content = content;
    return item;
}

@end


@implementation CKJStringChooseHelper

+ (nonnull instancetype)helperWithHeader:(NSString *_Nonnull)header items:(NSArray <__kindof CKJStringChooseItem *>*)items detailSetting:(void(^_Nullable)(__kindof CKJStringChooseHelper *_Nonnull helper))detailSetting {
    CKJStringChooseHelper *helper = [[self alloc] init];
    helper.header = header;
    helper.chooseItems = items;
    if (detailSetting) {
        detailSetting(helper);
    }
    return helper;
}


- (void)showWithSelectedStr:(NSString *_Nonnull)selectedStr origin:(UIView *_Nullable)origin callBack:(CKJChooseBlock _Nonnull)callBack {
    //    @{@"name":@"性别",@"type":@"choose",@"key":@"Gender",@"required":@"true",@"img":@"jzk_xb"}
    
    NSString *title = [NSString stringWithFormat:@"请选择%@", self.header];
    //    if([dataDic[@"type"] isEqualToString:@"choose"]){
    
    NSArray <CKJStringChooseItem *>*items = self.chooseItems;
    NSMutableArray <NSString *>*rowContent = [NSMutableArray array];
    NSInteger selectIndex = 0;
    
    for (int i = 0; i < items.count; i++) {
        CKJStringChooseItem *item = items[i];
        
        [rowContent addObject:item.content];
        if ([item.content isEqualToString:selectedStr]) {
            selectIndex = i;
            self.currentSelectedItem = item;
        }
    }
    
    __weak typeof(self) weakSelf = self;
    
    ActionSheetStringPicker *picker =  [[ActionSheetStringPicker alloc] initWithTitle:title rows:rowContent initialSelection:selectIndex doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        CKJStringChooseItem *temp = [weakSelf.chooseItems kjwd_objectAtIndex:selectedIndex];
        
        callBack ? callBack(weakSelf, temp, selectedIndex) : nil;
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        
    } origin:origin];
    picker.tapDismissAction = TapActionCancel;
    [picker showActionSheetPicker];
    
}

@end



@implementation CKJDateChooseHelper

- (instancetype)init {
    if (self = [super init]) {
        self.currentSelectedDate = [NSDate date];
    }
    return self;
}

- (void)systemConfig {
    self.maxDate = [NSDate date];
    self.currentSelectedDate = [NSDate kjwd_returnDate:@"1980-01-01" withDateFormat:CKJDateFormat2];
}

- (void)showWithOrigin:(UIView *_Nullable)origin callBack:(CKJDateChooseBlock _Nonnull)callBack {
    NSString *title = [NSString stringWithFormat:@"请选择%@", self.header];
    
    __weak typeof(self) weakSelf = self;
    
    ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:title datePickerMode:UIDatePickerModeDate selectedDate:_currentSelectedDate doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        weakSelf.currentSelectedDate = selectedDate;
        callBack ? callBack(weakSelf) : nil;
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        
    } origin:origin];
    datePicker.tapDismissAction = TapActionCancel;
    datePicker.maximumDate = _maxDate;
    datePicker.minimumDate = _minDate;
    
    [datePicker showActionSheetPicker];
}





+ (nonnull instancetype)dateHelperWithHeader:(NSString *_Nonnull)header detailSetting:(void(^_Nullable)(__kindof CKJDateChooseHelper *_Nonnull helper))detailSetting {
    CKJDateChooseHelper *helper = [[self alloc] init];
    helper.header = header;
    if (detailSetting) {
        detailSetting(helper);
    }
    return helper;
}



@end
