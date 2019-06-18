//
//  CommonSectionModel.m
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/21.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import "CKJCommonSectionModel.h"
#import "CKJTableViewHeaderFooterEmptyView.h"
#import "CKJSimpleTableView.h"

@interface CKJCommonSectionModel ()


@property (weak, nonatomic) CKJSimpleTableView *simpleTableView;


@end

@implementation CKJCommonSectionModel

+ (instancetype)sectionWithCellModelArray:(nullable NSArray <CKJCommonCellModel *>*)modelArray {
    CKJCommonSectionModel *model = [[self alloc] init];
    model.modelArray = modelArray;
    return model;
}



- (instancetype)init {
    if (self = [super init]) {
        self.headerModel = [[CKJTableViewHeaderFooterEmptyModel alloc] init];
//        self.headerHeight = 0.01;
        self.footerModel = [[CKJTableViewHeaderFooterEmptyModel alloc] init];
//        self.footerHeight = 0.01;
    }
    return self;
}

- (void)addCellModel:(__kindof CKJCommonCellModel *)cellModel {
    NSMutableArray *arr = [NSMutableArray kjwd_arrayWithArray:self.modelArray];
    [arr addObject:cellModel];
    self.modelArray = arr;
}


- (void)_privateMethodWithSimpleTableView:(CKJSimpleTableView *)simpleTableView {
    if (self.simpleTableView != simpleTableView) {
        self.simpleTableView = simpleTableView;
    }
}

- (NSInteger)sectionIndex_InAllSecionModels {
    NSArray *dataArr = _simpleTableView.dataArr;
    for (NSInteger i = 0; i < dataArr.count; i++) {
        CKJCommonSectionModel *section = dataArr[i];
        if (section == self) {
            return i;
        }
    }
    return 0;
}

- (nonnull CKJSimpleTableView *)simpleTableView {
    return _simpleTableView;
}


@end
