//
//  FileManagerTool.h
//  本地文件操作
//
//  Created by chenkaijie on 16/9/8.
//  Copyright © 2016年 chenkaijie. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FileManager [NSFileManager defaultManager]

@interface FileManagerTool : NSObject

// -----------------------------------创建文件--------------------------------
/**
 *  创建文件
 *
 *  @param path     文件夹路径
 *  @param fileName 想要创建的文件名
 *
 *  @return 创建结果
 */
+ (BOOL)createFileBelowPath:(NSString *)path fileName:(NSString *)fileName;


// ----------------------------------- 创建文件夹 --------------------------------
/**
 *  创建文件夹
 *
 *  @param path       文件夹路径
 *  @param folderName 想要创建的文件夹名
 *
 *  @return 创建结果
 */
+ (BOOL)createFolderBelowPath:(NSString *)path folderName:(NSString *)folderName;


// ----------------------------------- 删除 文件 文件夹--------------------------------
/**
 *  删除 文件 / 文件夹
 *
 *  @param itemFullPath 文件 / 文件夹 全路径
 *
 *  @return 删除结果
 */
+ (BOOL)removeItemWithItemFullPath:(NSString *)itemFullPath;

// -----------------------------------路径 是否存在在--------------------------------
/**
 *  判断路径是否存在
 *
 *  @param fullPath 文件/文件夹 全路径
 *
 *  @return 存在/不存在
 */
+ (BOOL)existPathAtPath:(NSString *)fullPath;

// -----------------------------------文件 是否存在在--------------------------------

/**
 *  文件是否存在
 *
 *  @param fileFullPath 文件全路径
 *
 *  @return 存在返回YES，不存在返回NO
 */
+ (BOOL)fileExistWithFileFullPath:(NSString *)fileFullPath;


// -----------------------------------文件夹 是否存在在--------------------------------
/**
 *  文件夹是否存在
 *
 *  @param folderFullPath 文件夹全路径
 *
 *  @return 存在返回YES，不存在返回NO
 */
+ (BOOL)folderExistWithFolderFullPath:(NSString *)folderFullPath;

// ----------------------------------- 移动 文件/文件夹 --------------------------------

/**
 *  移动 文件/文件夹
 *
 *  @param sourceFullPath      原全路径
 *  @param destinationFullPath 想要移动到的目标全路径
 *
 *  @return 移动结果
 */
+ (BOOL)moveItemAtPath:(NSString *)sourceFullPath toPath:(NSString *)destinationFullPath;

// ----------------------------------- copy 文件/文件夹 --------------------------------

/**
 *  copy 文件/文件夹
 *
 *  @param sourceFullPath      原全路径
 *  @param destinationFullPath 想要copy到的目标全路径
 *
 *  @return copy结果
 */
+ (BOOL)copyItemAtPath:(NSString *)sourceFullPath toPath:(NSString *)destinationFullPath;

// ----------------------------------- 重命名 文件/文件夹 --------------------------------

/**
 *  重命名 文件/文件夹
 *
 *  @param itemFullPath 文件/文件夹 全路径
 *  @param newName      重命名的名字
 *
 *  @return 重命名结果
 */
+ (BOOL)renameItemAtPath:(NSString *)itemFullPath rename:(NSString *)newName;



/**
 *  文件夹下 的子目录的名字(相对路径)  (只会得到第一层， 不会递归找子目录的子目录)
 *
 *  @param folerFullPath 文件夹路径
 *
 *  @return 返回子目录的名字数组 (注意:没有找到文件夹返回nil)
 */
+ (NSArray <NSString *>*)contentsOfDirectoryAtPath:(NSString *)folerFullPath;

/**
 *  文件/文件夹 的属性  (指定路径下)
 *
 *  @param itemFullPath 文件/文件夹 全路径
 *
 *  @return 文件/文件夹 的属性, (当路径不存在时 返回nil)
 */
+ (NSDictionary <NSString *, id>*)attributesOfItemAtPath:(NSString *)itemFullPath;


/**
 *  文件夹大小
 *
 *  @param folderPath 文件夹路径
 *
 *  @return 文件夹大小
 */
+ (long long)folderSizeAtPath:(NSString *)folderPath;

/**
 *  文件大小
 *
 *  @param filePath 文件路径
 *
 *  @return 文件大小
 */
+ (long long)fileSizeAtPath:(NSString *)filePath;



// ----------------------------------- 读写 数据操作 --------------------------------

/**
 *  创建一个文件，并写入Data
 *
 *  @param fileFullPath 想要创建的文件全路径
 *  @param data         写入的二进制数据
 *
 *  @return 操作结果 (包括创建成功失败，写入成功失败)
 */
+ (BOOL)createFileAtPath:(NSString *)fileFullPath withData:(NSData *)data;

/**
 *  在一个已存在的文件里写入data
 *
 *  @param data     写入的二进制数据
 *  @param filePath 已存在的文件全路径
 *
 *  @return 操作结果 (包括文件是否存在，写入成功失败)
 */
+ (BOOL)writeData:(NSData *)data toExistFile:(NSString *)filePath;

/**
 *  读取数据
 *
 *  @param fileFullPath 文件全路径
 *
 *  @return 读取的数据
 */
+ (NSData *)readDataAtPath:(NSString *)fileFullPath;






@end
