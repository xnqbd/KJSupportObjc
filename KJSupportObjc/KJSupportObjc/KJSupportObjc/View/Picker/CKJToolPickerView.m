//
//  CKJToolPickerView.m
//  WDYHFSDK
//
//  Created by chenkaijie on 2018/9/15.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CKJToolPickerView.h"
#import "NSObject+WDYHFCategory.h"
#import <Masonry/Masonry.h>
#import "CKJPickerView.h"


@interface CKJToolPickerView ()

@end

@implementation CKJToolPickerView

    - (instancetype)initWithFrame:(CGRect)frame pickerView:(CKJPickerView *)pickerView {
        if (self = [super initWithFrame:frame]) {
            [self.bottomContentView addSubview:pickerView];
            [pickerView kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superView) {
                make.edges.equalTo(superView);
            }];
            self.targetView = pickerView;
        }
        return self;
    }
    
- (void)doneAction:(UIBarButtonItem *)sender {
    if (self.confirmBlock == nil) {
        return;
    }
    
    NSMutableArray <__kindof CKJPickerRowModel *>*result = [NSMutableArray array];
    CKJPickerView *pickerV = self.targetView;
    [pickerV.dataArr enumerateObjectsUsingBlock:^(CKJPickerComponentModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger row = [pickerV selectedRowInComponent:idx];
        __kindof  CKJPickerRowModel *rowModel = [obj.modelArray kjwd_objectAtIndex:row];
        [result kjwd_addObject:rowModel];
    }];
    self.confirmBlock(result, self);
}
- (void)dealloc {
//    NSLog(@"%@  dealloc", self);
}

@end
