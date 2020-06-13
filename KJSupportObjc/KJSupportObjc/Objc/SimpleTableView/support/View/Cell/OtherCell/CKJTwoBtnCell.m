//
//  CKJTwoBtnCell.m
//  Demo
//
//  Created by admin2 on 2020/3/10.
//  Copyright © 2020 admin2. All rights reserved.
//

#import "CKJTwoBtnCell.h"


@implementation CKJTwoBtnCellModel



+ (instancetype)twoBtnWithCellHeight:(nullable NSNumber *)cellHeight leftTitle:(nullable NSString *)leftTitle leftHandle:(nullable CKJBtnClick)leftHandle rightTitle:(nullable NSString *)rightTitle rightHandle:(nullable CKJBtnClick)rightHandle fontSize:(nullable NSNumber *)fontSize textColor:(nullable UIColor *)textColor detail:(nullable CKJTwoBtnCellBlock)detail {

    if (WDKJ_IsNull_Num(fontSize)) {
        fontSize = @14;
    }
    if (WDKJ_IsNullObj(textColor, [UIColor class])) {
        textColor = [UIColor kjwd_subTitle];
    }
    
    CKJBtnItemData *left = [[CKJBtnItemData alloc] init];
    left.normalAttTitle = WDCKJAttributed2(leftTitle, textColor, fontSize);
    left.click_Button = leftHandle;
    
    CKJBtnItemData *right = [[CKJBtnItemData alloc] init];
    right.normalAttTitle =  WDCKJAttributed2(rightTitle, textColor, fontSize);
    right.click_Button = rightHandle;
    
    CKJTwoBtnCellModel *m = [self commonWithCellHeight:cellHeight cellModel_id:nil detailSettingBlock:nil didSelectRowBlock:nil];
    m.leftBtnData = left;
    m.rightBtnData = right;
    
    if (detail) {
        detail(m);
    }
    return m;
}


@end

@implementation CKJTwoBtnCell

- (void)setupSubViews {
    __weak typeof(self) weakSelf = self;
    
    self.leftBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn kjwd_addTouchUpInsideForCallBack:^(UIButton * _Nonnull _sender) {
            CKJTwoBtnCellModel *cm = weakSelf.cellModel;
            if (cm.leftBtnData.click_Button) {
                cm.leftBtnData.click_Button(_sender, cm.leftBtnData);
            }
        }];
        [btn kjwd_masWithSuperView:self.subviews_SuperView makeConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
            make.centerY.equalTo(superview);
            make.left.equalTo(superview).offset(0);
        }];
        btn;
    });
    
    self.rightBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn kjwd_addTouchUpInsideForCallBack:^(UIButton * _Nonnull _sender) {
            CKJTwoBtnCellModel *cm = weakSelf.cellModel;
            if (cm.rightBtnData.click_Button) {
                cm.rightBtnData.click_Button(_sender, cm.rightBtnData);
            }
        }];
        [btn kjwd_masWithSuperView:self.subviews_SuperView makeConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
            make.centerY.equalTo(self.leftBtn);
            make.right.equalTo(superview).offset(0);
        }];
        btn;
    });
}

- (void)setupData:(__kindof CKJTwoBtnCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    [CKJWorker reloadBtn:self.leftBtn btnData:model.leftBtnData];
    [self.leftBtn kjwd_mas_updateConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
        make.left.equalTo(superview).offset(model.leftMargin);
    }];
    
    [CKJWorker reloadBtn:self.rightBtn btnData:model.rightBtnData];
    [self.rightBtn kjwd_mas_updateConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
        make.right.equalTo(superview).offset(-(model.rightMargin));
    }];
    
    
    
}


@end
