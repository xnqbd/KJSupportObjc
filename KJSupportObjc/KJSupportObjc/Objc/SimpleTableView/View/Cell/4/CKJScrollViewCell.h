//
//  CKJBaseFunctionCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/14.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJCommonTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN


@class CKJScrollViewCell, CKJScrollViewCellItemData, CKJScrollViewCellItemView;

//typedef void(^CKJScrollViewCellItemBlock)(__kindof CKJScrollViewCellItemData *_Nonnull itemData, NSUInteger index);



@protocol CKJScrollViewCellDelegate <NSObject>

@required;

/** 这个方法 确定ScrollViewCell上子视图的 个数  */
- (NSArray <__kindof CKJScrollViewCellItemView *>*)createItemViewForCKJScrollViewCell:(__kindof CKJScrollViewCell *_Nonnull __weak)cell;
/** 更新ItemView视图数据 */
- (void)updateItemView:(__kindof UIView *_Nonnull)itemView itemData:(__kindof CKJScrollViewCellItemData *_Nonnull)itemData index:(NSInteger)index;

@end


/**
 这个需要继承于此类 自定义属性，因为这个CKJScrollViewCell 里面的ItemView太多种多样，显示成什么样子的都有，所以ItemData没有办法统一，所以需要自定义
 */
@interface CKJScrollViewCellItemData : CKJCommonItemData

+ (NSArray <__kindof CKJScrollViewCellItemData *>*_Nonnull)scrollViewCellItemsWithDics:(NSArray <NSDictionary *>*_Nullable)dics detailSetting:(void(^_Nullable)(__kindof __weak CKJScrollViewCellItemData *_Nonnull itemData, NSUInteger index))detailSetting;

@end



@interface CKJScrollViewCellItemView : CKJCommonItemView

/**
 当前的itemData
 */
@property (weak, nonatomic, nullable) __kindof CKJScrollViewCellItemData *itemData;

@end




@interface CKJScrollViewCellConfig : CKJCommonCellConfig

@property (weak, nonatomic) id <CKJScrollViewCellDelegate>delegate;

/** item之间的距离 */
@property (assign, nonatomic) CGFloat itemSpace;
/** item宽度 */
@property (assign, nonatomic) CGFloat itemWidth;

@property (assign, nonatomic) UIEdgeInsets items_Edge_ScrollView;
@property (assign, nonatomic) UIEdgeInsets scrollView_Edge_SuperView;



/** 指示器，默认隐藏 */
@property (assign, nonatomic) BOOL showIndicator;

@end

@interface CKJScrollViewCellModel : CKJCommonCellModel


@property (strong, nonatomic) NSArray <__kindof CKJScrollViewCellItemData *>*data;

- (void)addItem:(__kindof CKJScrollViewCellItemData *)item;


@end

@interface CKJScrollViewCell : CKJCommonTableViewCell

@end

NS_ASSUME_NONNULL_END
