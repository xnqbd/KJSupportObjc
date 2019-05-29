//
//  CKJSquareCell2.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/27.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJStackCell.h"

NS_ASSUME_NONNULL_BEGIN


@class CKJSquareCell2Model;

typedef void(^CKJSquareCell2RowBlock)(__kindof CKJSquareCell2Model *_Nonnull m);




// CKJ系统提供的Item为UIButton的类，并且自动实现了CKJStackCellDataSource
@interface CKJSquare2SystemModel : CKJBaseModel <CKJStackCellDelegate>


/**
 一行显示多少个Item
 */
@property (assign, nonatomic) NSUInteger numberOfItemsInSingleLine;


+ (__kindof CKJSquare2SystemModel *)square2WithNumberOfItemsInSingleLine:(NSUInteger)number;

@end





typedef void(^CKJSquare2FuncBlock)(void);

@interface CKJSquare2StyleModel : CKJBaseModel

@property (assign, nonatomic) BOOL styleEnable;

@property (copy, nonatomic) NSAttributedString *title;

@property (strong, nonatomic) UIImage *bgImage;

/**
 点击的时候调用
 */
@property (copy, nonatomic, nullable) CKJSquare2FuncBlock func;


@end


@interface CKJSquare2FuncModel : CKJStackItemHandleModel

@property (strong, nonatomic) CKJSquare2StyleModel *normalStyle;
@property (strong, nonatomic) CKJSquare2StyleModel *selectStyle;


+ (nonnull instancetype)modelWithTitle:(NSAttributedString *)title bgImage:(UIImage *)bgImage func:(CKJSquare2FuncBlock)func;


+ (nonnull instancetype)modelWithStyle:(void(^)(__weak CKJSquare2StyleModel *normalStyle, __weak CKJSquare2StyleModel *selectStyle))style;

@end



@interface CKJSquareCell2Config : CKJStackCellConfig

// 强指针 和 id <CKJStackCellDataSource>dataSource;
@property (strong, nonatomic) CKJSquare2SystemModel *esaySystemModel;

- (__kindof CKJSquare2SystemModel *)squareWithNumberOfItemsInSingleLine:(NSUInteger)number;

@end


@interface CKJSquareCell2Model : CKJStackCellModel


+ (nonnull instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJSquareCell2RowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJSquareCell2RowBlock)didSelectRowBlock;


@end


@interface CKJSquareCell2 : CKJStackCell

@end

NS_ASSUME_NONNULL_END
