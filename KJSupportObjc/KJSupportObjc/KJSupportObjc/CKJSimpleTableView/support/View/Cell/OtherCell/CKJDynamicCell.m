//
//  CKJRePaintCell.m
//  DYCity
//
//  Created by admin2 on 2020/10/25.
//

#import "CKJDynamicCell.h"


@implementation CKJDynamicCellModel

+ (instancetype)dynamicCellModelWithEdge:(nullable NSValue *)edge refreshUI:(CKJDynamicCellRefreshUI)refreshUI detail:(nullable CKJDynamicCellBlock)detail {
    return [self commonWithCellHeight:nil cellModel_id:nil detailSettingBlock:^(__kindof CKJDynamicCellModel * _Nonnull m) {
        if (edge) {
            m.edge = edge.UIEdgeInsetsValue;
        }
        m.refreshUI = refreshUI;
        if (detail) {
            detail(m);
        }
    } didSelectRowBlock:nil];
}

@end


@interface CKJDynamicCell ()

@property (strong, nonatomic) UIView *wrapper;

@end

@implementation CKJDynamicCell

- (void)setupData:(__kindof CKJDynamicCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {

    NSArray <UIView *>*subviews = self.wrapper.subviews;
    
    for (int i = 0; i < subviews.count; i++) {
        UIView *view = subviews[i];
        [view removeFromSuperview];
    }
    
    if (model.refreshUI) {
        [self.wrapper kjwd_mas_updateConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
            make.edges.equalTo(superview).insets(model.edge);
        }];
        model.refreshUI(_wrapper, model);
    }
}

- (void)setupSubViews {
    UIView *wrapper = [[UIView alloc] init];
    [wrapper kjwd_masWithSuperView:self.subviews_SuperView makeConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
        make.edges.equalTo(superview).insets(UIEdgeInsetsZero);
    }];
    self.wrapper = wrapper;
}



@end
