//
//  LightStorageManager.h
//  RAC空项目
//
//  Created by chenkaijie on 17/4/7.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import <Foundation/Foundation.h>

/*

// 轻量级存储管理者，  只能存简单数据
@interface LightStorageManager : NSObject

+ (BOOL)saveObjc:(id)objc key:(NSString *)objcKey;
+ (id)readObjcOfKey:(NSString *)objcKey;

+ (BOOL)deleteObjcOfKey:(NSString *)objcKey;


@end
*/



//  消息推送是否开启
#define ReceiveMessageEnableKey @"ReceiveMessageEnableKey"

#define ReturnCharKey @"ReturnCharKey"
#define ReturnURLKey @"ReturnURLKey"

#define PreviousLocationCity @"PreviousLocationCity"


#define KJMethodArrayKey @"KJMethodArrayKey"

// 轻量级存储管理者，  只能存简单数据
@interface LightStorageManager : NSObject

#pragma mark - 读取
+ (nullable id)objectForKey:(NSString *_Nonnull)defaultName defaultValue:(nullable id)defaultValue;
+ (void)removeObjectForKey:(NSString *_Nonnull)defaultName;
+ (nullable NSString *)stringForKey:(NSString *_Nonnull)defaultName;
+ (nullable NSArray *)arrayForKey:(NSString *_Nonnull)defaultName;
+ (nullable NSDictionary<NSString *, id> *)dictionaryForKey:(NSString *_Nonnull)defaultName;
+ (nullable NSData *)dataForKey:(NSString *_Nonnull)defaultName;
+ (nullable NSArray<NSString *> *)stringArrayForKey:(NSString *_Nonnull)defaultName;
+ (NSInteger)integerForKey:(NSString *_Nonnull)defaultName;
+ (float)floatForKey:(NSString *_Nonnull)defaultName;
+ (double)doubleForKey:(NSString *_Nonnull)defaultName;
+ (BOOL)boolForKey:(NSString *_Nonnull)defaultName;
+ (nullable NSURL *)URLForKey:(NSString *_Nonnull)defaultName;



#pragma mark - 设置
+ (void)setObject:(nullable id)value forKey:(NSString *_Nonnull)defaultName;
+ (void)setInteger:(NSInteger)value forKey:(NSString *_Nonnull)defaultName;
+ (void)setFloat:(float)value forKey:(NSString *_Nonnull)defaultName;
+ (void)setDouble:(double)value forKey:(NSString *_Nonnull)defaultName;
+ (void)setBool:(BOOL)value forKey:(NSString *_Nonnull)defaultName;
+ (void)setURL:(nullable NSURL *)url forKey:(NSString *_Nonnull)defaultName;





/**
 *  这个是简单的封装的 KeyOfZheDic 对应一个字典 ，下面是结构
 *
 *  {
 *       KeyOfZheDic: { 
 *                       want_setKey : want_setValue
 *                    }
 *  }
 */
+ (void)kj1_setKeyOfZheDic:(NSString *_Nonnull)KeyOfZheDic want_setValue:(id)want_setValue want_setKey:(NSString *)want_setKey defaultValue:(id)defaultValue;
/**
 *  这个是简单的封装的 KeyOfZheDic 对应一个字典 ，下面是结构
 *
 *  {
 *       KeyOfZheDic: {
 *                       want_getZhekey : value
 *                    }
 *  }
 */
+ (nullable id)kj1_KeyOfZheDic:(NSString *_Nonnull)KeyOfZheDic want_getZhekey:(NSString *)want_getZhekey defaultValue:(id)defaultValue;




@end
