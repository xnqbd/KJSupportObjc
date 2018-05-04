//
//  NSObject+GXArchiver.h
//
//  Created by garyxuan on 16/6/29.
//  Copyright © 2016年 garyxuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GXArchiver)


/**
 *  把单个自定义对象存入沙盒
 *
 *  @param name 名字
 *
 *  @return 是否成功
 */
- (BOOL)gx_archiveToName:(NSString *)name;

/**
 *  从沙盒取出单个自定义对象,     注意>>>>>>>>>>>>>>>  一定要用想要解档的类的类名 <<<<<<<<<<<<<
 *
 *  @param name 名字
 *
 *  @return 解归档的对象
 */
+ (id)gx_unArchive:(NSString *)name;


@end


@interface NSArray (KJArchiver)

/**
 *  把自定义对象的数组数组压缩到沙盒
 */
- (BOOL)kj_archiveToName:(NSString *)name;
/**
 *  从沙盒取出自定义对象的数组
 */
+ (NSArray *)kj_unArchiveToName:(NSString *)name;

@end

