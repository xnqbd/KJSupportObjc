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


//- (instancetype)init {
//    if (self = [super init]) {
//        
//    }
//    return self;
//}


@interface CKJBaseModel : NSObject


/**
 这个extension_Interger可以作为一个延展数据 推荐设置外面自定义的枚举
 */
@property (assign, nonatomic) NSInteger extension_Interger;


+ (instancetype)modelWithDic:(nullable NSDictionary *)dic;

+ (nonnull instancetype)detailSettingBlock:(void(^_Nullable )(__kindof CKJBaseModel *_Nonnull __weak m))detailSettingBlock;



- (void)clearCache;




@end



@class CKJCommonConfig;

@interface CKJCommonConfig : CKJBaseModel

+ (nonnull instancetype)configWithDetailSettingBlock:(nullable void(^)(__kindof CKJCommonConfig *m))detailSettingBlock;

@end







@interface CKJNetWorkDataModel : CKJBaseModel

@end





NS_ASSUME_NONNULL_END
