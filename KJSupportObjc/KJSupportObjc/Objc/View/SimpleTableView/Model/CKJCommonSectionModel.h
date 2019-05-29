//
//  CKJCommonSectionModel.h
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/21.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CKJCommonHeaderFooterModel, CKJCommonCellModel;

@interface CKJCommonSectionModel : NSObject

/**
 当前分区
 */
@property (assign, nonatomic, readonly) NSInteger currentSection;


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

/**
 这个extension_Obj可以作为一个延展数据
 */
@property (strong, nonatomic, nullable) id extension_Obj;

/**
 这个extension_Interger可以作为一个延展数据
 */
@property (assign, nonatomic) NSInteger extension_Interger;



+ (nonnull instancetype)sectionWithCellModelArray:(nullable NSArray <CKJCommonCellModel *>*)modelArray;


/**
 带_private开头的是私有的方法，开发者不要私自调用使用
 */
- (void)_privateMethodWithSection:(NSInteger)section;


@end
