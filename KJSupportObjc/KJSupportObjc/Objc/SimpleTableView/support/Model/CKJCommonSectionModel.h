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

/*

 CKJCommonSectionModel *section1 = [CKJCommonSectionModel sectionWithDetail:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
     
     _sec.modelArray = @[model1, model2, model3, model4];
 }];
 
 self.simpleTableView.dataArr = @[section1];
 
 
 */
@interface CKJCommonSectionModel : CKJSimpleBaseModel



/// 分区index(在全部分区数组里的index)
- (NSInteger)sectionIndex_InAllSecionModels;

- (CKJSimpleTableView *)simpleTableView;

/// 标识, 每一个SectionModel的sectionModel_id 一定不能相同
@property (copy, nonatomic, nullable) NSString *sectionModel_id;


/// 行高，依次看cell.cellHeight，section.rowHeight，style.rowHeight的值，如果都为nil，最后自适应高度，0也表示自适应
@property (copy, nonatomic, nullable) NSNumber *rowHeight;

/// 区头高度，依次看section.headerHeight，style.sectionHeaderHeight的值，如果都为nil，最后自适应高度
@property (copy, nonatomic, nullable) NSNumber *headerHeight;

/// 区尾高度，依次看section.footerHeight，style.sectionFooterHeight的值，如果都为nil，最后自适应高度 ( 默认最后一个分区的区尾高度为0，如果想要改变默认行为，在设置完dataArr后，再次找到最后一个分区设置区尾相关数据)
@property (copy, nonatomic, nullable) NSNumber *footerHeight;


/// 分割线edge
@property (strong, nonatomic, nullable) NSValue *lineEdge;


@property (strong, nonatomic) __kindof CKJCommonHeaderFooterModel *headerModel;
@property (strong, nonatomic) __kindof CKJCommonHeaderFooterModel *footerModel;


/// 所有的CellModel，包括隐藏的
@property (strong, nonatomic, nullable) NSArray <__kindof CKJCommonCellModel *>*modelArray;

/// 显示的CellModel，不包括隐藏的
@property (strong, nonatomic, nullable) NSArray <__kindof CKJCommonCellModel *>*displayModels;


+ (instancetype)sectionWithHeaderHeight:(NSNumber *_Nullable)headerHeight detailSetting:(CKJSectionBlock _Nullable)detailSetting;
+ (instancetype)sectionWithFooterHeight:(NSNumber *_Nullable)footerHeight detailSetting:(CKJSectionBlock _Nullable)detailSetting;
+ (instancetype)sectionWithHeaderHeight:(NSNumber *_Nullable)headerHeight footerHeight:(NSNumber *_Nullable)footerHeight detailSetting:(CKJSectionBlock _Nullable)detailSetting;


+ (instancetype)sectionWithDetail:(CKJSectionBlock _Nullable)detailSetting;


/// 头 NSAttributedString
+ (instancetype)sectionWithHeaderAttString:(nullable id)headerAttString headerAlignment:(NSTextAlignment)headerAlignment detailSetting:(CKJSectionBlock _Nullable)detailSetting;
/// 尾 NSAttributedString
+ (instancetype)sectionWithFooterAttString:(nullable id)footerAttString footerAlignment:(NSTextAlignment)footerAlignment  detailSetting:(CKJSectionBlock _Nullable)detailSetting;
/// 头尾 NSAttributedString
+ (instancetype)sectionWithHeaderAttString:(nullable id)headerAttString headerAlignment:(NSTextAlignment)headerAlignment footerAttString:(nullable id)footerAttString footerAlignment:(NSTextAlignment)footerAlignment detailSetting:(CKJSectionBlock _Nullable)detailSetting;

- (void)addCellModel:(__kindof CKJCommonCellModel *_Nullable)cellModel;
- (void)addCellModels:(NSArray <__kindof CKJCommonCellModel *>*_Nullable)cellModels;

/**
 带_private开头的是私有的方法，开发者不要私自调用使用
 */
- (void)_privateMethodWithSimpleTableView:(CKJSimpleTableView *)simpleTableView;


@end

NS_ASSUME_NONNULL_END
