//
//  NSObject+GXArchiver.m
//
//  Created by garyxuan on 16/6/29.
//  Copyright © 2016年 garyxuan. All rights reserved.
//

#import "NSObject+GXArchiver.h"
#import "NSObject+GXProperties.h"
#import <objc/runtime.h>
@interface NSObject()
@property(nonatomic,copy) NSString *GX_Archiver_Name;
@end

static const void *GX_Archiver_Name_Key = "GX_Archiver_Name_Key";
@implementation NSObject (GXArchiver)

//分类的属性只生成set和get方法，并不生成实例变量(_xxx)
- (void)setGX_Archiver_Name:(NSString *)GX_Archiver_Name
{
    objc_setAssociatedObject(self, GX_Archiver_Name_Key, GX_Archiver_Name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)GX_Archiver_Name
{
    return objc_getAssociatedObject(self, GX_Archiver_Name_Key);
}

- (BOOL)gx_archiveToName:(NSString *)name
{
    NSLog(@"write 沙盒主路径是 %@", NSHomeDirectory());
    return [self gx_archiveToName:name isChildObject:NO];
}

- (BOOL)gx_archiveToName:(NSString *)name isChildObject:(BOOL)isChildObject
{
    NSLog(@"read 沙盒主路径是 %@", NSHomeDirectory());
    //是对象中的子对象
    if (isChildObject) {
        return [NSKeyedArchiver archiveRootObject:self toFile:[[self class] getChildObjectPath:name]];
    }else{
        self.GX_Archiver_Name = name;
        NSString *path = [[self class] getPath:name];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:path]) {
            [fileManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],@"GXArchiver"] withIntermediateDirectories:YES attributes:nil error:nil];
        }
        return [NSKeyedArchiver archiveRootObject:self toFile:path];
    }
}

+ (id)gx_unArchive:(NSString *)name
{
    return [self gx_unArchive:name isChildObject:NO];
}



+ (id)gx_unArchive:(NSString *)name isChildObject:(BOOL)isChildObject
{
    //这个时候的self是类对象
    //self.GX_Archiver_Name = name;
    objc_setAssociatedObject(self, GX_Archiver_Name_Key, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (isChildObject) {
        NSLog(@"%@---%@",[self class],[[self class] getChildObjectPath:name]);
        return [NSKeyedUnarchiver unarchiveObjectWithFile:[[self class] getChildObjectPath:name]];
    }else
    {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:[[self class] getPath:name]];
    }
}

+ (NSString *)getChildObjectPath:(NSString *)name {
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * path = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"GXArchiver/GX_%@.archiver",name]];
    return path;
}

+ (NSString *)getPath:(NSString *)name{
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * path = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"GXArchiver/GX_%@_%@.archiver",
                                                               NSStringFromClass(self.class),name]];
    return path;
}

