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
    
    CKJCellModel *(^block)(NSString *title, NSString *vcClass) = ^CKJCellModel *(NSString *title, NSString *vcClass) {
        
        CKJCellModel *model1 = [CKJCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed(title, leftDic) left:15];
            m.arrow9Model = arrow;
        } didSelectRowBlock:^(__kindof CKJCellModel * _Nonnull m) {
            UIViewController *vc = [[NSClassFromString(vcClass) alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        return model1;
    };
    
    {
        CKJCommonSectionModel *section = [CKJCommonSectionModel new];
        section.headerModel = [CKJTitleStyleHeaderFooterModel modelWithAttributedString:WDCKJAttributed2(@"注意：如果是代码布局的Cell，请把子控件加入到CKJCommonTableViewCell.bgV上，这是比较好的做法", [UIColor redColor], nil) type:CKJCommonHeaderFooterType_HEADER];

        CKJCellModel *model1 = block(@"CKJCell的用法Demo", @"RJSettingViewController");
        CKJCellModel *model2 = block(@"自定义Cell、配置Cell、聚合Cell", @"RJConfigVC");
        
        CKJCellModel *model3 = block(@"输入Cell", @"RJInputVC");
        CKJCellModel *model4 = block(@"StackCell、ScrollViewCell示例1", @"RJStackVC");
        
        CKJCellModel *model5 = block(@"StackCell、ScrollViewCell示例2", @"RJScrollViewCellVC");
        
        section.modelArray = @[model1, model2, model3, model4, model5];
        [sections addObject:section];
    }
    
    self.simpleTableView.dataArr = sections;
    [self.simpleTableView kjwd_reloadData];
}





@end
