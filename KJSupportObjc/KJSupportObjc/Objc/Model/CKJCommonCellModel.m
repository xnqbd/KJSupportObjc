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
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}


+ (instancetype)modelWithCellHeight:(CGFloat)cellHeight didSelectRowBlock:(nullable WDDidSelectRowBlock)didSelectRowBlock {
    CKJCommonCellModel *model = [[self alloc] init];
    model.cellHeight = cellHeight;
    model.didSelectRowBlock = didSelectRowBlock;
    return model;
}


@end
