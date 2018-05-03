//
//  CommonCollectionViewSectionModel.m
//  RAC空项目
//
//  Created by chenkaijie on 2018/1/18.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CommonCollectionViewSectionModel.h"

@implementation CommonCollectionViewSectionModel


- (nonnull instancetype)initWithHeaderModel:(nullable CommonCollectionReusableViewModel *)headerModel footerModel:(nullable CommonCollectionReusableViewModel *)footerModel modelArray:(NSArray <CommonCollectionViewCellModel *>*_Nullable)modelArray edgeInsets:(UIEdgeInsets)edgeInsets headerSize:(CGSize)headerSize footerSize:(CGSize)footerSize {
    if (self = [super init]) {
        _headerModel = headerModel;
        _footerModel = footerModel;
        _modelArray = modelArray;
        _edgeInsets = edgeInsets;
        _headerSize = headerSize;
        _footerSize = footerSize;
    }
    return self;
}

- (nonnull instancetype)initWithHeaderModel:(nullable CommonCollectionReusableViewModel *)headerModel  modelArray:(NSArray <CommonCollectionViewCellModel *>*_Nullable)modelArray edgeInsets:(UIEdgeInsets)edgeInsets headerSize:(CGSize)headerSize {
    return [self initWithHeaderModel:headerModel footerModel:nil modelArray:modelArray edgeInsets:edgeInsets headerSize:headerSize footerSize:CGSizeZero];
}

- (nonnull instancetype)initWithHeaderModel:(nullable CommonCollectionReusableViewModel *)headerModel  edgeInsets:(UIEdgeInsets)edgeInsets headerSize:(CGSize)headerSize {
    return [self initWithHeaderModel:headerModel footerModel:nil modelArray:nil edgeInsets:edgeInsets headerSize:headerSize footerSize:CGSizeZero];
}


@end
