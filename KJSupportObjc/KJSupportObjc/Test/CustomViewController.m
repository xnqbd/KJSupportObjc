//
//  CustomViewController.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/3/22.
//  Copyright © 2019年 Lyc. All rights reserved.
//

#import "CustomViewController.h"
#import "UIView+CKJDesingable.h"
#import "CKJSimpleTableView.h"
#import "CustomCell1.h"
#import "CustomCell2.h"
#import "CustomCell3.h"

@interface CustomViewController ()<CKJSimpleTableViewDataSource, CKJSimpleTableViewDelegate>

@property (weak, nonatomic) IBOutlet CKJSimpleTableView *simpleTableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = @"CKJSimpleTableView可以进行可视化约束";
    [self installSimpleTableViewData];
}

- (NSDictionary<NSString *,NSDictionary<NSString *,id> *> *)returnCell_Model_keyValues {
    return @{
             NSStringFromClass([CustomCell1Model class]) : @{cellKEY : NSStringFromClass([CustomCell1 class]), isRegisterNibKEY : @YES},
             NSStringFromClass([CustomCell2Model class]) : @{cellKEY : NSStringFromClass([CustomCell2 class]), isRegisterNibKEY : @NO},
             NSStringFromClass([CustomCell3Model class]) : @{cellKEY : NSStringFromClass([CustomCell3 class]), isRegisterNibKEY : @NO}
             };
}

