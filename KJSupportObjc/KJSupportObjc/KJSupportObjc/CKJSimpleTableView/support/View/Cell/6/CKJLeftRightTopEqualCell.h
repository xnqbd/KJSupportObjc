//
//  CKJLeftRightTopEqualCell.h
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/10/26.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseLeftRightCell.h"

NS_ASSUME_NONNULL_BEGIN

@class CKJLeftRightTopEqualCellModel;

typedef void(^CKJLeftRightTopEqualCellRowBlock)(__kindof CKJLeftRightTopEqualCellModel *_Nonnull m);



@interface CKJLeftRightTopEqual_LeftLabelSetting : CKJBaseLeftLabelSetting

/// leftLabel 和 SuperView 垂直方向之间的距离
@property (copy, nonatomic) NSNumber *leftLabel_TopMarginToSuperView;


@end


@interface CKJLeftRightTopEqual_RightLabelSetting : CKJBaseRightLabelSetting

/** rightLab 距离底部的距离，如果不设置此值，默认是7  */
@property (copy, nonatomic) NSNumber *rightLabel_BottomMarginToSuperView;


@end



/*

 NSArray *leftRightData = @[
     @{kOLR_Left_Title : @"就诊人：", kOLR_Right_Title : WDKJ_ConfirmString(@"张三")},
     @{kOLR_Left_Title : @"身份证号：", kOLR_Right_Title : WDCKJAttributed2(@"330501****3715", [UIColor blueColor], nil)},
     @{kOLR_Left_Title : @"就诊医院：", kOLR_Right_Title : @"上海交通大学医学院附属仁济医院东院（浦东新浦建路160号）"},
     @{kOLR_Left_Title : @"门诊科室：", kOLR_Right_Title : @"东院东消化科-幽门螺杆菌相关疾病 普通专病"},
     @{kOLR_Left_Title : @"就诊位置：", kOLR_Right_Title : @"上海市浦东新浦建路160号东外科大楼（7号楼1楼）"},
 ];
 _sec.modelArray = [CKJLeftRightTopEqualCellModel topEqualWithdics:leftRightData detail:^(CKJLeftRightTopEqualCellModel * _Nonnull m) {
     [m _showLine:NO];
     m.rightLab_textAlignment = NSTextAlignmentLeft;
     m.cellHeight = @(UITableViewAutomaticDimension);
 }];
 
 */

@interface CKJLeftRightTopEqualCellModel : CKJBaseLeftRightCellModel // <CKJLeftRightTopEqual_LeftLabelSetting *, CKJLeftRightTopEqual_RightLabelSetting *>

+ (NSMutableArray <CKJLeftRightTopEqualCellModel *>*)topEqualWithdics:(NSArray <NSDictionary <NSString *, id> *>*)dics detail:(void(^_Nullable)(CKJLeftRightTopEqualCellModel *m))detail;

- (void)updateSetting:(void(^_Nullable)(CKJLeftRightTopEqual_LeftLabelSetting *left, CKJLeftRightTopEqual_RightLabelSetting *right))setting;


@end


@interface CKJLeftRightTopEqualCell : CKJBaseLeftRightCell

@end

NS_ASSUME_NONNULL_END
