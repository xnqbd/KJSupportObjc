//
//  CKJStackCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/14.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJCommonTableViewCell.h"


NS_ASSUME_NONNULL_BEGIN

@class CKJStackCell, CKJBaseBtnsCellSystemDelegate, CKJStackCellModel;

typedef void(^CKJStackCellModelRowBlock)(__kindof CKJStackCellModel *_Nonnull m);


@protocol CKJStackCellDelegate <NSObject>

@required;

/** 在CKJStackCell 创建ItemView视图 */
- (NSArray <__kindof UIView *>*)createItemViewForCKJStackCell:(__kindof CKJStackCell *_Nonnull __weak)cell;
/** 更新ItemView视图 数据 */
- (void)updateStackItemView:(__kindof UIView *_Nonnull)view itemData:(id _Nonnull)itemData index:(NSInteger)index;

@end


@interface CKJStackCellConfig : CKJCommonCellConfig

/**
 水平StackView，Item之间的间距
 */
@property (assign, nonatomic) CGFloat h_itemSpacing;



/**
 如果使用的是CKJBtnsCell
 请给这个数据源设置为CKJBtnsCellSystemDelegate对象，弱指针请注意
 */
@property (weak, nonatomic) id <CKJStackCellDelegate>delegate;


/**
 分割View的高度
 */
@property (copy, nonatomic, nullable) NSNumber *separatorViewHeight;
/**
 分割View 高度相对于StackView的倍数，默认0（0~1）
 */
@property (copy, nonatomic, nullable) NSNumber *multiHeightByStackView;
/**
 分割View颜色，有默认值，[UIColor kjwd_r:230 g:230 b:230 alpha:1]
 */
@property (strong, nonatomic, nullable) UIColor *separatorViewColor;

@property (copy, nonatomic, nullable) void (^detailSettingStackView_superView)(UIView *_Nonnull stackView_superView);


@end


@interface CKJStackCellModel : CKJCommonCellModel


/// 下面4个属性是 唯一的UIStackView的edge
@property (strong, nonatomic, nullable) NSNumber *stackView_leftMargin;
@property (strong, nonatomic, nullable) NSNumber *stackView_rightMargin;
@property (strong, nonatomic, nullable) NSNumber *stackView_topMargin;
@property (strong, nonatomic, nullable) NSNumber *stackView_bottomMargin;



@property (strong, nonatomic) NSArray *stackItems;

- (void)addItem:(id _Nullable)item;

+ (nonnull instancetype)stackWithCellHeight:(nullable NSNumber *)cellHeight cellModel_id:(nullable NSString *)cellModel_id detailSettingBlock:(nullable CKJStackCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJStackCellModelRowBlock)didSelectRowBlock;

@end


@interface CKJStackCell : CKJCommonTableViewCell //<CKJStackCellModel *>

@end


NS_ASSUME_NONNULL_END
