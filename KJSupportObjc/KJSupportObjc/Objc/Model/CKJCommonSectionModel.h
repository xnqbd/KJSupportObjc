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
 标识, 每一个SectionModel的id_flag 一定不能相同
 */
@property (assign, nonatomic) NSInteger id_flag;


/**
 当前分区
 */
@property (assign, nonatomic, readonly) NSInteger currentSection;

@property (assign, nonatomic) CGFloat rowHeight;

@property (assign, nonatomic) CGFloat headerHeight;
@property (strong, nonatomic) CKJCommonHeaderFooterModel *headerModel;

@property (assign, nonatomic) CGFloat footerHeight;
@property (strong, nonatomic) CKJCommonHeaderFooterModel *footerModel;

/**  这里面可能有各种类型的model */
@property (strong, nonatomic) NSArray <CKJCommonCellModel *>*modelArray;


+ (instancetype)sectionWithModelArray:(NSArray <CKJCommonCellModel *>*)modelArray;



@end
