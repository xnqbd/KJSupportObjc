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



@implementation CKJLikePriceLabel61

- (instancetype)init {
    if (self = [super init]) {
        [self setContentHuggingPriority:850 forAxis:UILayoutConstraintAxisHorizontal];
        [self setContentCompressionResistancePriority:850 forAxis:UILayoutConstraintAxisHorizontal];
    }
    return self;
}

@end

@implementation CKJRightView

- (instancetype)init {
    if (self = [super init]) {
//        self.hidden = YES;
//        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

@end

@implementation CKJLikePriceLabel8

- (instancetype)init {
    if (self = [super init]) {
        [self setContentHuggingPriority:850 forAxis:UILayoutConstraintAxisHorizontal];
        [self setContentCompressionResistancePriority:850 forAxis:UILayoutConstraintAxisHorizontal];
    }
    return self;
}

@end
@implementation CKJArrowImageView9
@end
