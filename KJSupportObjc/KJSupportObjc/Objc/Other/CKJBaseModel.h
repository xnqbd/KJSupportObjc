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


/**
 这个extension_Obj可以作为一个延展数据
 场景1: 可以使用这个extension_Obj属性聚合一个或者多个cellModel (注意：CKJEmptyCellModel除外)
 场景2: 在KJSupportObjc库自带的CellModel 如果开发者不想自定义，但是还想在携带一些数据，可以使用这个
 */
@property (strong, nonatomic, nullable) id extension_Obj;
@property (weak, nonatomic, nullable) id extension_weakObj;

@property (copy, nonatomic, nullable) NSString *extension_String;

/**
 这个extension_Interger可以作为一个延展数据 推荐设置外面自定义的枚举
 */
@property (assign, nonatomic) NSInteger extension_Interger;


+ (instancetype)modelWithDic:(nullable NSDictionary *)dic;

+ (nonnull instancetype)detailSettingBlock:(nullable void(^)(__kindof CKJBaseModel *m))detailSettingBlock;



- (void)clearCache;




@end



@class CKJCommonConfig;

@interface CKJCommonConfig : CKJBaseModel

+ (nonnull instancetype)configWithDetailSettingBlock:(nullable void(^)(__kindof CKJCommonConfig *m))detailSettingBlock;

@end





NS_ASSUME_NONNULL_END
