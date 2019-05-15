//
//  CKJBaseFunctionCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/14.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJCommonTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN


@interface CKJFuncModel : CKJBaseModel

@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) UIImage *image;

/**
 点击的时候调用
 */
@property (copy, nonatomic)  void (^func)(UIButton *sender);

+ (nonnull instancetype)modelWithTitle:(NSString *)title image:(UIImage *)image func:(void (^)(UIButton *sender))func;

@end






@interface CKJBaseFunctionCellConfig : CKJCommonCellConfig

@property (copy, nonatomic) NSArray <CKJFuncModel *>*data;


/**
 item之间的距离
 */
@property (assign, nonatomic) CGFloat itemSpace;

/**
 item宽度
 */
@property (assign, nonatomic) CGFloat itemWidth;

/**
 上下左右 距离
 */
@property (assign, nonatomic) UIEdgeInsets edge;



@end

@interface CKJBaseFunctionCellModel : CKJCommonCellModel


@end

@interface CKJBaseFunctionCell : CKJCommonTableViewCell

@end

NS_ASSUME_NONNULL_END
