//
//  CKJCommonCellModel.h
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/7/4.
//  Copyright © 2018年 uback. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKJBaseModel.h"

@class CKJCommonTableViewCell, CKJCommonCellModel;


typedef void(^WDDidSelectRowBlock)(__kindof CKJCommonCellModel *currentModel);

@interface CKJCommonCellModel : CKJBaseModel

@property (assign, nonatomic) UITableViewCellSelectionStyle selectionStyle;

/**
 行高, 如果等于0，那么会根据约束自适应高度
 */
@property (assign, nonatomic) CGFloat cellHeight;

/**
 是否选中
 */
@property (assign, nonatomic) BOOL selected;

/**
 是否在UITableView里面显示
 */
@property (assign, nonatomic) BOOL displayInTableView;

/**
 标识, 每一个CellModel的id_flag 一定不能相同
 */
@property (assign, nonatomic) NSInteger id_flag;

@property (weak, nonatomic) __kindof CKJCommonTableViewCell *cell;



+ (instancetype)modelWithCellHeight:(CGFloat)cellHeight didSelectRowBlock:(nullable WDDidSelectRowBlock)didSelectRowBlock;

@property (copy, nonatomic, nullable) void (^didSelectRowBlock)(__kindof CKJCommonCellModel *currentModel);

@end
