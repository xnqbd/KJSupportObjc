//
//  CKJImageLeftRightCellVC.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/7/9.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJImageLeftRightCellVC.h"

@interface CKJImageLeftRightCellVC ()

@end

@implementation CKJImageLeftRightCellVC

typedef NS_ENUM(NSUInteger, TestPayStyle) {
    TestPayStyle_AliPay,
    TestPayStyle_WeiXin,
    TestPayStyle_YinLian
};


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"CKJImageLeftRightCell示例";
    
    
    [self initSimpleTableViewData];
    
}

#pragma mark - CKJSimpleTableView 数据源 和 代理
- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues:(CKJSimpleTableView *_Nonnull)s {
    
    CKJImageLeftCellConfig *leftConfig = [CKJImageLeftCellConfig imageLeftCellConfigWithDetail:^(__kindof CKJImageLeftCellConfig * _Nonnull m) {
        [m updateImgConfig:^(CKJImageViewConfig * _Nonnull c) {
            c.imageSize = CGSizeMake(80, 80);
        }];
        m.fiveConfig = [CKJFiveLabelViewConfig fiveLabelViewConfigWithDetail:^(__kindof CKJFiveLabelViewConfig * _Nonnull m) {
            m.subTitle_numberOfLines = 3;
        }];
    }];
    CKJImageRightCellConfig *rightConfig = [CKJImageRightCellConfig imageRightCellConfigWithDetail:^(__kindof CKJImageRightCellConfig * _Nonnull m) {
        [m updateImgConfig:^(CKJImageViewConfig * _Nonnull c) {
            c.imageSize = CGSizeMake(80, 90);
        }];
        m.fiveConfig = [CKJFiveLabelViewConfig fiveLabelViewConfigWithDetail:^(__kindof CKJFiveLabelViewConfig * _Nonnull m) {
            m.title_margin_subTitle = 5;
            m.subTitle_numberOfLines = 3;
        }];
    }];
    
    CKJPayCellConfig *payConfig = [CKJPayCellConfig appearanceForProject];
    
    return @{
        NSStringFromClass([CKJPayCellModel class]) : @{KJPrefix_cellKEY : NSStringFromClass([CKJPayCell class]), KJPrefix_isRegisterNibKEY : @NO, KJPrefix_configDicKEY_ConfigModel : payConfig},
        
        NSStringFromClass([CKJImageLeftCellModel class]) : @{KJPrefix_cellKEY : NSStringFromClass([CKJImageLeftCell class]), KJPrefix_isRegisterNibKEY : @NO, KJPrefix_configDicKEY_ConfigModel : leftConfig},
        NSStringFromClass([CKJImageRightCellModel class]) : @{KJPrefix_cellKEY : NSStringFromClass([CKJImageRightCell class]), KJPrefix_isRegisterNibKEY : @NO, KJPrefix_configDicKEY_ConfigModel : rightConfig},
    };
}

