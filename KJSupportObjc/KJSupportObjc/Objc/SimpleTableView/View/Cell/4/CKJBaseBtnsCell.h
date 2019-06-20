//
//  CKJEsayCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/26.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJStackCell.h"

NS_ASSUME_NONNULL_BEGIN

@class CKJBaseBtnsCellModel, CKJBaseBtnsCellItemData, CKJBaseBtnsCell;

typedef void(^CKJBaseBtnsCellRowBlock)(CKJBaseBtnsCellModel *_Nonnull m);
typedef void(^CKJBtnsCellItemBlock)(CKJBaseBtnsCellItemData *_Nonnull itemData, __kindof CKJBaseBtnsCell *__weak cell);



// CKJ系统提供的Item为UIButton的类，并且自动实现了CKJStackCellDelegate
@interface CKJBaseBtnsCellSystemDelegate : CKJBaseModel <CKJStackCellDelegate>

/**
 一行显示多少个Item
 */
@property (assign, nonatomic) NSUInteger numberOfItemsInSingleLine;


+ (nonnull instancetype)esayWithNumberOfItemsInSingleLine:(NSUInteger)number;

@end


/**
 这个类和 CKJBtnItemData 属性什么的都是一样的， 如果修改，记得把另外一个类也同步修改一下
 这个类 可以像CKJCell一样直接使用
 */
@interface CKJBaseBtnsCellItemData : CKJStackCellItemData

@property(nonatomic,getter=isEnabled) BOOL enabled;
@property(nonatomic,getter=isSelected) BOOL selected;
@property(nonatomic,getter=isHighlighted) BOOL highlighted;



@property (copy, nonatomic, nullable) NSAttributedString *normalAttTitle;
@property (strong, nonatomic, nullable) UIImage *normalImage;
@property (strong, nonatomic, nullable) UIImage *normalBgImage;

@property (copy, nonatomic, nullable) NSAttributedString *selectedAttTitle;
@property (strong, nonatomic, nullable) UIImage *selectedImage;
@property (strong, nonatomic, nullable) UIImage *selectedBgImage;

@property (copy, nonatomic, nullable) NSAttributedString *highlightedAttTitle;
@property (strong, nonatomic, nullable) UIImage *highlightedImage;
@property (strong, nonatomic, nullable) UIImage *highlightedBgImage;




/** 边框宽度 */
@property (assign, nonatomic) CGFloat borderWidth;
/** 边框颜色 */
@property (strong, nonatomic) UIColor *borderColor;
/** 圆角*/
@property (assign, nonatomic) CGFloat cornerRadius;



@property (copy, nonatomic, nullable) CKJBtnsCellItemBlock callBack_Block;

/**
 对UIButton的图片和文字 进行排布回调
 */
@property (copy, nonatomic, nullable) void (^layoutButton)(UIButton *btn);

/**
 创建多个items对象
 */
+ (NSArray <CKJBaseBtnsCellItemData *>*_Nonnull)returnItemsWithDics:(NSArray <NSDictionary *>*_Nullable)dics detailSetting:(void(^_Nullable)(CKJBaseBtnsCellItemData *__weak _Nonnull itemData, NSUInteger index))detailSetting;

@end


@interface CKJBaseBtnsCellConfig : CKJStackCellConfig

// 强指针 和 id <CKJStackCellDelegate>delegate;
@property (strong, nonatomic) CKJBaseBtnsCellSystemDelegate *esaySystemModel;

- (__kindof CKJBaseBtnsCellSystemDelegate *)squareWithNumberOfItemsInSingleLine:(NSUInteger)number;

@end


@interface CKJBaseBtnsCellModel : CKJStackCellModel


+ (nonnull instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJBaseBtnsCellRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJBaseBtnsCellRowBlock)didSelectRowBlock;

+ (nonnull NSMutableArray <CKJCommonCellModel *>*)modelWithItems:(NSArray <__kindof CKJBaseBtnsCellItemData *>*_Nullable)items numberOfItemsInSingleLine:(NSUInteger)number cellHeight:(CGFloat)cellHeight topMargin:(CGFloat)topMargin centerMargin:(CGFloat)centerMargin bottomMargin:(CGFloat)bottomMargin groupId:(NSString *_Nullable)groupId detailSetting:(void(^_Nullable)(__kindof CKJBaseBtnsCellModel *_Nonnull m, NSUInteger cellModel_index))detailSetting;

@end


/**
 请使用 这个类 的两个子类 CKJBtnsCell1、CKJBtnsCell2
 */
@interface CKJBaseBtnsCell : CKJStackCell

@end

NS_ASSUME_NONNULL_END
