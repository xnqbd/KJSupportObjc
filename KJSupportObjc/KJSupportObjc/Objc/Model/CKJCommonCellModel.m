//
//  CKJCommonCellModel.m
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/7/4.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "CKJCommonCellModel.h"

@implementation CKJCommonCellModel

- (instancetype)init {
    if (self = [super init]) {
        self.displayInTableView = YES;
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
