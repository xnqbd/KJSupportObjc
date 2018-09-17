//
//  CKJPickerView.h
//  WDYHFSDK
//
//  Created by chenkaijie on 2018/9/15.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CKJToolView.h"

@class CKJPickerView, CKJPickerComponentModel;


@interface CKJPickerRowModel : NSObject

@property (assign, nonatomic) CGFloat rowHeight;

@property (copy, nonatomic, nullable) NSString *title;

@property (copy, nonatomic, nullable) NSAttributedString *attributedTitle;

@property (strong, nonatomic) UIView *view;

/** 设置Title */
- (nullable NSString *)returnTitleOfComponent:(NSInteger)component row:(NSInteger)row componentModel:(CKJPickerComponentModel *)componentModel pickerView:(UIPickerView *)pickerView;
/** 如果设置了AttributedTitle，那么设置Title会没有作用 */
- (nullable NSAttributedString *)returnAttributedTitleOfComponent:(NSInteger)component row:(NSInteger)row componentModel:(CKJPickerComponentModel *)componentModel pickerView:(UIPickerView *)pickerView;
@end

@interface CKJPickerComponentModel : NSObject

/**
 默认选中的索引，默认选中第0行，一般是设置初始化的时候默认的索引
 */
@property (assign, nonatomic) NSInteger defaultSelectIndex;

@property (assign, nonatomic) CGFloat width;
/**  这里面可能有各种类型的model */
@property (strong, nonatomic) NSArray <CKJPickerRowModel *>*modelArray;

@end





@interface CKJPickerView : UIPickerView

@property (strong, nonatomic) NSArray <CKJPickerComponentModel *>* _Nullable dataArr;
;

@end
