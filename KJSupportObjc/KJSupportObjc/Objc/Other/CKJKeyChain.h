//
//  CKJKeyChain.h
//  keychain+uuid
//
//  Created by aayongche on 16/2/25.
//  Copyright © 2016年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>

// 公司测试机 iPhone 7 plus
// 初次
// uuid----403C6C3D-8702-4F56-8F27-18EA96B30D78
// 重新运行程序
// uuid----403C6C3D-8702-4F56-8F27-18EA96B30D78
// 卸载后
// uuid----403C6C3D-8702-4F56-8F27-18EA96B30D78
// 重新开机 并且卸载后 重新安装
// uuid----403C6C3D-8702-4F56-8F27-18EA96B30D78


// 我的iPhone 6s plus
// 初次
// uuid----453D71BA-A02D-47DC-B9F5-11443681082D
// 重新运行程序
// uuid----453D71BA-A02D-47DC-B9F5-11443681082D
// 卸载后
// uuid----453D71BA-A02D-47DC-B9F5-11443681082D
// 卸载后重新开机 并且 重新安装
// uuid----453D71BA-A02D-47DC-B9F5-11443681082D


@interface CKJKeyChain : NSObject
/**
*  先从内存中获取uuid，如果没有再从钥匙串中获取，如果还没有就生成一个新的uuid，并保存到钥匙串中供以后使用
*
*  @return 设备唯一标识码
*/
- (id)readUDID;
/**
 *  从Keychain中删除唯一设备吗
 */
- (void)deleteUUID;

@end
