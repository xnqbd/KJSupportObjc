//
//  CKJBaseImageLeftRightCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/7/8.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseImageLeftRightCell.h"
#import <objc/message.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIView+CKJDesingable.h"

@implementation CKJImageViewConfig

- (instancetype)init {
    if (self = [super init]) {
        self.img_contentMode = UIViewContentModeScaleAspectFill;
        self.img_cornerRadius = 0;
    }
    return self;
}

@end


@implementation CKJBaseImageLeftRightCellConfig

- (instancetype)init {
    if (self = [super init]) {
        self.fiveLabelViewEdge = UIEdgeInsetsMake(10, 12, 10, 12);
        self.superView_margin_imageView = 12;
        self.fiveConfig = [CKJFiveLabelViewConfig new];
        self.imgConfig = [CKJImageViewConfig new];
    }
    return self;
}
- (void)updateFiveConfig:(void(^)(CKJFiveLabelViewConfig *_Nonnull fc))block {
    if (block) {
        block(self.fiveConfig);
    }
}
- (void)updateImgConfig:(void(^)(CKJImageViewConfig *_Nonnull c))block {
    if (block) {
        block(self.imgConfig);
    }
}


@end

@implementation CKJBaseImageLeftRightCellModel

- (void)updateFiveData:(void (^)(CKJFiveLabelModel * _Nonnull))block {
    if (block) {
        block(self.fiveModel);
    }
}

- (instancetype)init {
    if (self = [super init]) {
        self.fiveModel = [CKJFiveLabelModel new];
    }
    return self;
}



@end

@implementation CKJBaseImageLeftRightCell


- (void)setupData:(CKJBaseImageLeftRightCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    if ([model isKindOfClass:[CKJBaseImageLeftRightCellModel class]] == NO) return;
    
    CKJFiveLabelView *fiveView = self.fiveLabelView;
    CKJFiveLabelModel *fiveModel = model.fiveModel;
    
    [fiveView updateUIWithData:fiveModel];
    
    UIImage *imageName = model.b_ImageName;
    NSString *image_URL = model.b_Image_URL;

    if (WDKJ_IsNullObj(imageName, [UIImage class])) {
        NSURL *url = [NSURL kjwd_URLWithString:image_URL];
        [self.imageV sd_setImageWithURL:url placeholderImage:model.b_placeholderImage];
    } else {
        self.imageV.image = imageName;
    }
}


- (void)setupSubViews {
    
    CKJBaseImageLeftRightCellConfig *config = self.configModel;
    
    
    UIView *bgV = self.subviews_SuperView;
    
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.contentMode = config.imgConfig.img_contentMode;
    imageV.kBorderColor = config.imgConfig.img_borderColor;
    imageV.kBorderWidth = config.imgConfig.img_borderWidth;
    imageV.kCornerRadius = config.imgConfig.img_cornerRadius;
    [bgV addSubview:imageV];
    self.imageV = imageV;
    
    
    CKJFiveLabelView *fiveView = [[CKJFiveLabelView alloc] initWithFrame:CGRectZero config:config.fiveConfig];
    [bgV addSubview:fiveView];
    self.fiveLabelView = fiveView;
}


@end
