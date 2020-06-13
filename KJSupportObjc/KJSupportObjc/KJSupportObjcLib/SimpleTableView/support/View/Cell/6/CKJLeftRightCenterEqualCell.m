//
//  CKJLeftRightCenterEqualCell.m
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/10/26.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJLeftRightCenterEqualCell.h"

@implementation CKJLeftRightCenterEqual_LeftLabelSetting


+ (instancetype)settingWithLeftMargin:(nullable NSNumber *)leftMargin detail:(void(^_Nullable)(CKJLeftRightCenterEqual_LeftLabelSetting *setting))detail {
    CKJLeftRightCenterEqual_LeftLabelSetting *temp = [[CKJLeftRightCenterEqual_LeftLabelSetting alloc] init];
    temp.leftLab_MarginTo_SuperViewLeft = leftMargin;
    if (detail) {
        detail(temp);
    }
    return temp;
}

@end

@implementation CKJLeftRightCenterEqual_RightLabelSetting

+ (instancetype)settingWithRightMargin:(nullable NSNumber *)rightMargin {
    CKJLeftRightCenterEqual_RightLabelSetting *setting = [[self alloc] init];
    setting.rightLab_MarginTo_SuperViewRight = rightMargin;
    return setting;
}

@end

@implementation CKJLeftRightCenterEqualCellModel

+ (NSMutableArray <CKJLeftRightCenterEqualCellModel *>*)centerEqualWithdics:(NSArray <NSDictionary <NSString *, id> *>*)dics detail:(void(^)(CKJLeftRightCenterEqualCellModel *m))detail {
    return (NSMutableArray <CKJLeftRightCenterEqualCellModel *>*)[super lrWithdics:dics detail:detail];
}

- (instancetype)init {
    if (self = [super init]) {
        self.leftLabelSetting = [[CKJLeftRightCenterEqual_LeftLabelSetting alloc] init];
        self.rightLabelSetting = [[CKJLeftRightCenterEqual_RightLabelSetting alloc] init];
    }
    return self;
}

@end


@implementation CKJLeftRightCenterEqualCell

- (void)setupData:(CKJLeftRightCenterEqualCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    [super setupData:model section:section row:row selectIndexPath:indexPath tableView:tableView];
    CKJLeftRightCenterEqual_LeftLabelSetting *leftSetting = (CKJLeftRightCenterEqual_LeftLabelSetting *)model.leftLabelSetting;
    CKJLeftRightCenterEqual_RightLabelSetting *rightSetting = (CKJLeftRightCenterEqual_RightLabelSetting *)model.rightLabelSetting;
    

    /** leftLab 的宽度，自适应左边宽度（nil或者0）可以不设置，那么会自适应左边宽度 */
    NSNumber *leftLab_width = leftSetting.leftLab_width;

    /** leftLab 的宽度相对于父视图的倍数 */
    NSNumber *leftLab_width_MultipliedBySuperView = leftSetting.leftLab_width_MultipliedBySuperView;


    /** leftLab 和 父视图左边 之间的距离 */
    CGFloat leftLab_MarginTo_SuperViewLeft = leftSetting.leftLab_MarginTo_SuperViewLeft.floatValue;
    
    /** leftLab 和 rightLab之间的距离 */
    CGFloat centerMargin = leftSetting.centerMargin.floatValue;
    
    
    [self.leftLab kjwd_mas_remakeConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
        make.left.equalTo(superview).offset(leftLab_MarginTo_SuperViewLeft);
        make.centerY.equalTo(superview);
        
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
    
    [self.rightLab kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.centerY.equalTo(self.leftLab);
        make.left.equalTo(self.leftLab.mas_right).offset(centerMargin);
        make.right.equalTo(superview).offset(-(rightLab_MarginTo_SuperViewRight));
    }];
}

@end


