//
//  DemoCKJLeftRightCellVC.m
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/10/26.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "DemoLeftRightCellVC.h"

@interface DemoLeftRightCellVC ()

@end

@implementation DemoLeftRightCellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"CKJLeftRightCell示例";
    [self initSimpleTableViewData];
}

#pragma mark - CKJSimpleTableView 数据源 和 代理

- (void)initSimpleTableViewData {
    
    NSArray *leftRightData = @[
        @{kOLR_Left_Title : @"就诊人：", kOLR_Right_Title : WDKJ_ConfirmString(@"张三")},
        @{kOLR_Left_Title : @"身份证号：", kOLR_Right_Title : WDCKJAttributed2(@"330501****3715", [UIColor blueColor], nil)},
        @{kOLR_Left_Title : @"就诊医院：", kOLR_Right_Title : @"上海交通大学医学院附属仁济医院东院（浦东新浦建路160号）"},
        @{kOLR_Left_Title : @"门诊科室：", kOLR_Right_Title : @"东院东消化科-幽门螺杆菌相关疾病 普通专病"},
        @{kOLR_Left_Title : @"就诊位置：", kOLR_Right_Title : @"上海市浦东新浦建路160号东外科大楼（7号楼1楼）"},
    ];
    
    CKJCommonSectionModel *section1 = [CKJCommonSectionModel sectionWithHeaderAttString:WDCKJAttributed2(@"CKJLeftRightTopEqualCell顶部对齐", [UIColor kjwd_subTitle], @14) headerAlignment:NSTextAlignmentLeft detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        _sec.modelArray = [CKJLeftRightTopEqualCellModel topEqualWithdics:leftRightData detail:^(CKJLeftRightTopEqualCellModel * _Nonnull m) {
            [m _showLine:NO];
            m.rightLab_textAlignment = NSTextAlignmentLeft;
            m.cellHeight = @(UITableViewAutomaticDimension);
        }];
    }];
    
    CKJCommonSectionModel *section2 = [CKJCommonSectionModel sectionWithHeaderAttString:WDCKJAttributed2(@"CKJLeftRightCenterEqualCell中心对齐", [UIColor kjwd_subTitle], @14) headerAlignment:NSTextAlignmentLeft detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        _sec.modelArray = [CKJLeftRightCenterEqualCellModel centerEqualWithdics:leftRightData detail:^(CKJLeftRightCenterEqualCellModel * _Nonnull m) {
            [m _showLine:YES];
        }];
    }];
    
    self.simpleTableView.dataArr = @[section1, section2];
}




@end
