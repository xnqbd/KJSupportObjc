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


/**
 当前分区
 */
@property (assign, nonatomic, readonly) NSInteger currentSection;

@property (assign, nonatomic) CGFloat rowHeight;

@property (assign, nonatomic) CGFloat headerHeight;
@property (assign, nonatomic) CGFloat footerHeight;

@property (strong, nonatomic) __kindof CKJCommonHeaderFooterModel *headerModel;
@property (strong, nonatomic) __kindof CKJCommonHeaderFooterModel *footerModel;

/**  这里面可能有各种类型的model */
@property (strong, nonatomic) NSArray <__kindof CKJCommonCellModel *>*modelArray;


+ (instancetype)sectionWithCellModelArray:(nullable NSArray <CKJCommonCellModel *>*)modelArray;



@end
