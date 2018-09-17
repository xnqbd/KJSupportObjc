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

+ (instancetype)sectionWithModelArray:(NSArray <CKJCommonCellModel *>*)modelArray {
    CKJCommonSectionModel *model = [CKJCommonSectionModel new];
    model.modelArray = modelArray;
    return model;
}

- (instancetype)init {
    if (self = [super init]) {
        self.headerModel = [CKJTableViewHeaderFooterEmptyModel new];
        self.footerModel = [CKJTableViewHeaderFooterEmptyModel new];
    }
    return self;
}

@end
