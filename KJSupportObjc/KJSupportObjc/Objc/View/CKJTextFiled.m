//
//  CKJTextFiled.m
//  HealthCity
//
//  Created by admin2 on 2020/3/19.
//  Copyright © 2020 will. All rights reserved.
//

#import "CKJTextFiled.h"

@implementation CKJTextFiled

- (instancetype)init {
    if (self = [super init]) {
        [self _init];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self _init];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _init];
    }
    return self;
}

- (void)_init {
    self._leftInset = 10;
    self._rightInset = self._leftInset;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
//    NSLog(@"textRectForBounds %@   ", NSStringFromCGRect(bounds));
//    NSLog(@"新的 %@   ", NSStringFromCGRect(CGRectInset( bounds , 30 , 0 )));
//    return CGRectInset( bounds , __inset , 0 );
    return CGRectMake(__leftInset, 0, bounds.size.width - __leftInset - __rightInset, bounds.size.height);
}

//控制编辑文本时所在的位置，左右缩 10
- (CGRect)editingRectForBounds:(CGRect)bounds {
     return CGRectMake(__leftInset, 0, bounds.size.width - __leftInset - __rightInset, bounds.size.height);
}
 
@end
