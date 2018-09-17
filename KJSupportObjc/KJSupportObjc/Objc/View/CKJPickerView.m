//
//  CKJPickerView.m
//  WDYHFSDK
//
//  Created by chenkaijie on 2018/9/15.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CKJPickerView.h"
#import "NSObject+WDYHFCategory.h"

@implementation CKJPickerRowModel

- (nullable NSString *)returnTitleOfComponent:(NSInteger)component row:(NSInteger)row componentModel:(CKJPickerComponentModel *)componentModel pickerView:(UIPickerView *)pickerView {
    return self.title;
}
- (nullable NSAttributedString *)returnAttributedTitleOfComponent:(NSInteger)component row:(NSInteger)row componentModel:(CKJPickerComponentModel *)componentModel pickerView:(UIPickerView *)pickerView {
    return self.attributedTitle;
}


@end
@implementation CKJPickerComponentModel

@end


@interface CKJPickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) UIBarButtonItem *titleItem;

@end

@implementation CKJPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

- (void)setDataArr:(NSArray<CKJPickerComponentModel *> *)dataArr {
    _dataArr = dataArr;
    [dataArr enumerateObjectsUsingBlock:^(CKJPickerComponentModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger defaultSelectIndex = obj.defaultSelectIndex;
        if (defaultSelectIndex < obj.modelArray.count) {
            [self selectRow:defaultSelectIndex inComponent:idx animated:YES];
        }
    }];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    NSInteger count = self.dataArr.count;
    return count;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    CKJPickerComponentModel *componentModel = [self.dataArr kjwd_objectAtIndex:component];
    NSArray <CKJPickerRowModel *>*array = componentModel.modelArray;
    return array.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    CKJPickerComponentModel *componentModel = [self.dataArr kjwd_objectAtIndex:component];
    NSArray <CKJPickerRowModel *>*array = componentModel.modelArray;
    CKJPickerRowModel *model = [array kjwd_objectAtIndex:row];
    NSString *title = [model returnTitleOfComponent:component row:row componentModel:componentModel pickerView:pickerView];
    return title;
}

- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    CKJPickerComponentModel *componentModel = [self.dataArr kjwd_objectAtIndex:component];
    NSArray <CKJPickerRowModel *>*array = componentModel.modelArray;
    CKJPickerRowModel *model = [array kjwd_objectAtIndex:row];
    NSAttributedString *attributedTitle = [model returnAttributedTitleOfComponent:component row:row componentModel:componentModel pickerView:pickerView];
    return attributedTitle;
}

- (void)dealloc {
    NSLog(@"%@  dealloc", self);
}

@end
