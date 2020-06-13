//
//  CKJBaseModel.h
//  WDYHFSDK
//
//  Created by chenkaijie on 2018/12/18.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CKJCombineCellProtocol.h"
#import "NSObject+WDYHFCategory.h"



UIKIT_EXTERN CGFloat const kO_super_margin_title; // 12



@class CKJArrow9Model;

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

+ (nonnull instancetype)detail:(void(^_Nullable )(__kindof CKJBaseModel *_Nonnull __weak m))detailSettingBlock;




- (void)clearCache;




@end



@class CKJCommonConfig;

@interface CKJCommonConfig : CKJBaseModel

+ (nonnull instancetype)configWithDetail:(nullable void(^)(__kindof CKJCommonConfig *c))detailSettingBlock;

@end














NS_ASSUME_NONNULL_END
