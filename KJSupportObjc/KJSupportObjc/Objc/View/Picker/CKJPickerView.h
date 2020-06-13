//
//  CKJPickerView.h
//  WDYHFSDK
//
//  Created by chenkaijie on 2018/9/15.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CKJToolView.h"
#import "CKJBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class CKJPickerView, CKJPickerComponentModel;


@interface CKJPickerRowModel : CKJBaseModel

// 这个row 和 component 不要轻易换名字
@property (assign, nonatomic, readonly) NSInteger *row;
@property (assign, nonatomic, readonly) NSInteger *component;

@property (copy, nonatomic, nullable) NSString *title;
@property (copy, nonatomic, nullable) NSAttributedString *attTitle;

@property (strong, nonatomic, nullable) UIView *view;

+ (instancetype)rowModelWithTitle:(id)title;


/// int result = [CKJPickerRowModel _getTitles:allSelectRows].kjwd_stringValue.intValue;
+ (NSArray <NSString *>*)_getTitles:(NSArray <CKJPickerRowModel *>*)array;

//@property (copy, nonatomic) vod;


#pragma mark - 子类可以重写下面方法，不需要方法的重写返回nil即可

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


+ (NSMutableArray <CKJPickerComponentModel *>*)createComponentsByRows:(NSArray <NSArray <CKJPickerRowModel *>*>*)rowss;

+ (instancetype)componentWithDetail:(void(^_Nonnull)(CKJPickerComponentModel *__weak m))detail;

/**
 默认选中的索引，默认选中第0行，一般是设置初始化的时候默认的索引
 */
@property (assign, nonatomic) NSInteger selectIndex;

/// 设置默认选中的模型
- (void)_setSelectModel:(CKJPickerRowModel *_Nullable)rowModel;

@end


@interface CKJPickerView : UIPickerView<UIPickerViewDataSource, UIPickerViewDelegate>


/// 应该在刷新之后，然后再设置选中的默认行 [self.picker reloadAllComponents]; [self.picker _setDefaultSelectIndex];
@property (strong, nonatomic) NSArray <CKJPickerComponentModel *>*dataArr;


/// 如果需要默认选中某一行，可以在刷新之后调用这个方法 [self.picker reloadAllComponents]; [self.picker _setDefaultSelectIndex];
- (void)_setDefaultSelectIndex;

/// 当前滚动停止后回调，选中的数据
@property (copy, nonatomic, nullable) void(^endScroll_didSelect_callBack)(NSArray <CKJPickerRowModel *>*allSelectRows, CKJPickerRowModel *currentRowModel);

@end


NS_ASSUME_NONNULL_END
