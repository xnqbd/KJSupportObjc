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
 这个extensionData可以作为一个延展数据
 */
@property (strong, nonatomic, nullable) id extensionData;

+ (nonnull instancetype)sectionWithCellModelArray:(nullable NSArray <CKJCommonCellModel *>*)modelArray;



@end
