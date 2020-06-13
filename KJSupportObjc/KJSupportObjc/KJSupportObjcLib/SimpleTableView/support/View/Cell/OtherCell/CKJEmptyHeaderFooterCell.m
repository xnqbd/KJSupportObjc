//
//  CKJEmptyHeaderFooterCell.m
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/11/6.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJEmptyHeaderFooterCell.h"


@implementation CKJEmptyHeaderFooterCellModel

+ (instancetype)emptyHeaderFooterWithCellHeight:(NSNumber *_Nullable)cellHeight  detailSettingBlock:(void(^_Nullable)(CKJEmptyHeaderFooterCellModel *m))detailSettingBlock {
    CKJEmptyHeaderFooterCellModel *model = [[self alloc] init];
    model.cellHeight = @10;
    if (!WDKJ_IsNull_Num(cellHeight)) {
        model.cellHeight = cellHeight;
    }
    if (detailSettingBlock) {
        detailSettingBlock(model);
    }
    return model;
}


- (instancetype)init {
    if (self = [super init]) {
        [self _showLine:NO];
        self.bgConfig.bgColor = [UIColor kjwd_rbg:247 alpha:1];
    }
    return self;
}

@end


@implementation CKJEmptyHeaderFooterCell

- (void)setupData:(__kindof CKJCommonCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
//    self.
}

- (void)setupSubViews {
    
    CGFloat height = 0.33;

    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = [UIColor kjwd_rbg:220 alpha:1];
    
    [topLine kjwd_masWithSuperView:self.subviews_SuperView makeConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
        make.top.left.right.equalTo(superview);
        make.height.equalTo(@(height));
    }];
    
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor kjwd_rbg:220 alpha:1];
    
    [bottomLine kjwd_masWithSuperView:self.subviews_SuperView makeConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
        make.bottom.left.right.equalTo(superview);
        make.height.equalTo(@(height));
    }];
    
}

@end
