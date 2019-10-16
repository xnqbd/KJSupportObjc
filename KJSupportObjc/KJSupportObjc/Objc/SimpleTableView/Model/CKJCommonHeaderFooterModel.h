//
//  CKJCommonHeaderFooterModel.h
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/21.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKJSimpleBaseModel.h"


typedef NS_ENUM(NSUInteger, CKJCommonHeaderFooterType) {
    /** 头 */
    CKJCommonHeaderFooterType_HEADER,
    /** 尾 */
    CKJCommonHeaderFooterType_FOOTER
};


@interface CKJCommonHeaderFooterModel : CKJSimpleBaseModel

/**
 系统的区头区尾
 */
@property (copy, nonatomic) NSString *systemTitle;
/**
 系统的区头区尾 子标题
 */
@property (copy, nonatomic) NSString *systemSubTitle;

@property (assign, nonatomic) CKJCommonHeaderFooterType type;


+ (nonnull instancetype)modelWithDetailSettingBlock:(void(^_Nullable)(__kindof CKJCommonHeaderFooterModel *m))detailSettingBlock;


@end
