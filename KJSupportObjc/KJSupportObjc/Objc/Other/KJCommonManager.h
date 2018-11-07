//
//  KJCommonManager.h
//  AirCleaner
//
//  Created by chenkaijie on 17/4/27.
//  Copyright © 2017年 HadLinks. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface KJCommonManager : NSObject


+ (void)redirectNSLogToDocumentFolder;
/**
 *  Log 文件夹 路径
 */
+ (NSString *)Log_folder_path;

/**
 *  所有的log文件的名字数组
 */
+ (NSArray <NSString *>*)all_logFileName;

/**
 *  所有的log文件的 全路径
 */
+ (NSArray <NSString *>*)all_logfile_FullPath;





@end
