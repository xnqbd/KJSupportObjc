//
//  CKJCommonSectionModel.h
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/21.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKJBaseModel.h"

@class CKJCommonHeaderFooterModel, CKJCommonCellModel, CKJSimpleTableView;

@interface CKJCommonSectionModel : CKJBaseModel


/**
 分区index(在全部分区数组里的index)
 */
- (NSInteger)sectionIndex_InAllSecionModels;
- (nonnull CKJSimpleTableView *)simpleTableView;

/**
 标识, 每一个SectionModel的sectionModel_id 一定不能相同
 */
@property (assign, nonatomic) NSInteger sectionModel_id;

@property (assign, nonatomic) CGFloat rowHeight;

@property (assign, nonatomic) CGFloat headerHeight;
@property (assign, nonatomic) CGFloat footerHeight;

@property (strong, nonatomic, nonnull) __kindof CKJCommonHeaderFooterModel *headerModel;
@property (strong, nonatomic, nonnull) __kindof CKJCommonHeaderFooterModel *footerModel;

/**  所有的CellModel */
@property (strong, nonatomic, nonnull) NSArray <__kindof CKJCommonCellModel *>*modelArray;
/**  显示的CellModel */
@property (strong, nonatomic, nonnull) NSArray <__kindof CKJCommonCellModel *>*displayModels;

+ (nonnull instancetype)sectionWithCellModelArray:(NSArray <CKJCommonCellModel *>*_Nullable)modelArray;


- (void)addCellModel:(__kindof CKJCommonCellModel *_Nullable)cellModel;

/**
 带_private开头的是私有的方法，开发者不要私自调用使用
 */
- (void)_privateMethodWithSimpleTableView:(CKJSimpleTableView *_Nonnull)simpleTableView;


@end
