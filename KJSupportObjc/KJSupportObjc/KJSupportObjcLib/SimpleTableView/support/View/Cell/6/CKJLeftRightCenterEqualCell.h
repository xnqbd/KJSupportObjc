//
//  CKJLeftRightCenterEqualCell.h
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/10/26.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseLeftRightCell.h"

NS_ASSUME_NONNULL_BEGIN


@class CKJLeftRightCenterEqualCellModel;

typedef void(^CKJLeftRightCenterEqualCellRowBlock)(__kindof CKJLeftRightCenterEqualCellModel *_Nonnull m);


@interface CKJLeftRightCenterEqual_LeftLabelSetting : CKJBaseLeftLabelSetting

+ (instancetype)settingWithLeftMargin:(nullable NSNumber *)leftMargin detail:(void(^_Nullable)(CKJLeftRightCenterEqual_LeftLabelSetting *setting))detail;

@end


@interface CKJLeftRightCenterEqual_RightLabelSetting : CKJBaseRightLabelSetting

+ (instancetype)settingWithRightMargin:(nullable NSNumber *)rightMargin;

@end


/*
 
 NSArray *leftRightData = @[
     @{kOLR_Left_Title : @"就诊人：", kOLR_Right_Title : WDKJ_ConfirmString(@"张三")},
     @{kOLR_Left_Title : @"身份证号：", kOLR_Right_Title : WDCKJAttributed2(@"330501****3715", [UIColor blueColor], nil)},
     @{kOLR_Left_Title : @"就诊医院：", kOLR_Right_Title : @"上海交通大学医学院附属仁济医院东院（浦东新浦建路160号）"},
     @{kOLR_Left_Title : @"门诊科室：", kOLR_Right_Title : @"东院东消化科-幽门螺杆菌相关疾病 普通专病"},
     @{kOLR_Left_Title : @"就诊位置：", kOLR_Right_Title : @"上海市浦东新浦建路160号东外科大楼（7号楼1楼）"},
 ];
 
 _sec.modelArray = [CKJLeftRightCenterEqualCellModel centerEqualWithdics:leftRightData detail:^(CKJLeftRightCenterEqualCellModel * _Nonnull m) {
    [m _showLine:YES];
}];
 
 */

@interface CKJLeftRightCenterEqualCellModel : CKJBaseLeftRightCellModel

+ (NSMutableArray <CKJLeftRightCenterEqualCellModel *>*)centerEqualWithdics:(NSArray <NSDictionary <NSString *, id> *>*)dics detail:(void(^_Nullable)(CKJLeftRightCenterEqualCellModel *m))detail;

@end


@interface CKJLeftRightCenterEqualCell : CKJBaseLeftRightCell

@end

NS_ASSUME_NONNULL_END
