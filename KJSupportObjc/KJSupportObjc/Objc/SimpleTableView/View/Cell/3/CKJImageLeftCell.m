//
//  CKJImageLeftCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/7/8.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJImageLeftCell.h"




@implementation CKJImageLeftCellConfig


@end

@implementation CKJImageLeftCellModel


+ (nonnull instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJImageLeftCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJImageLeftCellModelRowBlock)didSelectRowBlock {
    return [super modelWithCellHeight:cellHeight cellModel_id:cellModel_id detailSettingBlock:detailSettingBlock didSelectRowBlock:didSelectRowBlock];
}


@end

@interface CKJImageLeftCell ()

@property (weak, nonatomic) UIView *rightWrapper;

@end


@implementation CKJImageLeftCell

- (void)setupSubViews {
    [super setupSubViews];
    
    
    
    CKJImageLeftCellConfig *config = self.configModel;
    
    
    // 先创建附件
    UIView *rightWrapper = [[UIView alloc] init];
    [self.onlyView addSubview:rightWrapper];
    self.rightWrapper = rightWrapper;
    
    
    CGSize imageSize = config.imageSize;
    CGFloat imageVleftMargin = config.superView_margin_imageView;
    UIEdgeInsets fiveLabelViewEdge = config.fiveLabelViewEdge;
    
    UIImageView *imageV = self.imageV;
    
    
    [imageV kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.centerY.equalTo(superview);
        make.left.equalTo(superview).offset(imageVleftMargin);
        make.width.equalTo(@(imageSize.width));
        make.height.equalTo(@(imageSize.height));
    }];
    
    [self.fiveLabelView kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(imageV.mas_right).offset(fiveLabelViewEdge.left);
        make.top.equalTo(superview).offset(fiveLabelViewEdge.top);
        make.bottom.equalTo(superview).offset(-(fiveLabelViewEdge.bottom));
        make.right.equalTo(rightWrapper.mas_left).offset(-(fiveLabelViewEdge.right));
    }];
    
    [rightWrapper kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.top.bottom.right.equalTo(superview);
    }];
    
    self.subviews_SuperView = rightWrapper;
}


@end