- (void)initSimpleTableViewData {
    
//    CKJCommonSectionModel *section1 = [CKJCommonSectionModel sectionWithDetail:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
//
//        CKJPayCellModel *model1 = [CKJPayCellModel modelWithCellHeight:@(UITableViewAutomaticDimension) cellModel_id:nil detailSettingBlock:^(__kindof CKJPayCellModel * _Nonnull m) {
//
//            m.b_ImageName = [UIImage kjwd_imageWithColor:[UIColor redColor] size:CGSizeMake(40, 40)];
//            [m updateFiveData:^(CKJFiveLabelModel * _Nonnull fm) {
//                fm.title = WDCKJAttributed2(@"标题", [UIColor kjwd_title], nil);
//                fm.subTitle = WDCKJAttributed2(@"少时诵诗书", [UIColor kjwd_subTitle], nil);
//                fm.threeTitle = WDCKJAttributed2(@"额外信息1额外信息1额外信息1额外信息1额外信息1额外信息1额外信息1", [UIColor kjwd_subTitle], nil);
//            }];
//        } didSelectRowBlock:nil];
//
//        __weak CKJPayCellModel *weakModel1 = model1;
//
//        CKJTableViewCell1Model *model2 = [CKJTableViewCell1Model baseTableViewCellWithCellHeight:@(UITableViewAutomaticDimension) cellModel_id:nil detailSettingBlock:^(__kindof CKJTableViewCell1Model * _Nonnull m) {
//            m.attText = WDAtt15_5(@"点击展开");
//        } didSelectRowBlock:^(__kindof CKJTableViewCell1Model * _Nonnull m) {
//            weakModel1.displayInTableView = YES;
//            [m.cell.simpleTableView reloadData];
//        }];
//
//        CKJTableViewCell1Model *model3 = [CKJTableViewCell1Model baseTableViewCellWithCellHeight:@(UITableViewAutomaticDimension) cellModel_id:nil detailSettingBlock:^(__kindof CKJTableViewCell1Model * _Nonnull m) {
//            m.attText = WDAtt15_5(@"点击隐藏");
//        } didSelectRowBlock:^(__kindof CKJTableViewCell1Model * _Nonnull m) {
//            weakModel1.displayInTableView = NO;
//            [m.cell.simpleTableView reloadData];
//        }];
//
//        [self.simpleTableView addRadioCellModels:@[model1]];
//
//
//        _sec.modelArray = @[model1, model2, model3];
//    }];
    
    CKJCommonSectionModel *section2 = [CKJCommonSectionModel sectionWithHeaderAttString:WDCKJAttributed2(@"CKJImageLeftCell", [UIColor kjwd_subTitle], @14) headerAlignment:NSTextAlignmentLeft detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        CKJImageLeftCellModel *model1 = [CKJImageLeftCellModel imageLeftWithCellHeight:@(UITableViewAutomaticDimension) cellModel_id:nil detailSettingBlock:^(__kindof CKJImageLeftCellModel * _Nonnull m) {
            m.b_ImageName = [UIImage imageNamed:@"wdyhfsdk银联"];
            [m updateFiveData:^(CKJFiveLabelModel * _Nonnull fm) {
                fm.title = WDCKJAttributed2(@"银联", [UIColor kjwd_title], nil);
                fm.subTitle = WDCKJAttributed2(@"推荐有银联账户的用户使用", [UIColor kjwd_subTitle], nil);
                fm.threeTitle = WDCKJAttributed2(@"订单号：1c9f4d1cbe214ab6a948a1ab3ef5f1", [UIColor kjwd_subTitle], nil);
                fm.fourTitle = WDCKJAttributed2(@"总金额：29.30元", [UIColor kjwd_subTitle], nil);
                fm.fiveTitle = WDCKJAttributed2(@"订单简介：门诊检查费", [UIColor kjwd_subTitle], nil);
            }];
        } didSelectRowBlock:nil];
        
        CKJImageLeftCellModel *model2 = [CKJImageLeftCellModel imageLeftWithCellHeight:@(UITableViewAutomaticDimension) cellModel_id:nil detailSettingBlock:^(__kindof CKJImageLeftCellModel * _Nonnull m) {
            m.b_Image_URL = @"http://image.cmsfg.com/Images/20180608/2018060812432648.jpg";
            [m updateFiveData:^(CKJFiveLabelModel * _Nonnull fm) {
               fm.title = WDCKJAttributed2(@"鼻饲流质", [UIColor kjwd_title], nil);
                fm.subTitle = WDCKJAttributed2(@"鼻饲流质营养治疗适用于不能自行经口进食、昏迷、手术前后营养不良、食欲低下但有一定消化吸收功能者", [UIColor kjwd_subTitle], nil);
            }];
        } didSelectRowBlock:nil];
        _sec.modelArray = @[model1, model2];
    }];
    
    
    CKJCommonSectionModel *section3 = [CKJCommonSectionModel sectionWithHeaderAttString:WDCKJAttributed2(@"CKJImageRightCell", [UIColor kjwd_subTitle], @14) headerAlignment:NSTextAlignmentLeft detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        CKJImageRightCellModel *model1 = [CKJImageRightCellModel imageRightWithCellHeight:@(UITableViewAutomaticDimension) cellModel_id:nil detailSettingBlock:^(__kindof CKJImageRightCellModel * _Nonnull m) {
            m.b_ImageName = [UIImage imageNamed:@"wdyhfsdk银联"];
            [m updateFiveData:^(CKJFiveLabelModel * _Nonnull fm) {
                fm.title = WDCKJAttributed2(@"银联", [UIColor kjwd_title], nil);
                fm.subTitle = WDCKJAttributed2(@"推荐有银联账户的用户使用", [UIColor kjwd_subTitle], nil);
                fm.threeTitle = WDCKJAttributed2(@"订单号：1c9f4d1cbe214ab6a948a1ab3ef5f1", [UIColor kjwd_subTitle], nil);
                fm.fourTitle = WDCKJAttributed2(@"总金额：29.30元", [UIColor kjwd_subTitle], nil);
                fm.fiveTitle = WDCKJAttributed2(@"订单简介：门诊检查费", [UIColor kjwd_subTitle], nil);
            }];
        } didSelectRowBlock:nil];
        
        CKJImageRightCellModel *model2 = [CKJImageRightCellModel imageRightWithCellHeight:@(UITableViewAutomaticDimension) cellModel_id:nil detailSettingBlock:^(__kindof CKJImageRightCellModel * _Nonnull m) {
            m.b_Image_URL = @"http://image.cmsfg.com/Images/20180608/2018060812432648.jpg";
            [m updateFiveData:^(CKJFiveLabelModel * _Nonnull fm) {
               fm.title = WDCKJAttributed2(@"鼻饲流质", [UIColor kjwd_title], nil);
                fm.subTitle = WDCKJAttributed2(@"鼻饲流质营养治疗适用于不能自行经口进食、昏迷、手术前后营养不良、食欲低下但有一定消化吸收功能者", [UIColor kjwd_subTitle], nil);
            }];
        } didSelectRowBlock:nil];
        _sec.modelArray = @[model1, model2];
    }];
    
    CKJCommonSectionModel *section4 = [CKJCommonSectionModel sectionWithHeaderAttString:WDCKJAttributed2(@"CKJPayCell 单选", [UIColor kjwd_subTitle], @14) headerAlignment:NSTextAlignmentLeft detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        
        CKJPayCellModel *model6 = [CKJPayCellModel payWithCellHeight:@(UITableViewAutomaticDimension) cellModel_id:nil detailSettingBlock:^(__kindof CKJPayCellModel * _Nonnull m) {
            m.b_ImageName = [UIImage imageNamed:@"wdyhfsdk支付宝"];
            [m updateFiveData:^(CKJFiveLabelModel * _Nonnull fm) {
                fm.title = WDCKJAttributed2(@"支付宝", [UIColor kjwd_title], nil);
                fm.subTitle = WDCKJAttributed2(@"推荐有支付宝账户的用户使用", [UIColor kjwd_subTitle], nil);
            }];
            m.extension_Interger = TestPayStyle_AliPay;
        } didSelectRowBlock:nil];
        
        CKJPayCellModel *model7 = [CKJPayCellModel payWithCellHeight:@(UITableViewAutomaticDimension) cellModel_id:nil detailSettingBlock:^(__kindof CKJPayCellModel * _Nonnull m) {
            m.b_ImageName = [UIImage imageNamed:@"wdyhfsdkechat"];
            [m updateFiveData:^(CKJFiveLabelModel * _Nonnull fm) {
                fm.title = WDCKJAttributed2(@"微信", [UIColor kjwd_title], nil);
                fm.subTitle = WDCKJAttributed2(@"推荐有微信账户的用户使用", [UIColor kjwd_subTitle], nil);
                fm.threeTitle = WDCKJAttributed2(@"额外信息1额外信息1额外信息1额外信息1额外信息1额外信息1额外信息1", [UIColor kjwd_subTitle], nil);
            }];
            m.extension_Interger = TestPayStyle_WeiXin;
        } didSelectRowBlock:nil];
        

        CKJPayCellModel *model8 = [CKJPayCellModel payWithCellHeight:@(UITableViewAutomaticDimension) cellModel_id:nil detailSettingBlock:^(__kindof CKJPayCellModel * _Nonnull m) {
            m.b_ImageName = [UIImage imageNamed:@"wdyhfsdk银联"];
            [m updateFiveData:^(CKJFiveLabelModel * _Nonnull fm) {
                fm.title = WDCKJAttributed2(@"银联", [UIColor kjwd_title], nil);
                fm.subTitle = WDCKJAttributed2(@"推荐有银联账户的用户使用", [UIColor kjwd_subTitle], nil);
                fm.threeTitle = WDCKJAttributed2(@"额外信息1额外信息1额外信息1额外信息1额外信息1额外信息1额外信息1", [UIColor kjwd_subTitle], nil);
                fm.fourTitle = WDCKJAttributed2(@"额外信息22额外信息22额外信息22额外信息22额外信息22额外信息22额外信息22额外信息22额外信息22", [UIColor kjwd_subTitle], nil);
            }];
            m.extension_Interger = TestPayStyle_YinLian;
        } didSelectRowBlock:nil];
        
        CKJGeneralCellModel *model9 = [CKJGeneralCellModel generalWithCellHeight:@44 cellModel_id:nil detailSettingBlock:^(CKJGeneralCellModel *m) {
            m.title3Model = [CKJTitle3Model title3ModelWithText:WDCKJAttributed2(@"获取当前支付方式", [UIColor kjwd_title], nil) left:15];
        } didSelectRowBlock:^(__kindof CKJGeneralCellModel * _Nonnull m) {
            CKJCommonCellModel *radio = m.cell.simpleTableView.currentSelectRadioCellModel;
            // 需要判断空的情况
            if (radio != nil) {
                switch (radio.extension_Interger) {
                    case TestPayStyle_AliPay:
                        NSLog(@"支付宝");
                        break;
                    case TestPayStyle_WeiXin:
                        NSLog(@"微信");
                        break;
                    case TestPayStyle_YinLian:
                        NSLog(@"银联");
                        break;
                    default:
                        NSLog(@"未知");
                        break;
                }
            }
        }];
        [self.simpleTableView addRadioCellModels:@[model6, model7, model8]];
        
        _sec.modelArray = @[model6, model7, model8/*, model9*/];
    }];
    
    self.simpleTableView.dataArr = @[/*section1,*/ section2, section3, section4];
    [self.simpleTableView kjwd_reloadData];
}


@end
