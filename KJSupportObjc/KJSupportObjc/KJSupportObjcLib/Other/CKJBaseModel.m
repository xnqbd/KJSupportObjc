//
//  CKJBaseModel.m
//  WDYHFSDK
//
//  Created by chenkaijie on 2018/12/18.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CKJBaseModel.h"
#import "NSObject+WDYHFCategory.h"
#import "CKJGeneralCell.h"


CGFloat const kO_super_margin_title = 12;
//CGFloat const kO_super_margin_title = 12;


@implementation CKJBaseModel

+ (instancetype)modelWithDic:(nullable NSDictionary *)dic {
    CKJBaseModel *model = [[self alloc] init];
    dic = WDKJ_ConfirmDic(dic);
    [model setValuesForKeysWithDictionary:dic];
    return model;
}


+ (nonnull instancetype)detail:(void(^_Nullable )(__kindof CKJBaseModel *_Nonnull __weak m))detailSettingBlock {
    CKJBaseModel *model = [[self alloc] init];
    if (detailSettingBlock) {
        detailSettingBlock(model);
    }
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)clearCache {
    
}

@end



@implementation CKJCommonConfig

+ (nonnull instancetype)configWithDetail:(nullable void(^)(__kindof CKJCommonConfig *c))detailSettingBlock {
    CKJCommonConfig *config = [[self alloc] init];
    if (detailSettingBlock) {
        detailSettingBlock(config);
    }
    return config;
}

@end



