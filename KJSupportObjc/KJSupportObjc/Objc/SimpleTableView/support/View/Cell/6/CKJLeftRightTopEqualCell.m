//
//  CKJLeftRightTopEqualCell.m
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/10/26.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJLeftRightTopEqualCell.h"

@implementation CKJLeftRightTopEqual_LeftLabelSetting

- (instancetype)init {
    if (self = [super init]) {
        self.leftLabel_TopMarginToSuperView = @6;
    }
    return self;
}

@end

@implementation CKJLeftRightTopEqual_RightLabelSetting

- (instancetype)init {
    if (self = [super init]) {
        self.rightLabel_BottomMarginToSuperView = @6;
    }
    return self;
}

@end


@implementation CKJLeftRightTopEqualCellModel

+ (NSMutableArray <CKJLeftRightTopEqualCellModel *>*)topEqualWithdics:(NSArray <NSDictionary <NSString *, id> *>*)dics detail:(void(^)(CKJLeftRightTopEqualCellModel *m))detail {
    return (NSMutableArray <CKJLeftRightTopEqualCellModel *>*)[super lrWithdics:dics detail:detail];
}

- (void)updateSetting:(void(^_Nullable)(CKJLeftRightTopEqual_LeftLabelSetting *left, CKJLeftRightTopEqual_RightLabelSetting *right))setting {
    if (setting) {
        setting(self.leftLabelSetting, self.rightLabelSetting);
    }
}


- (instancetype)init {
    if (self = [super init]) {
        self.leftLabelSetting = [[CKJLeftRightTopEqual_LeftLabelSetting alloc] init];
        self.rightLabelSetting = [[CKJLeftRightTopEqual_RightLabelSetting alloc] init];
    }
    return self;
}

@end

@implementation CKJLeftRightTopEqualCell

- (void)setupData:(CKJLeftRightTopEqualCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    [super setupData:model section:section row:row selectIndexPath:indexPath tableView:tableView];
    CKJLeftRightTopEqual_LeftLabelSetting *leftSetting = (CKJLeftRightTopEqual_LeftLabelSetting *)model.leftLabelSetting;
    CKJLeftRightTopEqual_RightLabelSetting *rightSetting = (CKJLeftRightTopEqual_RightLabelSetting *)model.rightLabelSetting;
    

    /** leftLab 的宽度，自适应左边宽度（nil或者0）可以不设置，那么会自适应左边宽度 */
    NSNumber *leftLab_width = leftSetting.leftLab_width;

    /** leftLab 的宽度相对于父视图的倍数 */
    NSNumber *leftLab_width_MultipliedBySuperView = leftSetting.leftLab_width_MultipliedBySuperView;


    /** leftLab 和 父视图左边 之间的距离  */
    CGFloat leftLab_MarginTo_SuperViewLeft = leftSetting.leftLab_MarginTo_SuperViewLeft.floatValue;
    
    /** leftLab 和 rightLab之间的距离  */
    CGFloat centerMargin = leftSetting.centerMargin.floatValue;
    
    
    CGFloat leftLabel_TopMarginToSuperView = leftSetting.leftLabel_TopMarginToSuperView.floatValue;
    
    [self.leftLab kjwd_mas_remakeConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
        make.left.equalTo(superview).offset(leftLab_MarginTo_SuperViewLeft);
        make.top.equalTo(superview).offset(leftLabel_TopMarginToSuperView);

        
        if (leftLab_width_MultipliedBySuperView.floatValue > 0) {
            make.width.equalTo(superview).multipliedBy(leftLab_width_MultipliedBySuperView.floatValue);
        } else {
            if (leftLab_width.floatValue > 0) {
                make.width.equalTo(@(leftLab_width.floatValue));
            }
        }
    }];
    
    
    
    /** rightLab 和 父视图右边 之间的距离 */
    CGFloat rightLab_MarginTo_SuperViewRight = rightSetting.rightLab_MarginTo_SuperViewRight.floatValue;

    /** rightLab 距离底部的距离  */
    CGFloat rightLabel_BottomMarginToSuperView = rightSetting.rightLabel_BottomMarginToSuperView.floatValue;

    [self.rightLab kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.top.equalTo(self.leftLab);
        make.left.equalTo(self.leftLab.mas_right).offset(centerMargin);
        make.right.equalTo(superview).offset(-(rightLab_MarginTo_SuperViewRight));
        make.bottom.equalTo(superview).offset(-(rightLabel_BottomMarginToSuperView));
    }];
}

@end
