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


+ (instancetype)sectionWithHeaderHeight:(CGFloat)headerHeight detailSetting:(CKJSectionBlock _Nullable)detailSetting {
    return [self sectionWithHeaderHeight:headerHeight footerHeight:0 detailSetting:detailSetting];
}

+ (nonnull instancetype)sectionWithFooterHeight:(CGFloat)footerHeight detailSetting:(CKJSectionBlock _Nullable)detailSetting {
    return [self sectionWithHeaderHeight:0 footerHeight:footerHeight detailSetting:detailSetting];
}

+ (nonnull instancetype)sectionWithHeaderHeight:(CGFloat)headerHeight footerHeight:(CGFloat)footerHeight detailSetting:(CKJSectionBlock _Nullable)detailSetting {
    CKJCommonSectionModel *m = [[self alloc] init];
    m.headerHeight = headerHeight;
    m.footerHeight = footerHeight;
    if (detailSetting) {
        detailSetting(m);
    }
    return m;
}





/// 头 NSAttributedString
+ (instancetype)sectionWithHeaderAttString:(NSAttributedString *_Nullable)headerAttString headerAlignment:(NSTextAlignment)headerAlignment detailSetting:(CKJSectionBlock _Nullable)detailSetting {
    CKJCommonSectionModel *m = [[self alloc] init];
    m.headerModel = [CKJTitleStyleHeaderFooterModel modelWithAttributedString:headerAttString textAlignment:headerAlignment type:CKJCommonHeaderFooterType_HEADER];
       if (detailSetting) {
           detailSetting(m);
       }
       return m;
}
/// 尾 NSAttributedString
+ (instancetype)sectionWithFooterAttString:(NSAttributedString *_Nullable)footerAttString footerAlignment:(NSTextAlignment)footerAlignment  detailSetting:(CKJSectionBlock _Nullable)detailSetting {
    CKJCommonSectionModel *m = [[self alloc] init];
       m.footerModel = [CKJTitleStyleHeaderFooterModel modelWithAttributedString:footerAttString textAlignment:footerAlignment type:CKJCommonHeaderFooterType_FOOTER];
       if (detailSetting) {
           detailSetting(m);
       }
       return m;
}
/// 头尾 NSAttributedString
+ (instancetype)sectionWithHeaderAttString:(NSAttributedString *_Nullable)headerAttString headerAlignment:(NSTextAlignment)headerAlignment footerAttString:(NSAttributedString *_Nullable)footerAttString footerAlignment:(NSTextAlignment)footerAlignment detailSetting:(CKJSectionBlock _Nullable)detailSetting {
    CKJCommonSectionModel *m = [[self alloc] init];
       m.headerModel = [CKJTitleStyleHeaderFooterModel modelWithAttributedString:headerAttString textAlignment:headerAlignment type:CKJCommonHeaderFooterType_HEADER];
       m.footerModel = [CKJTitleStyleHeaderFooterModel modelWithAttributedString:footerAttString textAlignment:footerAlignment type:CKJCommonHeaderFooterType_FOOTER];
       if (detailSetting) {
           detailSetting(m);
       }
       return m;
}

+ (nonnull instancetype)sectionWithDetailSetting:(CKJSectionBlock _Nullable)detailSetting {
    CKJCommonSectionModel *m = [[self alloc] init];
    if (detailSetting) {
        detailSetting(m);
    }
    return m;
}

- (void)addCellModel:(__kindof CKJCommonCellModel *)cellModel {
    NSMutableArray *arr = [NSMutableArray kjwd_arrayWithArray:self.modelArray];
    [arr kjwd_addObject:cellModel];
    self.modelArray = arr;
}
- (void)addCellModels:(NSArray <__kindof CKJCommonCellModel *>*_Nullable)cellModels {
    NSMutableArray *arr = [NSMutableArray kjwd_arrayWithArray:self.modelArray];
    [arr kjwd_addObjectsFromArray:cellModels];
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
