//
//  CKJImageRightCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/7/8.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJImageRightCell.h"


@implementation CKJImageRightCellConfig

@end


@implementation CKJImageRightCellModel

+ (nonnull instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJImageRightCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJImageRightCellModelRowBlock)didSelectRowBlock {
    return [super modelWithCellHeight:cellHeight cellModel_id:cellModel_id detailSettingBlock:detailSettingBlock didSelectRowBlock:didSelectRowBlock];
}


@end


@implementation CKJImageRightCell


- (void)setupSubViews {
    [super setupSubViews];
    
    CKJImageRightCellConfig *config = self.configModel;
    
    CGSize imageSize = config.imageSize;
    CGFloat imageVleftMargin = config.superView_margin_imageView;
    UIEdgeInsets fiveLabelViewEdge = config.fiveLabelViewEdge;
    
    UIImageView *imageV = self.imageV;
    
    [self.fiveLabelView kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(superview).offset(fiveLabelViewEdge.left);
        make.top.equalTo(superview).offset(fiveLabelViewEdge.top);
        make.bottom.equalTo(superview).offset(-(fiveLabelViewEdge.bottom));
        make.right.equalTo(imageV.mas_left).offset(-(fiveLabelViewEdge.right));
    }];
    
    
    [imageV kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.centerY.equalTo(superview);
        make.right.equalTo(superview).offset(-(imageVleftMargin));
        make.width.equalTo(@(imageSize.width));
        make.height.equalTo(@(imageSize.height));
    }];
    
}


@end
