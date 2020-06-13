//
//  CKJStringChooseHelper.m
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/9/27.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJChooseHelper.h"
#import "ActionSheetPicker.h"
#import <ActionSheetPicker_3_0/ActionSheetPicker.h>
#import "NSObject+WDYHFCategory.h"


@implementation CKJChooseContent

+ (instancetype)contentWithText:(NSString *)text detail:(void(^_Nullable)(__kindof CKJChooseContent *cc))detail {
    CKJChooseContent *contentModel = [[self alloc] init];
    contentModel.text = text;
    if (detail) {
        detail(contentModel);
    }
    return contentModel;
}

@end

@implementation CKJStringChooseItem

+ (instancetype)itemWithID:(NSString *)_id text:(NSString *)text {
    CKJStringChooseItem *item = [[self alloc] init];
    item._id = _id;
    item.content = [CKJChooseContent contentWithText:text detail:nil];
    return item;
}
+ (instancetype)itemWithID:(NSString *)_id contentModel:(CKJChooseContent *)contentModel {
    CKJStringChooseItem *item = [[self alloc] init];
    item._id = _id;
    item.content = contentModel;
    return item;
}

@end

@interface CKJStringChooseHelper ()



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


- (void)showWithSelectedStr:(NSString *)selectedStr origin:(UIView *_Nullable)origin callBack:(CKJChooseBlock _Nonnull)callBack {
    
    __weak typeof(self) weakSelf = self;
    
    NSString *title = [NSString stringWithFormat:@"请选择%@", self.header];
    
    NSArray <NSString *>*contents = [self contents];
    NSInteger selectIndex = 0;
    for (int i = 0; i < contents.count; i++) {
        NSString *content = contents[i];
        if ([content isEqualToString:selectedStr]) {
            selectIndex = i;
            break;
        }
    }
    
    ActionSheetStringPicker *picker =  [[ActionSheetStringPicker alloc] initWithTitle:title rows:contents initialSelection:selectIndex doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        CKJStringChooseItem *temp = [weakSelf.chooseItems kjwd_objectAtIndex:selectedIndex];
        weakSelf.currentSelectedStr = temp.content.text;
        callBack ? callBack(weakSelf, temp, selectedIndex) : nil;
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        
    } origin:origin];
    picker.tapDismissAction = TapActionCancel;
    [picker showActionSheetPicker];
}

- (__kindof CKJStringChooseItem *)currentSelectedItem {
    CKJStringChooseItem *result = [_chooseItems kjwd_objectAtIndex:0];
    for (int i = 0; i < _chooseItems.count; i++) {
        CKJStringChooseItem *item = _chooseItems[i];
        if ([item.content.text isEqualToString:_currentSelectedStr]) {
            result = item;
            break;
        }
    }
    return result;
}

- (NSArray <NSString *>*)contents {
    NSMutableArray <NSString *>*rowContent = [NSMutableArray array];
    for (int i = 0; i < _chooseItems.count; i++) {
        CKJStringChooseItem *item = _chooseItems[i];
        [rowContent addObject:item.content.text];
    }
    return rowContent;
}


@end


@interface CKJDateChooseHelper ()





@end


@implementation CKJDateChooseHelper

- (instancetype)init {
    if (self = [super init]) {
        self.currentSelectedDate = [NSDate date];
        self.format = CKJDateFormat2;
    }
    return self;
}
- (void)setCurrentSelectedDate:(NSDate *)currentSelectedDate {
    if (WDKJ_IsNullObj(currentSelectedDate, [NSDate class])) {
        _currentSelectedDate = [NSDate date];
    } else {
        _currentSelectedDate = currentSelectedDate;
    }
}

- (void)systemConfig {
    self.maxDate = [NSDate date];
    [self updateCurrentSelectedDateWithDateStr:@"1980-01-01"];
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


+ (nonnull instancetype)dateHelperWithHeader:(NSString *_Nonnull)header format:(NSString *)format detailSetting:(void(^_Nullable)(__kindof CKJDateChooseHelper *_Nonnull helper))detailSetting {
    CKJDateChooseHelper *helper = [[self alloc] init];
    helper.header = header;
    if (!WDKJ_IsEmpty_Str(format)) {    
        helper.format = format;
    }
    if (detailSetting) {
        detailSetting(helper);
    }
    return helper;
}

- (void)updateCurrentSelectedDateWithDateStr:(NSString *)str {
    self.currentSelectedDate = [NSDate kjwd_returnDate:str withDateFormat:self.format];
}



@end
