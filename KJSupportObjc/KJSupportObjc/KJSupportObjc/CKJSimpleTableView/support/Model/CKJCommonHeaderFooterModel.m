//
//  CKJCommonHeaderFooterModel.m
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/21.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import "CKJCommonHeaderFooterModel.h"

@implementation CKJCommonHeaderFooterModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (nonnull instancetype)modelWithDetailSettingBlock:(void(^_Nullable)(__kindof CKJCommonHeaderFooterModel *m))detailSettingBlock {
    CKJCommonHeaderFooterModel *model = [[self alloc] init];
    if (detailSettingBlock) {
        detailSettingBlock(model);
    }
    return model;
}



@end

//
//@implementation CKJCommonHeaderModel
//
//@end
//
//@implementation CKJCommonFooterModel
//
//@end
