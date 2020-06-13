//
//  CKJSimpleTableViewStyle.h
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/12/6.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseModel.h"


@class CKJSimpleTableView;

NS_ASSUME_NONNULL_BEGIN



//@interface CKJShareStyle : CKJBaseModel
//
//@property (assign, nonatomic) CGFloat title_MarginTo_SuperViewLeft;
//@property (assign, nonatomic) CGFloat rightLabel_MarginTo_SuperViewRight;
//
//@end






@interface CKJSectionCornerStyle : CKJBaseModel

@property (assign, nonatomic) BOOL sectionCornerEnable;

@property (strong, nonatomic) UIColor *stroke_Color;

@property (assign, nonatomic) CGFloat corner_Radius;


@end



@interface CKJInputTitleStyle : CKJBaseModel

/// 默认12
@property (assign, nonatomic) CGFloat left;

/// 默认nil
@property (strong, nonatomic, nullable) NSNumber *titleWidth;

/// 左边title的属性
@property (copy, nonatomic) NSDictionary *titleAttributes;


+ (instancetype)styleWithLeft:(NSNumber *_Nullable)left titleWidth:(NSNumber *_Nullable)titleWidth detail:(void(^_Nullable)(CKJInputTitleStyle *cs))detail;

@end


@interface CKJSimpleTableViewStyle : CKJBaseModel


/// 是否需要更新OnlyView的约束（一般情况都是NO）
@property (assign, nonatomic) BOOL needUpdateOnlyViewConstraints;
@property (strong, nonatomic, nullable) NSValue *onlyViewEdge;
/// 分区圆角样式
@property (strong, nonatomic, nullable) CKJSectionCornerStyle *sectionCornerStyle;


/// 行高，依次看cell.cellHeight，section.rowHeight，style.rowHeight的值，如果都为nil，最后自适应高度
@property (copy, nonatomic, nullable) NSNumber *rowHeight;

/// 可能为nil，默认0
@property (copy, nonatomic, nullable) NSNumber *sectionHeaderHeight;

/// 可能为nil，默认10
@property (copy, nonatomic, nullable) NSNumber *sectionFooterHeight;

/// 默认为UIEdgeInsetsMake(0, 15, 0, 0)， 分割线edge 
@property (strong, nonatomic, nullable) NSValue *lineEdge;

#pragma mark - 输入框相关

/// 输入框文本的属性 只支持（文字大小和颜色）
@property (strong, nonatomic) NSDictionary *tfTextAttributed;
@property (strong, nonatomic) NSDictionary *tfPlaceHolderAttributed;
@property (nonatomic, assign) NSTextAlignment tfAlignment;

/// 默认15
@property (assign, nonatomic) CGFloat tfStyle_Right;

/// 一个title3，一个输入框
@property (strong, nonatomic) CKJInputTitleStyle *haveTitleStyle;


@end



NS_ASSUME_NONNULL_END
