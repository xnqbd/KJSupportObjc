//
//  KJSupportObjcListVC.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/20.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "KJSupportObjcListVC.h"
#import "CKJImageLeftCell.h"
#import "CKJImageRightCell.h"
#import "CKJPayCell.h"
#import "TableViewCellDemoVC.h"

@interface KJSupportObjcListVC ()

@end

@implementation KJSupportObjcListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"列表";
    [self initSimpleTableViewData];
}

- (void)initSimpleTableViewData {
    
    KJ_typeweakself
    
    CKJGeneralCellModel *(^block)(NSString *title, NSString *vcClass) = ^CKJGeneralCellModel *(NSString *title, NSString *vcClass) {
        
        CKJGeneralCellModel *model1 = [CKJGeneralCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(__kindof CKJGeneralCellModel * _Nonnull m) {
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed2(title, [UIColor kjwd_titleColor333333], @16) left:15];
            m.arrow9Model = [CKJArrow9Model arrow9SystemModel];
        } didSelectRowBlock:^(__kindof CKJGeneralCellModel * _Nonnull m) {
            UIViewController *vc = [[NSClassFromString(vcClass) alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        return model1;
    };
    
    
    CKJCommonSectionModel *section1 = [CKJCommonSectionModel sectionWithHeaderAttString:WDCKJAttributed2(@"注意：如果是代码布局的Cell，请把子控件加入到CKJCommonTableViewCell.subviews_SuperView上", [UIColor redColor], nil) headerAlignment:NSTextAlignmentLeft detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        
        CKJCommonCellModel *model0 = block(@"CKJGeneralCell示例", @"CKJGeneralCellVC");
        
        CKJCommonCellModel *model1 = block(@"CKJCell示例", @"CKJCellVC");
        
        CKJCommonCellModel *model3 = block(@"CKJImageLeftRightCell示例", @"CKJImageLeftRightCellVC");
        
        CKJCommonCellModel *model5 = block(@"StackCell、ScrollViewCell示例1", @"RJSquareDemo1VC");
        
        CKJCommonCellModel *model6 = block(@"StackCell、ScrollViewCell示例2", @"RJSquareDemo2VC");
        CKJCommonCellModel *model7 = block(@"CKJTableViewCell示例", @"TableViewCellDemoVC");
        CKJCommonCellModel *model8 = block(@"CKJLeftRightCell示例", @"DemoLeftRightCellVC");
        
        _sec.modelArray = @[model0, model1, model3, model5, model6, model7, model8];
    }];
    
    CKJCommonSectionModel *section2 = [CKJCommonSectionModel sectionWithHeaderHeight:10 detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        CKJCommonCellModel *model0 = block(@"注册", @"RegisterDemoVC");
        CKJCommonCellModel *model1 = block(@"添加联系人", @"InputDemoVC");
        CKJCommonCellModel *model2 = block(@"联系人信息", @"PersonInfoDemoVC");
        
        _sec.modelArray = @[model0, model1, model2];
    }];
    CKJCommonSectionModel *section3 = [CKJCommonSectionModel sectionWithHeaderHeight:10 detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        CKJCommonCellModel *model0 = block(@"核心CellDemo", @"DemoCoreCellVC");
        _sec.modelArray = @[model0];
    }];
    
    
    CKJCommonSectionModel *section4 = [CKJCommonSectionModel sectionWithHeaderAttString:WDCKJAttributed2(@"一些其他的", [UIColor kjwd_subTitleColor969696], nil) headerAlignment:NSTextAlignmentLeft detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        CKJCommonCellModel *model1 = block(@"自定义Cell、配置Cell、聚合Cell", @"RJConfigVC");
        _sec.modelArray = @[model1];
    }];
    
    self.simpleTableView.dataArr = @[section1, section2, section3, section4];
    [self.simpleTableView kjwd_reloadData];
}





@end
