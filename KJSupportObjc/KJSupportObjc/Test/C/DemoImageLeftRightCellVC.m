//
//  DemoImageLeftRightCellVC.m
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/10/27.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "DemoImageLeftRightCellVC.h"

@interface DemoImageLeftRightCellVC ()

@end

@implementation DemoImageLeftRightCellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"CKJLeftRightCell示例";
    [self initSimpleTableViewData];
}

#pragma mark - CKJSimpleTableView 数据源 和 代理
//- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues:(CKJSimpleTableView *_Nonnull)s {
//    CKJLeftRightTopEqualCellConfig *topEqualCellConfig = [CKJLeftRightTopEqualCellConfig configWithLeftLabelTopMargin:5 detailSettingBlock:^(CKJLeftRightTopEqualCellConfig * _Nonnull m) {
//       m.leftLab_width = 80; // 左边UILabel固定宽度
//    }];
//    CKJLeftRightCenterEqualCellConfig *centerEqualCellConfig = [CKJLeftRightCenterEqualCellConfig configWithDetailSettingBlock:^(CKJLeftRightCenterEqualCellConfig * _Nonnull m) {
//        m.leftLab_width_MultipliedBySuperView = 0.3; // 左边UILabel宽度相对于父视图的宽度的倍数
//    }];
//    return @{
//        NSStringFromClass([CKJLeftRightTopEqualCellModel class]) : @{KJPrefix_cellKEY : NSStringFromClass([CKJLeftRightTopEqualCell class]), KJPrefix_isRegisterNibKEY : @NO, KJPrefix_configDicKEY_ConfigModel : topEqualCellConfig},
//        NSStringFromClass([CKJLeftRightCenterEqualCellModel class]) : @{KJPrefix_cellKEY : NSStringFromClass([CKJLeftRightCenterEqualCell class]), KJPrefix_isRegisterNibKEY : @NO, KJPrefix_configDicKEY_ConfigModel : centerEqualCellConfig},
//    };
//}

- (void)initSimpleTableViewData {
}
@end
