//
//  CKJBaseCustomViewCell.m
//  DYCity
//
//  Created by admin2 on 2020/10/23.
//

#import "CKJStaticCell.h"


@implementation CKJBaseStaticCellConfig

+ (instancetype)staticCellConfigWithEdge:(UIEdgeInsets)edge createStaticView:(UIView *(^)(void))createStaticView {
    CKJBaseStaticCellConfig *c = [[CKJBaseStaticCellConfig alloc] init];
    c.edge = edge;
    if (createStaticView) {
        c.staticView = createStaticView();
    }
    return  c;
}

@end


@implementation CKJBaseStaticCellModel

@end


@implementation CKJBaseStaticCell

- (void)setupSubViews {
    
    CKJBaseStaticCellConfig *config = self.configModel;
    
    UIView *bgV = self.subviews_SuperView;
    
    [config.staticView kjwd_masWithSuperView:bgV makeConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
        make.edges.equalTo(superview).insets(config.edge);
    }];
}

@end






@implementation CKJStaticCell1Model

@end


@implementation CKJStaticCell1

@end


@implementation CKJStaticCell2Model

@end


@implementation CKJStaticCell2

@end

