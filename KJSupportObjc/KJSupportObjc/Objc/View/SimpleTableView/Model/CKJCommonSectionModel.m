//
//  CommonSectionModel.m
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/21.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import "CKJCommonSectionModel.h"
#import "CKJTableViewHeaderFooterEmptyView.h"

@implementation CKJCommonSectionModel

+ (instancetype)sectionWithCellModelArray:(nullable NSArray <CKJCommonCellModel *>*)modelArray {
    CKJCommonSectionModel *model = [[self alloc] init];
    model.modelArray = modelArray;
    return model;
}

- (instancetype)init {
    if (self = [super init]) {
        self.headerModel = [[CKJTableViewHeaderFooterEmptyModel alloc] init];
        self.footerModel = [[CKJTableViewHeaderFooterEmptyModel alloc] init];
    }
    return self;
}

@end
