//
//  CKJTwoLabelAsCompleteView.m
//  Demo
//
//  Created by admin2 on 2020/4/7.
//  Copyright © 2020 admin2. All rights reserved.
//

#import "CKJTwoLabelAsCompleteView.h"
#import "NSObject+WDYHFCategory.h"


@implementation CKJTwoLabelAsCompleteView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self kjinit];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self kjinit];
    }
    return self;
}

- (void)kjinit {
    
    // 这里面 如果不需要数值动画效果，可以直接把CKJCountingLabel变成UILabel即可
    
    CKJCountingLabel *left = [[CKJCountingLabel alloc] init];
    left.textAlignment = NSTextAlignmentRight;
    [left setContentHuggingPriority:255 forAxis:UILayoutConstraintAxisVertical];
    [left setContentCompressionResistancePriority:755 forAxis:UILayoutConstraintAxisVertical];
    [left kjwd_addToSuperView:self constraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
        make.top.bottom.equalTo(superview);
        make.left.equalTo(superview).offset(0);
    }];
    self.leftLabel = left;
    
    CKJCountingLabel *right = [[CKJCountingLabel alloc] init];
    [right setContentHuggingPriority:254 forAxis:UILayoutConstraintAxisVertical];
    [right setContentCompressionResistancePriority:754 forAxis:UILayoutConstraintAxisVertical];
    [right kjwd_addToSuperView:self constraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
        make.top.bottom.equalTo(superview);
        make.right.equalTo(superview).offset(0);
        make.left.equalTo(left.mas_right).offset(0);
    }];
    self.rightLabel = right;
    
//    BOOL debug = YES;
    BOOL debug = NO;
    if (debug) {
        WDCKJBGColor_Arc4Color(left);
        WDCKJBGColor_Arc4Color(right);

        left.text = @"左Label";
        right.text = @"右Label";
    }
}

@end
