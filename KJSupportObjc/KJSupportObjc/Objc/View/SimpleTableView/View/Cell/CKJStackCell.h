//
//  CKJStackCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/14.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJCommonTableViewCell.h"
#import "CKJBaseFunctionCell.h"

NS_ASSUME_NONNULL_BEGIN

@class CKJStackCell, CKJSquare1SystemModel, CKJStackCellModel, CKJStackItemHandleModel;

typedef void(^CKJStackCellModelRowBlock)(__kindof CKJStackCellModel *_Nonnull m);


@protocol CKJStackCellDelegate <NSObject>

@required;
- (NSArray <__kindof UIView *>*)createItemViewForCKJStackCell:(__kindof CKJStackCell *_Nonnull __weak)cell;
- (void)updateUIWithItemHandle:(__kindof CKJStackItemHandleModel *_Nonnull)handle index:(NSInteger)index view:(__kindof UIView *_Nonnull)view;

@end




/**
 每个Item数据模型
 */
@interface CKJStackItemHandleModel : CKJBaseModel
@end




@interface CKJStackCellConfig : CKJCommonCellConfig


/**
 唯一的UIStackView的edge
 */
@property (assign, nonatomic) UIEdgeInsets edge;

/**
 水平StackView，Item之间的间距
 */
@property (assign, nonatomic) CGFloat h_itemSpacing;



/**
 如果使用的是CKJEsayCell，请给这个数据源设置为CKJSquare1SystemModel对象，弱指针请注意
 */
@property (weak, nonatomic) id <CKJStackCellDelegate>delegate;



@end


@interface CKJStackCellModel : CKJCommonCellModel

@property (strong, nonatomic) NSArray <__kindof CKJStackItemHandleModel *>*data;

+ (nonnull instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJStackCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJStackCellModelRowBlock)didSelectRowBlock;


@end


@interface CKJStackCell : CKJCommonTableViewCell<CKJStackCellModel *>

@end


NS_ASSUME_NONNULL_END
