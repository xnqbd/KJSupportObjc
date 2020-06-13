//
//  CKJProjectConfig.m
//  FDEK
//
//  Created by admin2 on 2020/1/19.
//  Copyright © 2020 admin2. All rights reserved.
//

#import "CKJProjectConfig.h"
#import "CKJGeneralCell.h"

@implementation CKJProjectConfig

// 这些方法可能存在方法交换，所以方法名字尽量不要更改

+ (UIColor *)commitBtnColor {
    return [UIColor kjwd_r:25 g:130 b:197 alpha:1];
}
+ (CGFloat)super_margin_title {
    return 12;
}
+ (CKJArrow9Model *)arrow9SystemModel {
    return [[CKJArrow9Model alloc] init];
}


@end
