//
//  CKJCommonSectionModel.h
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/21.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKJSimpleBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class CKJCommonHeaderFooterModel, CKJCommonCellModel, CKJSimpleTableView, CKJCommonSectionModel;

typedef void(^CKJSectionBlock)(__kindof CKJCommonSectionModel * _sec);


@interface CKJCommonSectionModel : CKJSimpleBaseModel


/**
 分区index(在全部分区数组里的index)
 */
- (NSInteger)sectionIndex_InAllSecionModels;
- (CKJSimpleTableView *)simpleTableView;

/**
 标识, 每一个SectionModel的sectionModel_id 一定不能相同
 */
@property (assign, nonatomic) NSInteger sectionModel_id;

@property (assign, nonatomic) CGFloat rowHeight;

@property (assign, nonatomic) CGFloat headerHeight;
@property (assign, nonatomic) CGFloat footerHeight;

@property (strong, nonatomic) __kindof CKJCommonHeaderFooterModel *headerModel;
@property (strong, nonatomic) __kindof CKJCommonHeaderFooterModel *footerModel;

/**  所有的CellModel */
@property (strong, nonatomic, nullable) NSArray <__kindof CKJCommonCellModel *>*modelArray;
/**  显示的CellModel */
@property (strong, nonatomic, nullable) NSArray <__kindof CKJCommonCellModel *>*displayModels;


+ (instancetype)sectionWithHeaderHeight:(CGFloat)headerHeight detailSetting:(CKJSectionBlock _Nullable)detailSetting;
+ (instancetype)sectionWithFooterHeight:(CGFloat)footerHeight detailSetting:(CKJSectionBlock _Nullable)detailSetting;
+ (instancetype)sectionWithHeaderHeight:(CGFloat)headerHeight footerHeight:(CGFloat)footerHeight detailSetting:(CKJSectionBlock _Nullable)detailSetting;


+ (instancetype)sectionWithDetailSetting:(CKJSectionBlock _Nullable)detailSetting;


/// 头 NSAttributedString
+ (instancetype)sectionWithHeaderAttString:(NSAttributedString *_Nullable)headerAttString  detailSetting:(CKJSectionBlock _Nullable)detailSetting;
/// 头尾 NSAttributedString
+ (instancetype)sectionWithHeaderAttString:(NSAttributedString *_Nullable)headerAttString footerAttString:(NSAttributedString *_Nullable)footerAttString detailSetting:(CKJSectionBlock _Nullable)detailSetting;


- (void)addCellModel:(__kindof CKJCommonCellModel *_Nullable)cellModel;
- (void)addCellModels:(NSArray <__kindof CKJCommonCellModel *>*_Nullable)cellModels;

/**
 带_private开头的是私有的方法，开发者不要私自调用使用
 */
- (void)_privateMethodWithSimpleTableView:(CKJSimpleTableView *)simpleTableView;


@end

NS_ASSUME_NONNULL_END
