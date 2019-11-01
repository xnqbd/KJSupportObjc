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
- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues:(CKJSimpleTableView *_Nonnull)s {
    CKJLeftRightTopEqualCellConfig *topEqualCellConfig = [CKJLeftRightTopEqualCellConfig configWithLeftLabelTopMargin:5 detailSettingBlock:^(CKJLeftRightTopEqualCellConfig * _Nonnull m) {
       m.leftLab_width = 80; // 左边UILabel固定宽度
    }];
    CKJLeftRightCenterEqualCellConfig *centerEqualCellConfig = [CKJLeftRightCenterEqualCellConfig configWithDetailSettingBlock:^(CKJLeftRightCenterEqualCellConfig * _Nonnull m) {
        m.leftLab_width_MultipliedBySuperView = 0.3; // 左边UILabel宽度相对于父视图的宽度的倍数
    }];
    return @{
        NSStringFromClass([CKJLeftRightTopEqualCellModel class]) : @{cellKEY : NSStringFromClass([CKJLeftRightTopEqualCell class]), isRegisterNibKEY : @NO, configDicKEY_ConfigModel : topEqualCellConfig},
        NSStringFromClass([CKJLeftRightCenterEqualCellModel class]) : @{cellKEY : NSStringFromClass([CKJLeftRightCenterEqualCell class]), isRegisterNibKEY : @NO, configDicKEY_ConfigModel : centerEqualCellConfig},
    };
}

- (void)initSimpleTableViewData {
    CGFloat margin = 20;
    CKJLeftRightTopEqualCellModel *(^createTopEqualModel)(NSString *left, NSString *right) = ^CKJLeftRightTopEqualCellModel *(NSString *left, NSString *right) {
        CKJLeftRightTopEqualCellModel *model1 = [CKJLeftRightTopEqualCellModel modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(__kindof CKJLeftRightTopEqualCellModel * _Nonnull m) {
            m.showLine = YES;
            m.rightLab_textAlignment = NSTextAlignmentLeft;
            m.leftAttStr = WDCKJAttributed2(left, [UIColor kjwd_titleColor333333], nil);
            m.rightAttStr = WDCKJAttributed2(right, [UIColor kjwd_subTitleColor969696], nil);
            m.leftLab_MarginTo_SuperViewLeft = margin;
            m.rightLab_MarginTo_SuperViewRight = margin;
        } didSelectRowBlock:nil];
        return model1;
    };
    
    CKJLeftRightCenterEqualCellModel *(^createCenterEqualModel)(NSString *left, NSString *right) = ^CKJLeftRightCenterEqualCellModel *(NSString *left, NSString *right) {
        CKJLeftRightCenterEqualCellModel *model1 = [CKJLeftRightCenterEqualCellModel modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(__kindof CKJLeftRightCenterEqualCellModel * _Nonnull m) {
            m.showLine = YES;
            m.rightLab_textAlignment = NSTextAlignmentRight;
            m.leftAttStr = WDCKJAttributed2(left, [UIColor kjwd_titleColor333333], nil);
            m.rightAttStr = WDCKJAttributed2(right, [UIColor kjwd_subTitleColor969696], nil);
            m.leftLab_MarginTo_SuperViewLeft = margin;
            m.rightLab_MarginTo_SuperViewRight = margin;
        } didSelectRowBlock:nil];
        return model1;
    };
    CKJCommonSectionModel *section1 = [CKJCommonSectionModel sectionWithHeaderAttString:WDCKJAttributed2(@"CKJLeftRightTopEqualCell顶部对齐", [UIColor kjwd_subTitleColor969696], @14) headerAlignment:NSTextAlignmentLeft detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        CKJLeftRightTopEqualCellModel *model1 = createTopEqualModel(@"就诊人：", @"张三");
        CKJLeftRightTopEqualCellModel *model2 = createTopEqualModel(@"身份证号：", @"330501****3715");
        CKJLeftRightTopEqualCellModel *model3 = createTopEqualModel(@"就诊医院：", @"上海交通大学医学院附属仁济医院东院（浦东新浦建路160号）");
        CKJLeftRightTopEqualCellModel *model4 = createTopEqualModel(@"门诊科室：", @"东院东消化科-幽门螺杆菌相关疾病 普通专病");
        CKJLeftRightTopEqualCellModel *model5 = createTopEqualModel(@"就诊位置：", @"上海市浦东新浦建路160号东外科大楼（7号楼1楼）");
        _sec.modelArray = @[model1, model2, model3, model4, model5];
    }];
    
    CKJCommonSectionModel *section2 = [CKJCommonSectionModel sectionWithHeaderAttString:WDCKJAttributed2(@"CKJLeftRightCenterEqualCell中心对齐", [UIColor kjwd_subTitleColor969696], @14) headerAlignment:NSTextAlignmentLeft detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {

        CKJLeftRightCenterEqualCellModel *model1 = createCenterEqualModel(@"就诊人：", @"张三");
        CKJLeftRightCenterEqualCellModel *model2 = createCenterEqualModel(@"身份证号：", @"330501****3715");
        CKJLeftRightCenterEqualCellModel *model3 = createCenterEqualModel(@"就诊医院：", @"上海交通大学医学院附属仁济医院东院（浦东新浦建路160号）");
        CKJLeftRightCenterEqualCellModel *model4 = createCenterEqualModel(@"门诊科室：", @"东院东消化科-幽门螺杆菌相关疾病 普通专病");
        CKJLeftRightCenterEqualCellModel *model5 = createCenterEqualModel(@"就诊位置：", @"上海市浦东新浦建路160号东外科大楼（7号楼1楼）");
        _sec.modelArray = @[model1, model2, model3, model4, model5];
    }];
    
    self.simpleTableView.dataArr = @[section1, section2];
}




@end
