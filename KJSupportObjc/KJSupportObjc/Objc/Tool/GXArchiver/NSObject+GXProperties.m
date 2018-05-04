//
//  NSObject+GXProperties.m
//
//  Created by garyxuan on 16/6/29.
//  Copyright © 2016年 garyxuan. All rights reserved.
//

#import "NSObject+GXProperties.h"
#import <objc/runtime.h>
@implementation NSObject (GXProperties)

- (NSArray *)gx_allProperty:(Class)cla
{
    NSMutableArray *propertyArr = [NSMutableArray array];
    unsigned int outCount;
    //所有属性
    objc_property_t *properties = class_copyPropertyList(cla, &outCount);
    for (int i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        //@"T@\"NSString\",C,N,V_title"
        NSString *propertyType = [[NSString alloc] initWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
        
        [propertyArr addObject:@{@"name":propertyName,@"type":[self propertyType:propertyType]}];   
    }
    free(properties);
    return propertyArr;
}

- (NSString *)propertyType:(NSString *)attributes
{
    if ([attributes hasPrefix:@"T"])
    {
        if ([attributes hasPrefix:@"T@"]) {
            if ([attributes hasPrefix:@"T@\"NSString\""]) {
                return @"NSString";
            } else if([attributes hasPrefix:@"T@\"NSDictionary\""]) {
                return @"NSDictionary";
            } else if([attributes hasPrefix:@"T@\"NSArray\""]) {
                return @"NSArray";
            } else if([attributes hasPrefix:@"T@\"NSMutableString\""]) {
                return @"NSMutableString";
            } else if([attributes hasPrefix:@"T@\"NSMutableDictionary\""]) {
                return @"NSMutableDictionary";
            } else if([attributes hasPrefix:@"T@\"NSMutableArray\""]) {
                return @"NSMutableArray";
            } else if([attributes hasPrefix:@"T@\"NSData\""]) {
                return @"NSData";
            } else if([attributes hasPrefix:@"T@\"NSMutableData\""]) {
                return @"NSMutableData";
            } else if([attributes hasPrefix:@"T@\"NSSet\""]) {
                return @"NSSet";
            } else if([attributes hasPrefix:@"T@\"NSMutableSet\""]) {
                return @"NSMutableSet";
            } else if([attributes hasPrefix:@"T@\"NSNumber\""]) {
                return @"NSNumber";
            } else {//自定义类型
                // 这里面可能会有block
                NSArray *array = [attributes componentsSeparatedByString:@"\""];
                if (array.count >= 2) {
                    return [NSString stringWithFormat:@"__Model__:%@",[attributes componentsSeparatedByString:@"\""][1]];
                } else {
                    return [NSNull class];
                }
            }
        }
        if ([attributes hasPrefix:@"Tq"]) {
            return @"NSInteger";
        } else if ([attributes hasPrefix:@"TQ"]) {
            return @"NSUInteger";
        } else if ([attributes hasPrefix:@"Td"]) {
            return @"double";
        } else if ([attributes hasPrefix:@"TB"]) {
            return @"BOOL";
        } else if ([attributes hasPrefix:@"Ti"]) {
            return @"int";
        } else if ([attributes hasPrefix:@"Tf"]) {
            return @"float";
        } else if ([attributes hasPrefix:@"Ts"]) {
            return @"short";
        }
        return @"";
    }else
    {
        //错误字符串
        return @"";
    }
}
@end
