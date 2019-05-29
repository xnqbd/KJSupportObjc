//
//  RJTestListVC.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/20.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "RJTestListVC.h"

@interface RJTestListVC ()

@end

@implementation RJTestListVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"列表";
    [self initSimpleTableViewData];
}

- (void)initSimpleTableViewData {
    
    CKJArrow9Model *arrow = [CKJArrow9Model arrow9ModelWithImage:[[UIImage kjwd_imageNamed:@"wdyhfsdkright arrow"] kjwd_scaleToSize:CGSizeMake(15, 18)] right:nil];
    
    NSMutableArray <__kindof CKJCommonSectionModel *>*sections = [NSMutableArray array];
    NSDictionary *leftDic = @{NSForegroundColorAttributeName : [UIColor kjwd_titleColor333333]};
    
    KJ_typeweakself
    
    void(^block)(NSString *vcClass) = ^(NSString *vcClass) {
        UIViewController *vc = [[NSClassFromString(vcClass) alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    CGFloat leftMarign = 15;
    {
        CKJCommonSectionModel *section = [CKJCommonSectionModel new];
        section.headerModel = [CKJTitleStyleHeaderFooterModel modelWithAttributedString:WDCKJAttributed2(@"注意：如果是代码布局的Cell，请把子控件加入到CKJCommonTableViewCell.bgV上，这是比较好的做法", [UIColor redColor], nil) type:CKJCommonHeaderFooterType_HEADER];
        
        
        CKJCellModel *model1 = [CKJCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed(@"CKJCell的用法Demo", leftDic) left:leftMarign];
            m.arrow9Model = arrow;
        } didSelectRowBlock:^(__kindof CKJCellModel * _Nonnull m) {
            block(@"RJSettingViewController");
        }];
        CKJCellModel *model2 = [CKJCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed(@"自定义Cell、配置Cell、聚合Cell", leftDic) left:leftMarign];
            m.arrow9Model = arrow;
        } didSelectRowBlock:^(__kindof CKJCellModel * _Nonnull m) {
            block(@"RJConfigVC");
        }];
        CKJCellModel *model3 = [CKJCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed(@"输入Cell", leftDic) left:leftMarign];
            m.arrow9Model = arrow;
        } didSelectRowBlock:^(__kindof CKJCellModel * _Nonnull m) {
            block(@"RJInputVC");
        }];
        CKJCellModel *model4 = [CKJCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed(@"CKJStackCell", leftDic) left:leftMarign];
            m.arrow9Model = arrow;
        } didSelectRowBlock:^(__kindof CKJCellModel * _Nonnull m) {
            block(@"RJStackVC");
        }];

        section.modelArray = @[model1, model2, model3, model4];
        [sections addObject:section];
    }
    
    self.simpleTableView.dataArr = sections;
    [self.simpleTableView kjwd_reloadData];
}


@end
