//
//  GXArchiver.h
//  iGeek
//
//  Created by garyxuan on 16/7/24.
//  Copyright © 2016年 garyxuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+GXArchiver.h"

@interface GXArchiver : NSObject

/**
 *  清楚所有归档   就是GXArchiver文件夹下 所有的归档数据
 */
+ (void)clearAll;

/**
 *  清除一个类的归档
 *
 *  @param className 类的名字
 */
+ (void)clear:(NSString *)className;

/**
 *  清除一个类归档名为name的归档
 *
 *  @param className 类名
 *  @param name      归档名
 */
+ (void)clear:(NSString *)className name:(NSString *)name;
@end
