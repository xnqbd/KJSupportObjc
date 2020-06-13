//
//  CKJFixMode.h
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/11/9.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseModel.h"


NS_ASSUME_NONNULL_BEGIN


@interface CKJFixItem : CKJBaseModel

/// 这个枚举值 是必须有的
@property (copy, nonatomic, nonnull) NSNumber *enumValue;

@property (copy, nonatomic) NSString *imageName;

+ (instancetype)modelWithEnum:(int)enumValue;
+ (instancetype)modelWithEnum:(int)enumValue imageName:(NSString *)imageName;

@end




@interface CKJFixMode : CKJBaseModel


/// 通过 @"1" 或者 @1  找到  枚举Enum
+ (CKJFixItem *_Nullable)__private__common_getEnumByKey:(id)key dataSource:(NSDictionary <NSString *, CKJFixItem *>*)dataSource;


/// 通过 枚举Enum 找到 Key  @"1"
+ (NSString *_Nullable)__private__common_getKeyByEnum:(NSNumber *)enumValue dataSource:(NSDictionary <NSString *, CKJFixItem *>*)dataSource;
    

/// 通过 枚举Enum 找到 FixItem
+ (__kindof CKJFixItem *_Nullable)__private__common_getFixItemByEnum:(NSNumber *)enumValue dataSource:(NSDictionary <NSString *, CKJFixItem *>*)dataSource;
    



@end

NS_ASSUME_NONNULL_END