- (void)installSimpleTableViewData {
    
    CGFloat leftMargin = 20;
    
    NSMutableArray <CKJCommonSectionModel *>*sections = [NSMutableArray array];
    {
        CKJCommonSectionModel *section = [CKJCommonSectionModel new];
        section.footerHeight = 15;

        NSMutableAttributedString *header = WDCKJAttributed2(@"CKJSimpleTableView可以进行可视化布局，默认情况下，CKJSimpleTableView的dataSource和delegate都是它本身，在进行可视化拖线的时候，要将UITableView的类名修改为CKJSimpleTableView，然后把simpleTableViewDataSource、simpleTableViewDelegate设置为当前控制器，或者用代码设置都可以。\n\n", [UIColor redColor], nil);

        [header appendAttributedString:WDCKJAttributed2(@"基类CKJCommonCellModel有一个displayInTableView属性，可以很方便的控制是否显示的屏幕上\n\n", [UIColor kjwd_r:118 g:149 b:157 alpha:1], nil)];
        [header appendAttributedString:WDCKJAttributed2(@"一般情况下一个CellModel对应一个Cell， 如下，具体看代码\nCustomCell1Model : CKJCommonCellModel\nCustomCell1 : CKJCommonTableViewCell", [UIColor blueColor], nil)];

        section.headerModel = [CKJTitleStyleHeaderFooterModel modelWithAttributedString:header type:CKJCommonHeaderFooterType_HEADER];


        CKJCellModel *model1 = [CKJCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(CKJCellModel *m) {
            m.selectionStyle = UITableViewCellSelectionStyleNone;
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed2(@"费用金额", [UIColor kjwd_titleColor333333], @15) left:leftMargin];
            m.likePrice7Model = [CKJLikePriceLabel7Model likePriceLabel7ModelWithAttributedText:WDCKJAttributed2(@"合计：￥100.00", [UIColor redColor], nil) top:0 bottom:0 right:leftMargin];
        } didSelectRowBlock:nil];

        section.modelArray = @[model1];

        [sections addObject:section];
    }
    
    
    CKJDidClickBtn8Handle btn8Handle = ^(CKJCell *cell, CKJBtn8Model *btn8Model) {
        btn8Model.selected = !btn8Model.selected;
        [cell.currentSectionAllCellModelArray enumerateObjectsUsingBlock:^(CKJCommonCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx != 0) {
                obj.displayInTableView = !btn8Model.selected;
            }
        }];
        [cell.simpleTableView kjwd_reloadData];
    };
    
    {
        CKJCommonSectionModel *section = [CKJCommonSectionModel new];
        section.footerHeight = 15;
        
        CKJCellModel *model0 = [CKJCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(CKJCellModel *m) {
            m.selectionStyle = UITableViewCellSelectionStyleNone;
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed2(@"2019-03-21 合计：￥23.10", [UIColor kjwd_titleColor333333], @15) left:leftMargin];
            m.btn8Model = [CKJBtn8Model btn8ModelWithNormalImage:@"yhf下箭头" size:CGSizeMake(20, 20) rightMargin:10 detailSettingBlock:^(CKJBtn8Model *sender) {
                sender.selectedImage = @"yhf下箭头";
                sender.userInteractionEnabled = NO;
            } didClickBtn8Handle:nil];
        } didSelectRowBlock:^(__kindof CKJCellModel * _Nonnull m) {
           btn8Handle(m.cell, m.btn8Model);
        }];
        
        
        CustomCell1Model *model1 = [CustomCell1Model modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(CustomCell1Model * _Nonnull m) {
            m.Date = @"2019-03-21 23:55:07";
            m.ItemName = @"低脂糖尿病称重饮食";
            m.Qty = @1;
            m.Amount = @20;
        } didSelectRowBlock:nil];
        CustomCell1Model *model2 = [CustomCell1Model modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(CustomCell1Model * _Nonnull m) {
            m.Date = @"2019-03-21 15:21:24";
            m.ItemName = @"饮食额外费用";
            m.Qty = @1.5;
            m.Amount = @1.5;
        } didSelectRowBlock:nil];
        CustomCell1Model *model3 = [CustomCell1Model modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(CustomCell1Model * _Nonnull m) {
            m.Date = @"2019-03-21 15:20:38";
            m.ItemName = @"饮食额外费用";
            m.Qty = @0.8;
            m.Amount = @0.8;
        } didSelectRowBlock:nil];
        CustomCell1Model *model4 = [CustomCell1Model modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(CustomCell1Model * _Nonnull m) {
            m.Date = @"2019-03-21 09:22:16";
            m.ItemName = @"饮食额外费用";
            m.Qty = @0.8;
            m.Amount = @0.8;
        } didSelectRowBlock:nil];
        
        section.modelArray = @[model0, model1, model2, model3, model4];
        
        [sections addObject:section];
    }
    {
        CKJCommonSectionModel *section = [CKJCommonSectionModel new];
        section.footerHeight = 15;
        
        CKJCellModel *model0 = [CKJCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(CKJCellModel *m) {
            m.selectionStyle = UITableViewCellSelectionStyleNone;
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed2(@"2019-03-20 合计：￥23.10", [UIColor kjwd_titleColor333333], @15) left:leftMargin];
            m.btn8Model = [CKJBtn8Model btn8ModelWithNormalImage:@"yhf下箭头" size:CGSizeMake(20, 20) rightMargin:10 detailSettingBlock:^(CKJBtn8Model *sender) {
                sender.selectedImage = @"yhf下箭头";
                sender.userInteractionEnabled = NO;
            } didClickBtn8Handle:nil];
        } didSelectRowBlock:^(__kindof CKJCellModel * _Nonnull m) {
            btn8Handle(m.cell, m.btn8Model);
        }];
        
        
        CustomCell1Model *model1 = [CustomCell1Model modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(CustomCell1Model * _Nonnull m) {
            m.Date = @"2019-03-20 23:55:07";
            m.ItemName = @"低脂糖尿病称重饮食";
            m.Qty = @1;
            m.Amount = @20;
        } didSelectRowBlock:nil];
        CustomCell1Model *model2 = [CustomCell1Model modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(CustomCell1Model * _Nonnull m) {
            m.Date = @"2019-03-20 15:21:24";
            m.ItemName = @"饮食额外费用";
            m.Qty = @1.5;
            m.Amount = @1.5;
        } didSelectRowBlock:nil];
        CustomCell1Model *model3 = [CustomCell1Model modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(CustomCell1Model * _Nonnull m) {
            m.Date = @"2019-03-20 15:20:38";
            m.ItemName = @"饮食额外费用";
            m.Qty = @0.8;
            m.Amount = @0.8;
        } didSelectRowBlock:nil];
        CustomCell1Model *model4 = [CustomCell1Model modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(CustomCell1Model * _Nonnull m) {
            m.Date = @"2019-03-20 09:22:16";
            m.ItemName = @"饮食额外费用";
            m.Qty = @0.8;
            m.Amount = @0.8;
        } didSelectRowBlock:nil];
        
        section.modelArray = @[model0, model1, model2, model3, model4];
        
        [sections addObject:section];
    }
    
    {
        CKJCommonSectionModel *section = [CKJCommonSectionModel new];
        
        NSMutableAttributedString *header = WDCKJAttributed2(@"CKJFiveCell有一个图片和5个UILabel，这5个Label从上到下排列，最上面的UILabel最不容易拉伸和压缩，最下面的最容易拉伸和压缩\n\n", [UIColor redColor], nil);
        [header appendAttributedString:WDCKJAttributed2(@"通常你只需要继承CKJFiveCell和CKJFiveCellModel，5个UILabel的间距你可以自己定义；注意：你要重写installData: section: row: selectIndexPath: tableView:方法设置图片\n\n", [UIColor redColor], nil)];
        [header appendAttributedString:WDCKJAttributed2(@"CKJFiveCell.m文件里有BOOL debug = NO;可以将其改为YES调试", [UIColor kjwd_r:118 g:149 b:157 alpha:1], @15)];

        section.headerModel = [CKJTitleStyleHeaderFooterModel modelWithAttributedString:header type:CKJCommonHeaderFooterType_HEADER];
        
        
        CustomCell2Model *model1 = [CustomCell2Model modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(CustomCell2Model *m) {
            m.image_Name = @"wdyhfsdkhospital";
            m.title = @"湖州市中心医院";
            m.subTitle = @"订单日期：2018-11-16 15:38:16";
        } didSelectRowBlock:nil];
        
        CustomCell2Model *model2 = [CustomCell2Model modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(CustomCell2Model *m) {
            m.image_Name = @"wdyhfsdkhospital";
            m.title = @"湖州市中心医院";
            m.subTitle = @"订单日期：2018-11-16 15:38:16";
            m.thirdTitle = @"订单号：1c9f4d1cbe214ab6a948a1ab3ef5f1";
        } didSelectRowBlock:nil];
        CustomCell2Model *model3 = [CustomCell2Model modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(CustomCell2Model *m) {
            m.image_Name = @"wdyhfsdkhospital";
            m.title = @"湖州市中心医院";
            m.subTitle = @"订单日期：2018-11-16 15:38:16";
            m.thirdTitle = @"订单号：1c9f4d1cbe214ab6a948a1ab3ef5f1";
            m.fourthTitle = @"总金额：29.30元";
        } didSelectRowBlock:nil];
        CustomCell2Model *model4 = [CustomCell2Model modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(CustomCell2Model *m) {
            m.image_Name = @"wdyhfsdkhospital";
            m.title = @"湖州市中心医院";
            m.subTitle = @"订单日期：2018-11-16 15:38:16";
            m.thirdTitle = @"订单号：1c9f4d1cbe214ab6a948a1ab3ef5f1";
            m.fourthTitle = @"总金额：29.30元";
            m.fifthTitle = @"订单简介：门诊检查费";
        } didSelectRowBlock:nil];
        
        // -----------------------分割
        CKJCommonCellModelRowBlock block = ^(CKJPayCellModel * _Nonnull m) {
            [((CKJPayCell *)m.cell) chooseBtnAction];
        };
        
        CustomCell3Model *model5 = [CustomCell3Model modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(CustomCell3Model *m) {
            m.image_Name = @"wdyhfsdk支付宝";
            m.title = @"支付宝";
            m.subTitle = @"推荐有支付宝账户的用户使用";
        } didSelectRowBlock:block];
        
        CustomCell3Model *model6 = [CustomCell3Model modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(CustomCell3Model *m) {
            m.image_Name = @"wdyhfsdkechat";
            m.title = @"微信";
            m.subTitle = @"推荐有微信账户的用户使用";
            m.thirdTitle = @"订单号：1c9f4d1cbe214ab6a948a1ab3ef5f1";
        } didSelectRowBlock:block];
        
        CustomCell3Model *model7 = [CustomCell3Model modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(CustomCell3Model *m) {
            m.image_Name = @"wdyhfsdk银联";
            m.title = @"银联";
            m.subTitle = @"推荐有银联账户的用户使用";
            m.thirdTitle = @"订单号：1c9f4d1cbe214ab6a948a1ab3ef5f1";
            m.fourthTitle = @"总金额：29.30元";
            m.fifthTitle = @"订单简介：门诊检查费";
        } didSelectRowBlock:block];
        
        
        section.modelArray = @[model1, model2, model3, model4, model5, model6, model7];
        
        self.simpleTableView.payCellModels = @[model5, model6, model7];
        
        [sections addObject:section];
    }
    
    
    self.simpleTableView.dataArr = sections;
    [self.simpleTableView kjwd_reloadData];
}
- (void)kj_tableView:(CKJSimpleTableView *)tableView didSelectRowAtSection:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath model:(__kindof CKJCommonCellModel *)model cell:(__kindof CKJCommonTableViewCell *)cell {
    NSLog(@"当前选中的支付方式是 %@ ", tableView.currentSelectPayCellModel.title);
}



@end
