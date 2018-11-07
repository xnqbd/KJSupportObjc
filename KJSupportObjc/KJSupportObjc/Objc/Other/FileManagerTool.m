//
//  FileManagerTool.m
//  本地文件操作
//
//  Created by chenkaijie on 16/9/8.
//  Copyright © 2016年 chenkaijie. All rights reserved.
//

#import "FileManagerTool.h"

@implementation FileManagerTool


// 注意: iOS中， 在同一个文件夹下， 不能出现同名的文件和文件夹， 例如如果有了名为1的文件， 就不能存在名称为1的文件夹或者文件


+ (BOOL)createFileBelowPath:(NSString *)path fileName:(NSString *)fileName {
    
    // 先判断 path 是否存在,
    //如果 传入的path 路径不存在 或者 不是 文件夹， 就不能进行 创建下级文件
    if ([self folderExistWithFolderFullPath:path] == NO) {
        NSLog(@"路径错误 或者 是文件 ");
        return NO;
    }
    
    // 文件 全路径
    NSString *itemFullPath = [path stringByAppendingPathComponent:fileName];
    if ([self fileExistWithFileFullPath:itemFullPath]) {
        NSLog(@"已经存在 同名的 文件 ---> %@", itemFullPath);
        return NO;
    }
    if ([self folderExistWithFolderFullPath:itemFullPath]) {
        NSLog(@"已经存在 同名的 文件夹 ---> %@", itemFullPath);
        return NO;
    }
    
    BOOL result = [FileManager createFileAtPath:itemFullPath contents:nil attributes:nil];
    return result;
}


