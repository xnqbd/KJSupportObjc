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

- (__kindof UIView *)returnViewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view componentModel:(CKJPickerComponentModel *)componentModel pickerView:(UIPickerView *)pickerView {
    if (view == nil) {
        view = [[UILabel alloc] init];
    }
    if ([view isKindOfClass:UILabel.class]) {
        UILabel *lab = (UILabel *)view;
        lab.textAlignment = NSTextAlignmentCenter;
//        lab.backgroundColor = [UIColor kjwd_arc4Color];
// lab.text = [NSString stringWithFormat:@"%ld分区 %ld行", (long)component, (long)row];
        lab.text = self.title;
    }
    
    return view;
}



@end
@implementation CKJPickerComponentModel

@end


@interface CKJPickerView ()

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
    
    [self installComponent:component withComponentModel:componentModel];
    
    NSArray <CKJPickerRowModel *>*array = componentModel.modelArray;
    return array.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    CKJPickerComponentModel *componentModel = [self.dataArr kjwd_objectAtIndex:component];
    NSArray <CKJPickerRowModel *>*array = componentModel.modelArray;
    CKJPickerRowModel *model = [array kjwd_objectAtIndex:row];
    
    [self installRow:row withRowModel:model];
    [self installComponent:component withRowModel:model];
    
    NSString *title = [model returnTitleOfComponent:component row:row componentModel:componentModel pickerView:pickerView];
    return title;
}

- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    CKJPickerComponentModel *componentModel = [self.dataArr kjwd_objectAtIndex:component];
    NSArray <CKJPickerRowModel *>*array = componentModel.modelArray;
    CKJPickerRowModel *model = [array kjwd_objectAtIndex:row];
    
    [self installRow:row withRowModel:model];
    [self installComponent:component withRowModel:model];
    
    NSAttributedString *attributedTitle = [model returnAttributedTitleOfComponent:component row:row componentModel:componentModel pickerView:pickerView];
    return attributedTitle;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    CKJPickerComponentModel *componentModel = [self.dataArr kjwd_objectAtIndex:component];
    CKJPickerRowModel *model = [componentModel.modelArray kjwd_objectAtIndex:row];
    
    
    [self installRow:row withRowModel:model];
    [self installComponent:component withRowModel:model];
    

    return [model returnViewForRow:row forComponent:component reusingView:view componentModel:componentModel pickerView:self];
}

// 这个方法 如果屏幕旋转就会调用，重新计算宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//    if (component == 0) {
//        return WDAPP_ScreenWidth() * 0.25;
//    } else {
//        return WDAPP_ScreenWidth() * 0.65;
//    }

    NSInteger numberOfComponents = [self numberOfComponentsInPickerView:pickerView];
    CKJPickerComponentModel *componentModel = [self.dataArr kjwd_objectAtIndex:component];

    CGFloat multiplie = componentModel.widthOf_MultipliedByPickerView;
    
    if (multiplie != 0) {
        return self.kjwd_width * multiplie;
    } else {
        CGFloat width = componentModel.width;
        if (width == 0) {
            if (numberOfComponents <= 0) {
                width = self.kjwd_width;
            } else {
                width = self.kjwd_width / numberOfComponents;
            }
        }
        return width;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
// 这是UIKit的BUG
    if (component >= [self numberOfComponentsInPickerView:pickerView]) {
        return 0;
    }
    CKJPickerComponentModel *componentModel = [self.dataArr kjwd_objectAtIndex:component];
    CGFloat rowHeight = componentModel.rowHeight;
    if (rowHeight == 0) {
        rowHeight = 35;
    }
    return rowHeight;
}

- (void)dealloc {
//    NSLog(@"%@  dealloc", self);
}



- (void)installRow:(NSInteger)row withRowModel:(CKJPickerRowModel *)rowModel {
    [rowModel setValue:@(row) forKey:@"row"];
}
- (void)installComponent:(NSInteger)component withRowModel:(CKJPickerRowModel *)rowModel {
    [rowModel setValue:@(component) forKey:@"component"];
}
- (void)installComponent:(NSInteger)component withComponentModel:(CKJPickerComponentModel *)componentModel {
    [componentModel setValue:@(component) forKey:@"component"];
}


@end
