//
//  RJTestListVC.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/20.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "RJTestListVC.h"
#import "CKJImageLeftCell.h"
#import "CKJImageRightCell.h"
#import "CKJPayCell.h"

@interface RJTestListVC ()

@end

@implementation RJTestListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"列表";
    [self initSimpleTableViewData];
}

- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues:(CKJSimpleTableView *_Nonnull)s {
    return @{};
}

- (void)initSimpleTableViewData {
    
    NSMutableArray <__kindof CKJCommonSectionModel *>*sections = [NSMutableArray array];
    
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
    
    {
        CKJCommonSectionModel *section = [CKJCommonSectionModel new];
        section.headerModel = [CKJTitleStyleHeaderFooterModel modelWithAttributedString:WDCKJAttributed2(@"注意：如果是代码布局的Cell，请把子控件加入到CKJCommonTableViewCell.subviews_SuperView上", [UIColor redColor], nil) type:CKJCommonHeaderFooterType_HEADER];

        CKJCommonCellModel *model0 = block(@"CKJGeneralCell的用法Demo", @"CKJGeneralCellVC");

        CKJCommonCellModel *model1 = block(@"CKJCell的用法Demo", @"CKJCellVC");
        CKJCommonCellModel *model2 = block(@"自定义Cell、配置Cell、聚合Cell", @"RJConfigVC");
        
        CKJCommonCellModel *model3 = block(@"CKJBaseImageLeftRightCell及其子类", @"CKJImageLeftRightCellVC");

        CKJCommonCellModel *model4 = block(@"输入Cell", @"RJInputVC");
        CKJCommonCellModel *model5 = block(@"StackCell、ScrollViewCell示例1", @"RJSquareDemo1VC");
        
        CKJCommonCellModel *model6 = block(@"StackCell、ScrollViewCell示例2", @"RJSquareDemo2VC");
        
        section.modelArray = @[model0, model1, model2, model3, model4, model5, model6];
        [sections addObject:section];
    }
    
    self.simpleTableView.dataArr = sections;
    [self.simpleTableView kjwd_reloadData];
    
}





@end