#pragma mark -- NSCoding --
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    Class cla = self.class;
    while (cla != nil) {
        if (cla == [NSObject class]) {
            break;
        }
        NSArray *propertyArr = [self gx_allProperty:cla];
        for (NSDictionary *propertyDic in propertyArr) {
            [self encodeWithType:propertyDic[@"type"] name:propertyDic[@"name"] coder:aCoder];
        }
        cla = class_getSuperclass(cla);
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    Class cla = self.class;
    while (cla != nil) {
        if (cla == [NSObject class]) {
            break;
        }
        NSArray * propertyArr = [self gx_allProperty:cla];
        for (NSDictionary * propertyDic in propertyArr) {
            if ([self decodeWithType:propertyDic[@"type"] Name:propertyDic[@"name"] Coder:aDecoder]) {
                [self setValue:[self decodeWithType:propertyDic[@"type"] Name:propertyDic[@"name"] Coder:aDecoder] forKey:propertyDic[@"name"]];
            }
        }
        cla = class_getSuperclass(cla);
    }
    
    return self;
}
#pragma clang diagnostic pop
- (id)decodeWithType:(NSString *)type Name:(NSString *)name Coder:(NSCoder *)aDecoder {
    //NSLog(@"解压缩 %@   %@", type, name);
    if ([type isKindOfClass:[NSString class]] == NO) {
        return nil;
    }
    
    //由于gx_unArchiveToName是类方法所以self是类对象，所以GX_unArchiveToName是绑定到了类对象，并不是实例对象
    NSString *gx_Archiver_Name =  objc_getAssociatedObject([self class], GX_Archiver_Name_Key);
    if ([self isObject:type]) {
        return [aDecoder decodeObjectOfClass:NSClassFromString(type) forKey:name];
    } else if([type isEqualToString:@"int"]||
              [type isEqualToString:@"short"]){
        return @([aDecoder decodeIntegerForKey:name]);
    } else if([type isEqualToString:@"BOOL"]){
        return @([aDecoder decodeBoolForKey:name]);
    } else if([type isEqualToString:@"float"]){
        return @([aDecoder decodeFloatForKey:name]);
    } else if([type isEqualToString:@"double"]){
        return @([aDecoder decodeDoubleForKey:name]);
    } else if([type isEqualToString:@"NSInteger"]||
              [type isEqualToString:@"NSUInteger"]){
        return @([aDecoder decodeIntegerForKey:name]);
    }
    if ([type hasPrefix:@"__Model__:"]) {
        NSString * className = [type componentsSeparatedByString:@"__Model__:"][1];
                NSString * path = [NSString stringWithFormat:@"%@_%@_%@_%@",NSStringFromClass(self.class),gx_Archiver_Name,className,name];
        [self setValue:[NSClassFromString(className) gx_unArchive:path isChildObject:YES]forKey:name];
    }
    return nil;
}
- (void)encodeWithType:(NSString *)type name:(NSString *)name coder:(NSCoder *)aCoder
{
    //NSLog(@"压缩 %@   %@", type, name);
    
    if ([type isKindOfClass:[NSString class]] == NO) {
        return;
    }
    
    if ([self isObject:type]) {//foundation类型
        [aCoder encodeObject:[self valueForKey:name] forKey:name];
    } else if([type isEqualToString:@"BOOL"]){
        
        [aCoder encodeBool:[[self valueForKey:name] boolValue] forKey:name];
    } else if([type isEqualToString:@"float"]){
        
        [aCoder encodeFloat:[[self valueForKey:name] floatValue] forKey:name];
    } else if([type isEqualToString:@"double"]){
        
        [aCoder encodeFloat:[[self valueForKey:name] doubleValue] forKey:name];
    } else if([type isEqualToString:@"int"]||
              [type isEqualToString:@"short"]){
        
        [aCoder encodeInt:[[self valueForKey:name] intValue] forKey:name];
    } else if([type isEqualToString:@"NSInteger"]||
              [type isEqualToString:@"NSUInteger"]){
        
        [aCoder encodeInteger:[[self valueForKey:name] integerValue] forKey:name];
    }
    if ([type hasPrefix:@"__Model__:"]) {
        NSString * className = [type componentsSeparatedByString:@"__Model__:"][1];
        NSString * path = [NSString stringWithFormat:@"%@_%@_%@_%@",NSStringFromClass(self.class),self.GX_Archiver_Name,className,name];
        [[self valueForKey:name] gx_archiveToName:path isChildObject:YES];
    }
}

- (BOOL)isObject:(NSString *)type {
    NSArray * objectTypeArr = @[@"NSString",
                                @"NSMutableString",
                                @"NSArray",
                                @"NSMutableArray",
                                @"NSDictionary",
                                @"NSMutableDictionary",
                                @"NSData",
                                @"NSMutableData",
                                @"NSSet",
                                @"NSMutableSet",
                                @"NSNumber"];
    return [objectTypeArr containsObject:type];
}

@end


@implementation NSArray (GXArchiver)

- (BOOL)kj_archiveToName:(NSString *)name {
    
    NSObject *first = self.firstObject;
    
    BOOL result = NO;
    for (NSObject *objc in self) {
        if ([objc isMemberOfClass:first.class] == NO) {
            result = YES;
        }
    }
    if (result) {
        NSLog(@"请却确保数组中的元素是同一种类");
        return NO;
    }

    NSString *path = [[NSArray class] getPath:name];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],@"GXArchiver"] withIntermediateDirectories:YES attributes:nil error:nil];
    }
        //需要用NSMutableData来中中介
        
        NSMutableData *data = [[NSMutableData alloc] init];
        
        //创建归档辅助类
        
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        
        //编码
        
        [archiver encodeObject:self forKey:[NSString stringWithFormat:@"%@_KJKEY", name]];
        
        //结束编码
        
        [archiver finishEncoding];
        
        //写入
    return  [data writeToFile:path atomically:YES];;
}

+ (NSArray *)kj_unArchiveToName:(NSString *)name {
    
    NSString *path = [[NSArray class] getPath:name];
    
    NSData *_data = [[NSData alloc] initWithContentsOfFile:path];
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:_data];
    
    NSArray *array = [unarchiver decodeObjectForKey:[NSString stringWithFormat:@"%@_KJKEY", name]];
    
    [unarchiver finishDecoding];
    return array;
}


@end

