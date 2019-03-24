//
//  CKJPickerView.h
//  WDYHFSDK
//
//  Created by chenkaijie on 2018/9/15.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CKJToolView.h"
#import "CKJBaseModel.h"



@class CKJPickerView, CKJPickerComponentModel;


@interface CKJPickerRowModel : CKJBaseModel

// 这个row 和 component 不要轻易换名字
@property (assign, nonatomic, readonly) NSInteger *row;
@property (assign, nonatomic, readonly) NSInteger *component;

@property (copy, nonatomic, nullable) NSString *title;

@property (copy, nonatomic, nullable) NSAttributedString *attributedTitle;

@property (strong, nonatomic, nullable) UIView *view;


#pragma mark - 子类可以重写西面方法，不需要方法的重写返回nil即可

/** 设置Title */
- (nullable NSString *)returnTitleOfComponent:(NSInteger)component row:(NSInteger)row componentModel:(CKJPickerComponentModel *)componentModel pickerView:(UIPickerView *)pickerView;
/** 如果设置了AttributedTitle，那么设置Title会没有作用 */
- (nullable NSAttributedString *)returnAttributedTitleOfComponent:(NSInteger)component row:(NSInteger)row componentModel:(CKJPickerComponentModel *)componentModel pickerView:(UIPickerView *)pickerView;
/** 如果设置了View，那么设置Title和AttributedTitle会没有作用 */
- (__kindof UIView *)returnViewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view componentModel:(CKJPickerComponentModel *)componentModel pickerView:(UIPickerView *)pickerView;

@end

@interface CKJPickerComponentModel : CKJBaseModel


// 这个row 和 component 不要轻易换名字
@property (assign, nonatomic, readonly) NSInteger *component;

/**
 默认选中的索引，默认选中第0行，一般是设置初始化的时候默认的索引
 */
@property (assign, nonatomic) NSInteger defaultSelectIndex;

/**
 宽度（直接设置宽度等于一个值，比如 width = 100）
 */
@property (assign, nonatomic) CGFloat width;
/**
 宽度倍数（设置的当前分区的宽度占当前PickerView的宽度的倍数，比如 multipliedByPickerView = 0.3）
 */
@property (assign, nonatomic) CGFloat widthOf_MultipliedByPickerView;

@property (assign, nonatomic) CGFloat rowHeight;

/**  这里面可能有各种类型的model */
@property (strong, nonatomic) NSArray <CKJPickerRowModel *>*modelArray;

@end


@interface CKJPickerView : UIPickerView<UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSArray <CKJPickerComponentModel *>* _Nullable dataArr;


@end
