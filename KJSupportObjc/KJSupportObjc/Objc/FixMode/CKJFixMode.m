//
//  CKJFixMode.m
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/11/9.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJFixMode.h"
#import "NSObject+WDYHFCategory.h"

//NSString *_Nonnull const c_EnumKey = @"KJSupportObjc_c_EnumKey";


@implementation CKJFixItem

+ (instancetype)modelWithEnum:(int)enumValue {
    CKJFixItem *item = [[self alloc] init];
    item.enumValue = @(enumValue);
    return item;
}
+ (instancetype)modelWithEnum:(int)enumValue imageName:(NSString *)imageName {
    CKJFixItem *item = [[self alloc] init];
    item.enumValue = @(enumValue);
    item.imageName = imageName;
    return item;
}

@end


@implementation CKJFixMode

// 通过 @"1" 或者 @1  找到  枚举Enum
+ (CKJFixItem *_Nullable)__private__common_getEnumByKey:(id)key dataSource:(NSDictionary <NSString *, CKJFixItem *>*)dataSource {
    
    
//    @{
//        @"-1" : [CKJFixItem modelWithEnum:RJRealStatus_Other imageName:@""],
//        @"0" : [CKJFixItem modelWithEnum:RJRealStatus_NoReal imageName:@"new_personal_未实名"],
//        @"1" : [CKJFixItem modelWithEnum:RJRealStatus_Realed imageName:@"new_personal_已实名"],
//        @"2" : [CKJFixItem modelWithEnum:RJRealStatus_Other imageName:@""]
//    };
    
    
    CKJFixItem *enumValue = nil;
    NSArray *allKeys = dataSource.allKeys;
    for (NSString *insideKey in allKeys) {
        if (WDKJ_CompareNumberOrString(key, insideKey)) {
            enumValue = dataSource[insideKey];
            break;
        }
    }
    
    return enumValue;
}

// 通过 枚举Enum 找到 @"1"  
+ (NSString *_Nullable)__private__common_getKeyByEnum:(NSNumber *)enumValue dataSource:(NSDictionary <NSString *, CKJFixItem *>*)dataSource {
    
    NSString *key = nil;
    
    NSArray *allKeys = dataSource.allKeys;
    for (NSString *insideKey in allKeys) {
        CKJFixItem *temp = dataSource[insideKey];
        if (temp.enumValue.intValue == enumValue.intValue) {
            key = insideKey;
            break;
        }
    }
    
    return key;
}


// 通过 枚举Enum 找到 FixItem
+ (__kindof CKJFixItem *_Nullable)__private__common_getFixItemByEnum:(NSNumber *)enumValue dataSource:(NSDictionary <NSString *, CKJFixItem *>*)dataSource {
    
    NSArray *allKeys = dataSource.allKeys;
    for (NSString *insideKey in allKeys) {
        CKJFixItem *temp = dataSource[insideKey];
        if (temp.enumValue.intValue == enumValue.intValue) {
            return temp;
        }
    }
    
    return nil;
}



//+ (NSDictionary *)RealStatus {
//    NSDictionary <NSString *, NSNumber *>*dic = @{
//        @"0" : @(RJRealStatus_NoReal),
//        @"1" : @(RJRealStatus_Realed),
//        @"2" : @(RJRealStatus_Other)
//    };
//    return dic;
//}
//
//+ (RJRealStatus)getRealStatusEnumByKey:(NSNumber *)key {
//    NSNumber *result = [CKJFixMode __private__common_getEnumByKey:key dataSource:[self RealStatus]];
//    if (result) {   // 能从字典里找到enum枚举
//        return (RJRealStatus)result.intValue;
//    } else {        // 找不到enum枚举
//        return RJRealStatus_Other;
//    }
//}
//+ (NSNumber *)getRealStatusValueByEnum:(RJRealStatus)enumValue {
//    NSString *key = [CKJFixMode __private__common_getKeyByEnum:@(enumValue) dataSource:[self RealStatus]];
//    return [NSNumber numberWithInt:key.intValue];
//}



@end
