//
//  CKJCommonCellModel.h
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/7/4.
//  Copyright © 2018年 uback. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKJBaseModel.h"

typedef void(^CKJBlockType1)(void);

@class CKJCommonTableViewCell, CKJCommonCellModel;


typedef void(^CKJCommonCellModelRowBlock)(__kindof CKJCommonCellModel *_Nonnull m);


// sectionProperty_

@interface CKJCommonCellModel : CKJBaseModel

/**
 选中Cell的效果
 */
@property (assign, nonatomic) UITableViewCellSelectionStyle selectionStyle;

/**
 是否显示分割线， 默认显示
 */
@property (assign, nonatomic) BOOL showLine;

/**
 行高, 如果等于0，那么会根据约束自适应高度
 */
@property (assign, nonatomic) CGFloat cellHeight;

/**
 是否选中
 注意：1.如果是用CKJCellModel.CKJBtn8Model，请使用CKJBtn8Model自身的selected
 2.如果是CKJFiveCell，请使用CKJFiveCellModel.chooseBtn_Selected
 */
@property (assign, nonatomic) BOOL selected;

/**
 是否在UITableView里面显示
 */
@property (assign, nonatomic) BOOL displayInTableView;

/**
 标记, 每一个CellModel的cellModel_id 一定不能相同，默认是0，不做标记
 */
@property (assign, nonatomic) NSInteger cellModel_id;


/**
 当前Cell
 */
- (__kindof CKJCommonTableViewCell *_Nonnull)cell;

/**
 这个extensionData可以作为一个延展数据
 场景1: 可以使用这个extensionData属性聚合一个或者多个cellModel (注意：CKJEmptyCellModel除外)
 */
@property (strong, nonatomic, nullable) id extensionData;

/**
 创建该对象

 @param cellHeight 如果为0，则自适应Cell高度
 @param cellModel_id 如果为nil或者为@0，则Cell不作标记, 请NSNumber用NSInteger来包装
 @param detailSettingBlock 详细设置回调
 @param didSelectRowBlock 点击了某一行回调
 @return 实例对象
 */
+ (nonnull instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJCommonCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJCommonCellModelRowBlock)didSelectRowBlock;


@property (copy, nonatomic, nullable) CKJCommonCellModelRowBlock didSelectRowBlock;



/**
 带_private开头的是私有的方法，开发者不要私自调用使用
 */
- (void)_privateMethodWithCell:(nonnull CKJCommonTableViewCell *)cell;


@end
