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


+ (instancetype)rowModelWithTitle:(id)title {
    CKJPickerRowModel *m = [[self alloc] init];
    if ([title isKindOfClass:[NSString class]]) {
        m.title = title;
    } else if ([title isKindOfClass:[NSAttributedString class]]) {
        m.attTitle = title;
    }
    return m;
}

+ (NSArray <NSString *>*)_getTitles:(NSArray <CKJPickerRowModel *>*)array {
    NSMutableArray *result = [NSMutableArray array];
    for (CKJPickerRowModel *m in array) {
        [result kjwd_addObject:m.title];
    }
    return result;
}

- (nullable NSString *)returnTitleOfComponent:(NSInteger)component row:(NSInteger)row componentModel:(CKJPickerComponentModel *)componentModel pickerView:(UIPickerView *)pickerView {
    return _title;
}
- (nullable NSAttributedString *)returnAttributedTitleOfComponent:(NSInteger)component row:(NSInteger)row componentModel:(CKJPickerComponentModel *)componentModel pickerView:(UIPickerView *)pickerView {
    return self.attTitle;
}

- (__kindof UIView *)returnViewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view componentModel:(CKJPickerComponentModel *)componentModel pickerView:(UIPickerView *)pickerView {
    
    BOOL customView = !WDKJ_IsNullObj(self.view, [UIView class]);
    
    if (view == nil) {
        if (customView) {
            view = self.view;
        } else {
            view = [[UILabel alloc] init];
        }
    }
    
    if (customView) {
        NSLog(@"类似cellForRow 应该更新数据   component: %ld   row: %ld ", component, row);
    } else {
        UILabel *lab = (UILabel *)view;
        lab.textAlignment = NSTextAlignmentCenter;
        // lab.backgroundColor = [UIColor kjwd_arc4Color];
        // lab.text = [NSString stringWithFormat:@"%ld分区 %ld行", (long)component, (long)row];
       
        if (!WDKJ_IsEmpty_Str(_title)) {
            lab.text = _title;
        } else if (!WDKJ_IsEmpty_AttributedStr(_attTitle)) {
            lab.attributedText = _attTitle;
        }
    }
    
    return view;
}



@end
@implementation CKJPickerComponentModel


+ (NSMutableArray <CKJPickerComponentModel *>*)createComponentsByRows:(NSArray <NSArray <CKJPickerRowModel *>*>*)rowss {
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 0; i < rowss.count; i++) {
        NSArray <CKJPickerRowModel *>* rows = rowss[i];
        CKJPickerComponentModel *compoment = [[CKJPickerComponentModel alloc] init];
        compoment.modelArray = rows;
        [result addObject:compoment];
    }
    return result;
}

+ (instancetype)componentWithDetail:(void(^_Nonnull)(CKJPickerComponentModel *m))detail {
    CKJPickerComponentModel *m = [[self alloc] init];
    if (detail) {
        detail(m);
    }
    return m;
}
- (void)_setSelectModel:(CKJPickerRowModel *)rowModel {
    if (WDKJ_IsNullObj(rowModel, [CKJPickerRowModel class])) {
        return;
    }
    NSArray *modelArray = self.modelArray;
    for (int i = 0; i < modelArray.count; i++) {
        CKJPickerRowModel *m = modelArray[i];
        if (m == rowModel) {
            self.selectIndex = i;
            break;
        }
    }
}

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

- (void)_setDefaultSelectIndex {
    // 这个应该在 [self.picker reloadAllComponents];之后再调用
    [self.dataArr enumerateObjectsUsingBlock:^(CKJPickerComponentModel * _Nonnull obj, NSUInteger component, BOOL * _Nonnull stop) {
        NSInteger defaultSelectIndex = obj.selectIndex;
        if (defaultSelectIndex < [self numberOfRowsInComponent:component]) {
            [self selectRow:defaultSelectIndex inComponent:component animated:NO];
        }
    }];
}

#pragma mark - UIPickerViewDataSource
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

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    NSLog(@" 已经选中 %ld  %ld   ", component, row);
    
    if (self.endScroll_didSelect_callBack) {
    
        NSMutableArray <CKJPickerRowModel *>*result = [NSMutableArray array];
        
        NSArray <CKJPickerComponentModel *>*sections = self.dataArr;
        
        for (int component = 0; component < sections.count; component++) {
            CKJPickerComponentModel *section = sections[component];
            NSArray <CKJPickerRowModel *>*rows = section.modelArray;
            
            NSInteger selectRow = [pickerView selectedRowInComponent:component];
            section.selectIndex = selectRow;
            
            CKJPickerRowModel *currentRowModel = rows[selectRow];
            
            [result addObject:currentRowModel];
        }
        
        
        CKJPickerRowModel *currentRow = sections[component].modelArray[row];
        
        
        self.endScroll_didSelect_callBack(result, currentRow);
    }
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
