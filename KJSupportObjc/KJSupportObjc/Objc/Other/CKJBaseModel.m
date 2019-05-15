//
//  CKJBaseModel.m
//  WDYHFSDK
//
//  Created by chenkaijie on 2018/12/18.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CKJBaseModel.h"
#import "NSObject+WDYHFCategory.h"

@implementation CKJBaseModel

+ (instancetype)modelWithDic:(nullable NSDictionary *)dic {
    CKJBaseModel *model = [[self alloc] init];
    dic = WDKJ_ConfirmDic(dic);
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)clearCache {
    
}

@end



@implementation CKJCommonConfig

+ (nonnull instancetype)configWithDetailSettingBlock:(nullable void(^)(__kindof CKJCommonConfig *m))detailSettingBlock {
    CKJCommonConfig *config = [[self alloc] init];
    if (detailSettingBlock) {
        detailSettingBlock(config);
    }
    return config;
}

@end
