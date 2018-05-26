//
//  CommonSectionModel.h
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/21.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CommonHeaderFooterModel, CommonTableViewCellModel;

@interface CommonSectionModel : NSObject

@property (assign, nonatomic) CGFloat headerHeight;
@property (strong, nonatomic) CommonHeaderFooterModel *headerModel;

@property (assign, nonatomic) CGFloat footerHeight;
@property (strong, nonatomic) CommonHeaderFooterModel *footerModel;

/**  这里面可能有各种类型的model */
@property (strong, nonatomic) NSArray <CommonTableViewCellModel *>*modelArray;


+ (instancetype)sectionWithModelArray:(NSArray <CommonTableViewCellModel *>*)modelArray;

@end
