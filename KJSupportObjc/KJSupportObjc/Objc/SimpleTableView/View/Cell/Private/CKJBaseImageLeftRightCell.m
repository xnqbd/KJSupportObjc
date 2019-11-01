//
//  CKJBaseImageLeftRightCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/7/8.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseImageLeftRightCell.h"
#import <objc/message.h>

@implementation CKJBaseImageLeftRightCellConfig

- (instancetype)init {
    if (self = [super init]) {
        self.fiveLabelViewEdge = UIEdgeInsetsMake(10, 12, 10, 12);
        self.superView_margin_imageView = 12;
        self.fiveConfig = [CKJFiveLabelViewConfig new];
    }
    return self;
}
- (void)updateFiveConfig:(void(^)(CKJFiveLabelViewConfig *_Nonnull fc))block {
    if (block) {
        block(self.fiveConfig);
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
    
    UIImage *placeholderImage = nil;
    if (WDKJ_IsNullObj(model.b_placeholderImage, [UIImage class])) {
        placeholderImage = nil;
    } else {
        placeholderImage = model.b_placeholderImage;
    }
    
    if (WDKJ_IsNullObj(imageName, [UIImage class])) {
        
        NSURL *url = [NSURL kjwd_URLWithString:image_URL];
        
        NSString *temp1 = @"sd_setImageWithURL:placeholderImage:";
        
        SEL sel = NSSelectorFromString(temp1);
        if ([self.imageV respondsToSelector:sel]) {
            
            void (*kj_sengMsg)(id, SEL, NSURL *, UIImage *) = (void (*)(id, SEL, NSURL *, UIImage *))objc_msgSend;
            
            kj_sengMsg(self.imageV, sel_registerName([temp1 UTF8String]), url, placeholderImage);
            //                [self.imageV sd_setImageWithURL:[NSURL URLWithString:@"https://ps.ssl.qhmsg.com/sdr/400__/t01c8515616311ff6b9.jpg"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        } else {
            self.imageV.image = placeholderImage;
        }
    } else {
        self.imageV.image = imageName;
    }
}


- (void)setupSubViews {
    
    CKJBaseImageLeftRightCellConfig *config = self.configModel;
    
    UIView *bgV = self.subviews_SuperView;
    
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    [bgV addSubview:imageV];
    self.imageV = imageV;
    
    
    CKJFiveLabelView *fiveView = [[CKJFiveLabelView alloc] initWithFrame:CGRectZero config:config.fiveConfig];
    [bgV addSubview:fiveView];
    self.fiveLabelView = fiveView;
}


@end
