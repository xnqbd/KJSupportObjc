//
//  MyFamilyCellModel.h
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/6/22.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "CommonCollectionViewCellModel.h"

typedef enum : NSUInteger {
    /*
     * 已认证
     */
    CertifiedStatus_verified,
    /**
     * 待实名认证
     */
    CertifiedStatus_noVerified,
} CertifiedStatus;

@interface MyFamilyCellModel : CommonCollectionViewCellModel

/**
 头像url
 */
@property (copy, nonatomic) NSString *imageUrl;
/**
 认证状态
 */
@property (assign, nonatomic) CertifiedStatus certifiedStatus;
/**
 本人/老公
 */
@property (copy, nonatomic) NSString *identity;
/**
 姓名
 */
@property (copy, nonatomic) NSString *name;
/**
 年龄
 */
@property (assign, nonatomic) int age;



@end
