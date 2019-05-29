//
//  CKJEsayCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/26.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJStackCell.h"

NS_ASSUME_NONNULL_BEGIN

@class CKJSquareCell1Model;

typedef void(^CKJSquareCell1RowBlock)(__kindof CKJSquareCell1Model *_Nonnull m);



// CKJ系统提供的Item为UIButton的类，并且自动实现了CKJStackCellDataSource
@interface CKJSquare1SystemModel : CKJBaseModel <CKJStackCellDelegate>


/**
 一行显示多少个Item
 */
@property (assign, nonatomic) NSUInteger numberOfItemsInSingleLine;


+ (nonnull instancetype)esayWithNumberOfItemsInSingleLine:(NSUInteger)number;

@end



typedef void(^CKJSquare1FuncBlock)(void);

@interface CKJSquare1StyleModel : CKJBaseModel

@property (assign, nonatomic) BOOL styleEnable;

@property (copy, nonatomic) NSAttributedString *title;
@property (strong, nonatomic) UIImage *image;


/**
 点击的时候调用
 */
@property (copy, nonatomic, nullable) CKJSquare1FuncBlock func;


@end



@interface CKJSquare1FuncModel : CKJStackItemHandleModel

@property (strong, nonatomic) CKJSquare1StyleModel *style1;
@property (strong, nonatomic) CKJSquare1StyleModel *style2;


+ (nonnull instancetype)modelWithTitle:(NSAttributedString *)title image:(UIImage *)image func:(CKJSquare1FuncBlock)func;


+ (nonnull instancetype)modelWithStyle:(void(^)(__weak CKJSquare1StyleModel *style1, __weak CKJSquare1StyleModel *style2))style;

@end



@interface CKJSquareCell1Config : CKJStackCellConfig

// 强指针 和 id <CKJStackCellDataSource>dataSource;
@property (strong, nonatomic) CKJSquare1SystemModel *esaySystemModel;

- (__kindof CKJSquare1SystemModel *)squareWithNumberOfItemsInSingleLine:(NSUInteger)number;

@end


@interface CKJSquareCell1Model : CKJStackCellModel


+ (nonnull instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJSquareCell1RowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJSquareCell1RowBlock)didSelectRowBlock;


@end


@interface CKJSquareCell1 : CKJStackCell

@end

NS_ASSUME_NONNULL_END
