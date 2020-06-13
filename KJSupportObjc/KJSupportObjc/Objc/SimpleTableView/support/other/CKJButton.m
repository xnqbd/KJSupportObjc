//
//  CKJButton.m
//  MobileHospital_Renji
//
//  Created by admin2 on 2020/1/11.
//  Copyright © 2020 Lyc. All rights reserved.
//

#import "CKJButton.h"

@implementation CKJButton

- (instancetype)init {
    if (self = [super init]) {
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
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    return CGSizeMake(size.width + _fixWidth, size.height + _fixHeight);
}


@end
