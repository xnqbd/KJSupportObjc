//
//  GXArchiver.m
//  iGeek
//
//  Created by garyxuan on 16/7/24.
//  Copyright © 2016年 garyxuan. All rights reserved.
//

#import "GXArchiver.h"

@implementation GXArchiver

+ (void)clearAll
{
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager changeCurrentDirectoryPath:docPath];
    NSError *error = nil;
    [fileManager removeItemAtPath:@"GXArchiver" error:&error];
    NSAssert(error == nil, @"删除出错");
}

+ (void)clear:(NSString *)className
{
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * path = [docPath stringByAppendingPathComponent:@"WZXArchiver"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager changeCurrentDirectoryPath:path];
    NSError *error = nil;
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:fileManager.currentDirectoryPath error:&error];
    NSAssert(error == nil, @"查询出错");
    for (NSString *fileName in fileList) {
        if ([fileName hasPrefix:[NSString stringWithFormat:@"GX_%@",className]]) {
            NSError *error = nil;
            [fileManager removeItemAtPath:fileName error:&error];
            NSAssert(error == nil, @"删除出错");
        }
    }
}

+ (void)clear:(NSString *)className name:(NSString *)name
{
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * path = [docPath stringByAppendingPathComponent:@"WZXArchiver"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager changeCurrentDirectoryPath:path];
    NSError *error = nil;
    [fileManager removeItemAtPath:[NSString stringWithFormat:@"GX_%@_%@.archiver",className,name] error:&error];
    NSAssert(error == nil, @"删除出错");
}

@end
