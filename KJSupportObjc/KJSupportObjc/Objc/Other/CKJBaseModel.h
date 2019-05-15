//
//  CKJBaseModel.h
//  WDYHFSDK
//
//  Created by chenkaijie on 2018/12/18.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKJCombineCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface CKJBaseModel : NSObject

+ (instancetype)modelWithDic:(nullable NSDictionary *)dic;

- (void)clearCache;

@end



@class CKJCommonConfig;

@interface CKJCommonConfig : CKJBaseModel

+ (nonnull instancetype)configWithDetailSettingBlock:(nullable void(^)(__kindof CKJCommonConfig *m))detailSettingBlock;

@end





NS_ASSUME_NONNULL_END