+ (BOOL)createFolderBelowPath:(NSString *)path folderName:(NSString *)folderName {
    
    // 先判断 path 是否存在,
    //如果 传入的path 路径不存在 或者 不是 文件夹， 就不能进行 创建下级文件
    if ([self folderExistWithFolderFullPath:path] == NO) {
        NSLog(@"路径错误 或者 是文件 ");
        return NO;
    }
    
    // 文件 全路径
    NSString *folderFullPath = [path stringByAppendingPathComponent:folderName];
    if ([self folderExistWithFolderFullPath:folderFullPath]) {
        NSLog(@" 已经存在 同名 文件夹 ---> %@", folderFullPath);
        return NO;
    }
    if ([self fileExistWithFileFullPath:folderFullPath]) {
        NSLog(@" 已经存在 同名 文件 ---> %@", folderFullPath);
        return NO;
    }
    
    BOOL result = [FileManager createDirectoryAtPath:folderFullPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    return result;
}


+ (BOOL)fileExistWithFileFullPath:(NSString *)fileFullPath {
    
    // 判断path是否是 文件夹 还是 文件
    BOOL dir = NO;
    
    //判断这个路径是否是 存在的
    BOOL exist = [FileManager fileExistsAtPath:fileFullPath isDirectory:&dir];
    
    if (exist == NO) return NO;
    
    if (dir) return NO;
    
    return YES;
}

+ (BOOL)removeItemWithItemFullPath:(NSString *)itemFullPath {
    if ([self existPathAtPath:itemFullPath] == NO) {
        NSLog(@"路径不存在 %@ ", itemFullPath);
        return NO;
    }
    return [FileManager removeItemAtPath:itemFullPath error:nil];
}


+ (BOOL)folderExistWithFolderFullPath:(NSString *)folderFullPath {
    // 判断path是否是 文件夹 还是 文件
    BOOL dir = NO;
    
    //判断这个路径是否是 存在的
    BOOL exist = [FileManager fileExistsAtPath:folderFullPath isDirectory:&dir];
    
    if (exist == NO) return NO; // 路径错误
      
    if (dir) return YES; //是文件夹
    
    return NO; // 是文件
    
}


+ (BOOL)moveItemAtPath:(NSString *)sourceFullPath toPath:(NSString *)destinationFullPath {
    
    if ([self existPathAtPath:sourceFullPath] == NO) {
        NSLog(@"原路径 不存在 ----->  %@", sourceFullPath);
        return NO;
    }
    
    //判断目标路径是否 存在 同名的 文件 或 文件夹
    BOOL destinationExistFile = [self fileExistWithFileFullPath:destinationFullPath];
    
    if (destinationExistFile == YES) {
        NSLog(@"目标路径下 已经存在 同名 文件 ----->  %@", destinationFullPath);
        return NO;
    }
    
    BOOL destinationExistFolder = [self folderExistWithFolderFullPath:destinationFullPath];
    
    if (destinationExistFolder == YES) {
        NSLog(@"目标路径下 已经存在 同名 文件夹  ----->  %@", destinationFullPath);
        return NO;
    }

    return [FileManager moveItemAtPath:sourceFullPath toPath:destinationFullPath error:nil];
}

+ (BOOL)copyItemAtPath:(NSString *)sourceFullPath toPath:(NSString *)destinationFullPath {
    if ([self existPathAtPath:sourceFullPath] == NO) {
        NSLog(@"%@ ----->  原路径 不存在 ", sourceFullPath);
        return NO;
    }
    //判断目标路径是否 存在 同名的 文件 或 文件夹
    BOOL destinationExistFile = [self fileExistWithFileFullPath:destinationFullPath];
    
    if (destinationExistFile == YES) {
        NSLog(@"%@ ----->  目标路径下 已经存在 同名 文件 ", destinationFullPath);
        return NO;
    }
    
    BOOL destinationExistFolder = [self folderExistWithFolderFullPath:destinationFullPath];
    
    if (destinationExistFolder == YES) {
        NSLog(@"%@ ----->  目标路径下 已经存在 同名 文件夹 ", destinationFullPath);
        return NO;
    }
    return [FileManager copyItemAtPath:sourceFullPath toPath:destinationFullPath error:nil];
}


+ (BOOL)renameItemAtPath:(NSString *)itemFullPath rename:(NSString *)newName {
    
    // NSFileManager 没有提供直接重命名的方法， 只能通过其他方式 实现
    
    NSString *newFullpath = [[itemFullPath stringByDeletingLastPathComponent] stringByAppendingPathComponent:newName];

    BOOL moveToSourcePath = [self moveItemAtPath:itemFullPath toPath:newFullpath];
    return moveToSourcePath;
}

+ (NSArray <NSString *>*)contentsOfDirectoryAtPath:(NSString *)folerFullPath {
    if ([self folderExistWithFolderFullPath:folerFullPath] == NO) {
        NSLog(@"路径错误 或者 是文件 ");
        return nil;
    }
    return [FileManager contentsOfDirectoryAtPath:folerFullPath error:nil];
}

+ (NSDictionary <NSString *, id>*)attributesOfItemAtPath:(NSString *)itemFullPath {
    /*
     NSFileCreationDate = "2016-09-09 07:33:32 +0000";
     NSFileExtensionHidden = 0;
     NSFileGroupOwnerAccountID = 501;
     NSFileModificationDate = "2016-09-09 07:33:32 +0000";
     NSFileOwnerAccountID = 501;
     NSFilePosixPermissions = 420;
     NSFileReferenceCount = 1;
     NSFileSize = 0;   (这个经过测试发现这个 NSFileSize 只能计算文件的大小，而不能直接计算文件夹的大小，如果想要获得文件夹的大小，需要将文件夹下所有的文件的大小相加起来)
     NSFileSystemFileNumber = 36514023;
     NSFileSystemNumber = 16777220;
     NSFileType = NSFileTypeRegular;
    */
    if ([self existPathAtPath:itemFullPath] == NO) {
        NSLog(@"传入的路径 不存在  ");
         return nil;
    }
    return [FileManager attributesOfItemAtPath:itemFullPath error:nil];
 }

+ (long long)folderSizeAtPath:(NSString *)folderPath {
    if ([self folderExistWithFolderFullPath:folderPath] == NO) {
        NSLog(@"文件夹不存在 -----> %@ ", folderPath);
        return 0;
    }
    // 这个得到的是 文件的 相对路径
    NSArray *relativePathArr = [FileManager subpathsAtPath:folderPath];
    
    long long size = 0;
    
    for (NSString *relativePath in relativePathArr) {
        NSString *absolutePath = [folderPath stringByAppendingPathComponent:relativePath];
        if ([self fileExistWithFileFullPath:absolutePath]) {
            size += [self fileSizeAtPath:absolutePath];
        }
    }
    return size;
}

+ (long long)fileSizeAtPath:(NSString *)filePath {
    NSDictionary *attributedDic = [self attributesOfItemAtPath:filePath];
    long long size = [[attributedDic objectForKey:NSFileSize] longLongValue];
    return size;
}

+ (BOOL)createFileAtPath:(NSString *)fileFullPath withData:(NSData *)data {
    if ([self fileExistWithFileFullPath:fileFullPath]) {
        NSLog(@"目标路径下 已经存在 同名 文件 %@", fileFullPath);
        return NO;
    }
    if ([self folderExistWithFolderFullPath:fileFullPath]) {
        NSLog(@"目标路径下 已经存在 同名的 文件夹 ---> %@", fileFullPath);
        return NO;
    }
    
    return [FileManager createFileAtPath:fileFullPath contents:data attributes:nil];
}
+ (BOOL)writeData:(NSData *)data toExistFile:(NSString *)filePath {
    if ([self fileExistWithFileFullPath:filePath] == NO) {
        NSLog(@"传入的路径 不存在 或者 是文件夹类型");
        return NO;
    }
     return [data writeToFile:filePath atomically:YES];
}

+ (NSData *)readDataAtPath:(NSString *)fileFullPath {
    if ([self fileExistWithFileFullPath:fileFullPath] == NO) {
        NSLog(@"传入的路径 不存在 或者 是文件夹类型");
        return nil;
    }
    return [FileManager contentsAtPath:fileFullPath];
}

+ (BOOL)existPathAtPath:(NSString *)fullPath {
    // 判断path是否是 文件夹 还是 文件
    BOOL dir = NO;
    
    //判断原路径是否是 存在的
    BOOL pathExist = [FileManager fileExistsAtPath:fullPath isDirectory:&dir];
    return pathExist;
}

+ (NSString *)documentPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSString *)libraryPath {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
}



@end
