//
//  CommonCollectionViewSectionModel.h
//  RAC空项目
//
//  Created by chenkaijie on 2018/1/18.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommonCollectionReusableViewModel, CommonCollectionViewCellModel;


@interface CommonCollectionViewSectionModel : NSObject


@property (strong, nonatomic, nullable) CommonCollectionReusableViewModel *headerModel;
@property (strong, nonatomic, nullable) CommonCollectionReusableViewModel *footerModel;

/**  这里面可能有各种类型的model */
@property (strong, nonatomic, nullable) NSArray <CommonCollectionViewCellModel *>*modelArray;

@property (assign, nonatomic) UIEdgeInsets edgeInsets;

@property (assign, nonatomic) CGSize headerSize;
@property (assign, nonatomic) CGSize footerSize;

/**
 *  全部参数(区头，cell，区尾)
 */
- (nonnull instancetype)initWithHeaderModel:(nullable CommonCollectionReusableViewModel *)headerModel footerModel:(nullable CommonCollectionReusableViewModel *)footerModel modelArray:(NSArray <CommonCollectionViewCellModel *>*_Nullable)modelArray edgeInsets:(UIEdgeInsets)edgeInsets headerSize:(CGSize)headerSize footerSize:(CGSize)footerSize;
/**
 *  区头，cell
 */
- (nonnull instancetype)initWithHeaderModel:(nullable CommonCollectionReusableViewModel *)headerModel  modelArray:(NSArray <CommonCollectionViewCellModel *>*_Nullable)modelArray edgeInsets:(UIEdgeInsets)edgeInsets headerSize:(CGSize)headerSize;
/**
 *  仅仅有区头
 */
- (nonnull instancetype)initWithHeaderModel:(nullable CommonCollectionReusableViewModel *)headerModel  edgeInsets:(UIEdgeInsets)edgeInsets headerSize:(CGSize)headerSize;



@end
