//
//  CKJCommonTableViewHeaderFooterView.m
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/21.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import "CKJCommonTableViewHeaderFooterView.h"
#import "CKJCommonHeaderFooterModel.h"
#import "CKJSimpleTableView.h"
#import "CKJTitleStyleHeaderFooterView.h"

@interface CKJCommonTableViewHeaderFooterView()

//@property (nonatomic, weak) CKJSimpleTableView *simpleTableView;

@end


@implementation CKJCommonTableViewHeaderFooterView

//- (nonnull instancetype)initWithReuseIdentifier:(nonnull NSString *)reuseIdentifier tableView:(nonnull CKJSimpleTableView *)tableView {
//    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
//        self.simpleTableView = tableView;
//        if ([self isKindOfClass:CKJTitleStyleHeaderFooterView.class]) {
//            ((CKJTitleStyleHeaderFooterView *)self).delegate = tableView.titleStyleHeaderFooterViewDelegate;
//        }
//        [self setupSubViews];
//    }
//    return self;
//}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupSubViews];
        // 如果在滑动中会有创建HeaderFooterView的情况，可能是SectionModel.headerHeight = 0.01 设置过小
    }
    return self;
}


- (void)setupSubViews {
//    NSLog(@"%@ ", @"创建区头、区尾视图");
}

- (void)setupData:(CKJCommonHeaderFooterModel *)headerFooterModel section:(NSInteger)section tableView:(CKJSimpleTableView *)tableView {
}

//- (CKJSimpleTableView *)simpleTableView {
//    return _simpleTableView;
//}


@end
