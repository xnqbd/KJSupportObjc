//
//  DemoCoreCellVC.m
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/11/1.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "DemoCoreCellVC.h"

@interface DemoCoreCellVC ()

@end

@implementation DemoCoreCellVC

#define kPriceCellID 321

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"核心Cell代码示例";
    [self installComplementData];
}

#pragma mark - CKJSimpleTableView 数据源 和 代理
- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues:(CKJSimpleTableView *_Nonnull)s {
    
    CKJImageLeftCellConfig *leftConfig = [CKJImageLeftCellConfig configWithDetailSettingBlock:^(__kindof CKJImageLeftCellConfig * _Nonnull m) {
        m.imageSize = CGSizeMake(80, 80);
        m.fiveConfig = [CKJFiveLabelViewConfig configWithDetailSettingBlock:^(__kindof CKJFiveLabelViewConfig * _Nonnull m) {
            m.subTitle_numberOfLines = 3;
        }];
    }];
    
    return @{
        NSStringFromClass([CKJImageLeftCellModel class]) : @{cellKEY : NSStringFromClass([CKJImageLeftCell class]), isRegisterNibKEY : @NO, configDicKEY_ConfigModel : leftConfig},
    };
}

- (void)installComplementData {
    
    CKJCommonSectionModel *section1 = [CKJCommonSectionModel sectionWithHeaderAttString:WDCKJAttributed2(@"CKJImageLeftCell", [UIColor kjwd_subTitleColor969696], @14) headerAlignment:NSTextAlignmentLeft detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        CKJImageLeftCellModel *model1 = [CKJImageLeftCellModel modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(__kindof CKJImageLeftCellModel * _Nonnull m) {
            m.b_Image_URL = @"http://image.cmsfg.com/Images/20180608/2018060812432648.jpg";
            m.b_placeholderImage = [UIImage kjwd_imageNamed:@"占位图片.png"];
            [m updateFiveData:^(CKJFiveLabelModel * _Nonnull fm) {
               fm.title = WDCKJAttributed2(@"鼻饲流质", [UIColor kjwd_titleColor333333], nil);
                fm.subTitle = WDCKJAttributed2(@"鼻饲流质营养治疗适用于不能自行经口进食、昏迷、手术前后营养不良、食欲低下但有一定消化吸收功能者", [UIColor kjwd_subTitleColor969696], nil);
            }];
        } didSelectRowBlock:nil];
        _sec.modelArray = @[model1];
    }];
    
    CKJCommonSectionModel *section2 = [CKJCommonSectionModel sectionWithHeaderHeight:10 detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        CKJGeneralCellModel *model1 = [CKJGeneralCellModel modelWithCellHeight:44 cellModel_id:@(kPriceCellID) detailSettingBlock:^(__kindof CKJGeneralCellModel * _Nonnull m) {
            m.image2Model = [CKJImage2Model image2ModelWithImageString:@"demo余额.png" size:CGSizeMake(22, 22) left:15];
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed2(@"余额", [UIColor kjwd_titleColor333333], nil) left:10];
            m.likePrice8Model = [CKJLikePriceLabel8Model likePriceLabel8ModelWithAttText:WDCKJAttributed2(@"620.86元", [UIColor kjwd_subTitleColor969696], @14) left:0 right:0];
            m.arrow9Model = [CKJArrow9Model arrow9SystemModel];
        } didSelectRowBlock:^(__kindof CKJGeneralCellModel *__weak  _Nonnull m) {
           NSLog(@"点击了当前行");
        }];
        
        
        CKJCellModel *model2 = [CKJCellModel modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
            m.view5Model = [CKJView5Model view5ModelWithTopAttributedText:WDCKJAttributed2(@"开启常用地点入口", [UIColor kjwd_titleColor333333], @15) bottomAttributedText:WDCKJAttributed2(@"关闭后，将隐藏首页的常用地点入口", [UIColor kjwd_subTitleColor969696], @13) centerMarign:5 topBottomMargin:8 leftMargin:15 rightMargin:0];
            m.switch6Model = [CKJSwitch6Model switch6ModelWithSwitchOn:YES left:0 top:0 bottom:0 callBack:^(BOOL switchOn, CKJCellModel *cellModel, UISwitch *senderSwitch) {
                NSLog(@"检测到 开关按钮切换，此时状态是 %@ %@", cellModel.view5Model.topText.string, switchOn ? @"开启" : @"关闭");
            }];
            m.likePrice61Model = [CKJLikePriceLabel61Model likePriceModelWithLeftMargin:15];
        } didSelectRowBlock:nil];
        
        CKJTableViewCell1Model *model3 = [CKJTableViewCell1Model modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(__kindof CKJTableViewCell1Model * _Nonnull m) {
            m.textLabelAttStr = WDCKJAttributed2(@"点击本行更新余额", [UIColor kjwd_subTitleColor969696], nil);
            m.textAlignment = NSTextAlignmentCenter;
        } didSelectRowBlock:^(__kindof CKJTableViewCell1Model * _Nonnull m) {
            [m.cell.simpleTableView kjwd_filterCellModelForID:kPriceCellID finishBlock:^(CKJGeneralCellModel * _Nonnull m) {
                NSString *arc1 = [NSString kjwd_returnArc4randomWithNum:3 type:KJWDArc4randomType_Number];
                NSString *point = [NSString kjwd_returnArc4randomWithNum:2 type:KJWDArc4randomType_Number];
                [m.likePrice8Model changeText:[NSString stringWithFormat:@"%@.%@元", arc1, point]];
            }];
            [m.cell.simpleTableView kjwd_reloadData];
        }];
        _sec.modelArray = @[model1, model2, model3];
    }];
    self.simpleTableView.dataArr = @[section1, section2];
}

@end
