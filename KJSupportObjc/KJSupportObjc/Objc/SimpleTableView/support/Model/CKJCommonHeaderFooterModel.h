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

@property (assign, nonatomic) CKJCommonHeaderFooterType type;


+ (nonnull instancetype)modelWithDetailSettingBlock:(void(^_Nullable)(__kindof CKJCommonHeaderFooterModel *m))detailSettingBlock;


@property (copy, nonatomic) NSNumber *height;

@end



//@interface CKJCommonHeaderModel : CKJCommonHeaderFooterModel
//
////+ (nonnull instancetype)modelWithDetailSettingBlock:(void(^_Nullable)(__kindof CKJCommonHeaderFooterModel *m))detailSettingBlock;
//
//
//@end
//
//@interface CKJCommonFooterModel : CKJCommonHeaderFooterModel
//
////+ (nonnull instancetype)modelWithDetailSettingBlock:(void(^_Nullable)(__kindof CKJCommonHeaderFooterModel *m))detailSettingBlock;
//
//
//@end
