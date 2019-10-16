//
//  CKJLikeQRCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/7/17.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJLikeQRCell.h"


@implementation CKJLikeQRCellConfig

+ (nonnull instancetype)likeQRCellConfigWithImageViewSize:(CGSize)size {
    CKJLikeQRCellConfig *config = [[self alloc] init];
    config.imageViewSize = size;
    return config;
}

@end


@implementation CKJLikeQRCellModel

- (instancetype)init {
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


@end


@implementation CKJLikeQRCell


- (void)setupData:(CKJLikeQRCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    if ([model isKindOfClass:[CKJLikeQRCellModel class]] == NO) return;
    UIImage *image = model.likeQrImage;
    if (WDKJ_IsNullObj(image, [UIImage class])) {
        self.likeQrImageView.image = nil;
    } else {
        self.likeQrImageView.image = image;
    }
}

- (void)setupSubViews {
    CKJLikeQRCellConfig *config = self.configModel;
    
    UIImageView *qrImageView = [[UIImageView alloc] init];
    [self.subviews_SuperView addSubview:qrImageView];
    self.likeQrImageView = qrImageView;
    
    CGFloat width_multiplied = WDKJ_ConfirmNumber(config.width_multipliedBySuperView).floatValue;
    CGFloat height_multiplied = WDKJ_ConfirmNumber(config.width_multipliedBySuperView).floatValue;
    CGSize imageViewSize = config.imageViewSize;
    
    [qrImageView kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.center.equalTo(superview);
        if (width_multiplied > 0) {
            make.width.equalTo(superview).multipliedBy(width_multiplied);
            make.height.equalTo(superview).multipliedBy(height_multiplied);
        } else {
            make.size.mas_equalTo(imageViewSize);
        }
    }];
}

@end
