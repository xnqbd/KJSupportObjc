//
//  KJSupportHeader.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/7/6.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "KJSupportHeader.h"


@implementation CKJExtraView
@end


@implementation CKJLeftView
@end
@implementation CKJTitle3Label
@end
@implementation CKJSubTitle4Label
@end


@implementation CKJCenterView
@end

@implementation CKJTextFieldWrapperView
@end


@implementation CKJSwitchView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    UISwitch *kjSwitch = [[UISwitch alloc] init];
    kjSwitch.on = YES;
    [self addSubview:kjSwitch];
    kjSwitch.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:kjSwitch attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:kjSwitch attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self addConstraints:@[centerX, centerY]];
    self.swicth = kjSwitch;
}
@end



@implementation CKJRightView
@end

@implementation CKJLikePriceLabel8
@end
@implementation CKJArrowImageView9
@end
