//
//  RJTopEqualVC.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/20.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "RJConfigVC.h"
#import "SelectDateCell.h"
#import "CKJLeftRightCell.h"

#import "RJBillDetailModel.h"
#import "RJBillCell.h"
#import "CKJRadioCell.h"

@interface RJConfigVC ()

/**
 2019-03-11 这样的格式
 */
@property (copy, nonatomic) NSString *beginDate;

@end

@implementation RJConfigVC


typedef NS_ENUM(NSUInteger, TestPayStyle) {
    TestPayStyle_AliPay,
    TestPayStyle_WeiXin,
    TestPayStyle_YinLian
};

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"自定义Cell、配置Cell、聚合Cell";
    
    [self initSimpleTableViewData];
    [self firstNetwork];
}

#pragma mark - CKJSimpleTableView 数据源 和 代理
- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues {
    SelectDateCellConfig *config1 = [SelectDateCellConfig configWithDetailSettingBlock:^(SelectDateCellConfig * _Nonnull m) {
        m.endDateUserInteractionEnabled = NO;
        m.beginDate = BeginDate_Today;
        m.endDate = EndDate_Today;
    }];
    
    CGFloat image_margin_title = 12;
    CGFloat centerMargin = 7;
    
    CKJFiveCellConfig *config2 = [CKJFiveCellConfig configWithDetailSettingBlock:^(CKJFiveCellConfig * _Nonnull m) {
        m.leftImageView_MarginToSuperViewLeft = 15;
        m.leftImageSize = CGSizeMake(50, 50);
        m.image_margin_title = image_margin_title;
        m.title_margin_subTitle = centerMargin;
    }];
    
    CKJLeftRightCellTopEqualConfig *config3 = [CKJLeftRightCellTopEqualConfig configWithLeftLabelTopMargin:2 detailSettingBlock:nil];
    
    CKJRadioCellConfig *radioConfig = [CKJRadioCellConfig configWithDetailSettingBlock:^(CKJRadioCellConfig * _Nonnull m) {
        // 下面这注释的设置了默认值， 需要修改的话可以自己设置
//        m.leftImageView_MarginToSuperViewLeft = 15;
//        m.leftImageSize = CGSizeMake(30, 30);
//        m.image_margin_title = 12;
//        m.title_margin_subTitle = 7;
        
//        m.radioBtn_leftMargin = 5;
//        m.radioBtn_rightMargin = 15;
        
        CGSize size = CGSizeMake(22, 22);
        
        m.normal_Image = [[UIImage kjwd_imageNamed:@"wdyhfsdk勾选空"] kjwd_scaleToSize:size];
        m.selected_Image = [[UIImage kjwd_imageNamed:@"wdyhfsdk勾选"] kjwd_scaleToSize:size];
        m.radioBtnSize = CGSizeMake(50, 44);
//        m.triggerStyle = CKJRadioCellTriggerStyle_SelectRadioBtn;
    }];
    
    return @{
             NSStringFromClass([RJBillCellModel class]) : @{cellKEY : NSStringFromClass([RJBillCell class]), isRegisterNibKEY : @YES},
             NSStringFromClass([CKJRadioCellModel class]) : @{cellKEY : NSStringFromClass([CKJRadioCell class]), isRegisterNibKEY : @NO, configDicKEY_ConfigModel : radioConfig},
             NSStringFromClass([SelectDateCellModel class]) : @{cellKEY : NSStringFromClass([SelectDateCell class]), isRegisterNibKEY : @NO, configDicKEY_ConfigModel : config1},
             NSStringFromClass([CKJFiveCellModel class]) : @{cellKEY : NSStringFromClass([CKJFiveCell class]), isRegisterNibKEY : @NO, configDicKEY_ConfigModel : config2},
             NSStringFromClass([CKJLeftRightCellModel class]) : @{cellKEY : NSStringFromClass([CKJLeftRightCell class]), isRegisterNibKEY : @NO, configDicKEY_ConfigModel : config3}
             };
}


- (void)kj_tableView:(CKJSimpleTableView *)tableView didSelectRowAtSection:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath model:(__kindof CKJCommonCellModel *)model cell:(__kindof CKJCommonTableViewCell *)cell {
    if ([model isKindOfClass:[CKJLeftRightCellModel class]]) {
        
        RJBillDetailModel *target = model.extension_Obj;
        
        NSLog(@"这几行每个都可以得到这个数据 %@ ", target);
    }
    
    
    if ([model isKindOfClass:[RJBillCellModel class]] == NO) return;
    
    KJ_typeweakself
    
    RJBillCellModel *m = model;
    
    m.selected = !m.selected;
    
    NSArray <__kindof CKJCommonCellModel *>*currentSectionAllCellModelArray = m.cell.currentSectionAllCellModelArray;
    void (^open)(BOOL open) = ^(BOOL open){
        [currentSectionAllCellModelArray kjwd_do_conformBlock:^BOOL(__kindof CKJCommonCellModel *obj, NSUInteger idx) {
            return (idx == 0) || (idx == 1);
        } handle:^(BOOL isConform, __kindof CKJCommonCellModel *obj, NSUInteger idx) {
            if (isConform == NO) {
                obj.displayInTableView = open;
            }
        }];
        [weakSelf.simpleTableView kjwd_reloadData];
    };
    
    if (currentSectionAllCellModelArray.count > 2) {
        open(m.selected);
    } else {
        
        NSLog(@"得到当前的账单ID 去网络请求 %@ ", m.BillId);
        
        NSDictionary *temp = [NSDictionary kjwd_readJsonDataFromLocalWithName:@"billDetail" type:@"geojson"];
        NSArray <NSDictionary *>*data = WDKJ_ConfirmArray(temp[@"result"]);
        
        NSArray <NSDictionary *>*result = data;
        
        NSMutableArray <__kindof CKJCommonCellModel *>*cellModels = [NSMutableArray array];
        [NSMutableArray kjwd_arrayWithKeyValuesArray:result modelClass:[RJBillDetailModel class] callBack:^(RJBillDetailModel *currentModel) {
            [cellModels kjwd_addObjectsFromArray:currentModel.combineCellModelsToArray];
        }];
        [weakSelf.simpleTableView appendCellModelArray:cellModels atLastRow_InAllCellModelArrayOfSection:m.cell.section];
        
        [weakSelf.simpleTableView kjwd_reloadData];
    }
}

- (void)initSimpleTableViewData {
    NSMutableArray <__kindof CKJCommonSectionModel *>*sections = [NSMutableArray array];
    
    {
        CKJCommonSectionModel *section = [CKJCommonSectionModel new];
        NSMutableAttributedString *header = WDCKJAttributed2(@"一般可以在returnCell_Model_keyValues里面进行对Cell初始化的配置，以统一配置不同的界面不同的风格情况， 比如下面的SelectDateCell可以配置开始和结束默认时间，以及CKJLeftRightCell居中对齐和顶部对齐。", [UIColor redColor], nil);
        [header appendAttributedString:WDCKJAttributed2(@"\n\n在本Demo中CKJCombineCellProtocol协议将几个CKJLeftRightCell聚合成一个虚拟的RJBillDetailCell，(本质上还是那几个CKJLeftRightCell)，\n要特别注意：这个协议仅仅是展示作用，如果虚拟的RJBillDetailCell想要在某一时刻修改内容，那么请自定义Cell!", [UIColor redColor], nil)];
        
        
        section.headerModel = [CKJTitleStyleHeaderFooterModel modelWithAttributedString:header type:CKJCommonHeaderFooterType_HEADER];
//        section.headerHeight = 100;
        
        section.footerHeight = 15;
        
        SelectDateCellModel *model1 = [SelectDateCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(SelectDateCellModel *m) {
            m.bgVColor = [UIColor groupTableViewBackgroundColor];
        } didSelectRowBlock:nil];
        
        CKJFiveCellModel *model2 = [CKJFiveCellModel modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(__kindof CKJFiveCellModel * _Nonnull m) {
            m.left_ImageName = [UIImage imageNamed:@"wdyhfsdk银联"];
            m.title = WDCKJAttributed2(@"银联", [UIColor kjwd_titleColor333333], nil);
            m.subTitle = WDCKJAttributed2(@"推荐有银联账户的用户使用", [UIColor kjwd_subTitleColor969696], nil);
            m.thirdTitle = WDCKJAttributed2(@"订单号：1c9f4d1cbe214ab6a948a1ab3ef5f1", [UIColor kjwd_subTitleColor969696], nil);
            m.fourthTitle = WDCKJAttributed2(@"总金额：29.30元", [UIColor kjwd_subTitleColor969696], nil);
            m.fifthTitle = WDCKJAttributed2(@"订单简介：门诊检查费", [UIColor kjwd_subTitleColor969696], nil);
        } didSelectRowBlock:nil];
        CKJFiveCellModel *model3 = [CKJFiveCellModel modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(__kindof CKJFiveCellModel * _Nonnull m) {
            m.left_ImageName = [UIImage imageNamed:@"wdyhfsdk银联"];
            m.title = WDCKJAttributed2(@"银联", [UIColor kjwd_titleColor333333], nil);
            m.subTitle = WDCKJAttributed2(@"推荐有银联账户的用户使用", [UIColor kjwd_subTitleColor969696], nil);
            m.thirdTitle = WDCKJAttributed2(@"订单号：1c9f4d1cbe214ab6a948a1ab3ef5f1", [UIColor kjwd_subTitleColor969696], nil);
            m.fourthTitle = WDCKJAttributed2(@"总金额：29.30元", [UIColor kjwd_subTitleColor969696], nil);
        } didSelectRowBlock:nil];
        CKJFiveCellModel *model4 = [CKJFiveCellModel modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(__kindof CKJFiveCellModel * _Nonnull m) {
            m.left_ImageName = [UIImage imageNamed:@"wdyhfsdk银联"];
            m.title = WDCKJAttributed2(@"银联", [UIColor kjwd_titleColor333333], nil);
            m.subTitle = WDCKJAttributed2(@"推荐有银联账户的用户使用", [UIColor kjwd_subTitleColor969696], nil);
            m.thirdTitle = WDCKJAttributed2(@"订单号：1c9f4d1cbe214ab6a948a1ab3ef5f1", [UIColor kjwd_subTitleColor969696], nil);
        } didSelectRowBlock:nil];
        CKJFiveCellModel *model5 = [CKJFiveCellModel modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(__kindof CKJFiveCellModel * _Nonnull m) {
            m.left_Image_URL = @"https://ps.ssl.qhmsg.com/sdr/400__/t01c8515616311ff6b9.jpg";
            m.placeholderImage = [UIImage kjwd_imageWithColor:[UIColor blueColor] size:CGSizeMake(100, 100)];
            m.title = WDCKJAttributed2(@"银联", [UIColor kjwd_titleColor333333], nil);
            m.subTitle = WDCKJAttributed2(@"推荐有银联账户的用户使用", [UIColor kjwd_subTitleColor969696], nil);
        } didSelectRowBlock:nil];
        
        
        CKJRadioCellModel *model6 = [CKJRadioCellModel modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(CKJRadioCellModel * _Nonnull m) {
            m.left_ImageName = [UIImage imageNamed:@"wdyhfsdk支付宝"];
            m.title = WDCKJAttributed2(@"支付宝", [UIColor kjwd_titleColor333333], nil);
            m.subTitle = WDCKJAttributed2(@"推荐有支付宝账户的用户使用", [UIColor kjwd_subTitleColor969696], nil);
            m.extension_Interger = TestPayStyle_AliPay;
        } didSelectRowBlock:nil];
        CKJRadioCellModel *model7 = [CKJRadioCellModel modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(CKJRadioCellModel * _Nonnull m) {
            m.left_ImageName = [UIImage imageNamed:@"wdyhfsdkechat"];
            m.title = WDCKJAttributed2(@"微信", [UIColor kjwd_titleColor333333], nil);
            m.subTitle = WDCKJAttributed2(@"推荐有微信账户的用户使用", [UIColor kjwd_subTitleColor969696], nil);
            m.extension_Interger = TestPayStyle_WeiXin;
        } didSelectRowBlock:nil];
        CKJRadioCellModel *model8 = [CKJRadioCellModel modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(CKJRadioCellModel * _Nonnull m) {
            m.left_ImageName = [UIImage imageNamed:@"wdyhfsdk银联"];
            m.title = WDCKJAttributed2(@"银联", [UIColor kjwd_titleColor333333], nil);
            m.subTitle = WDCKJAttributed2(@"推荐有银联账户的用户使用", [UIColor kjwd_subTitleColor969696], nil);
            m.extension_Interger = TestPayStyle_YinLian;
        } didSelectRowBlock:nil];
        
        CKJCellModel *model9 = [CKJCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(CKJCellModel *m) {
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed2(@"获取当前支付方式", [UIColor kjwd_titleColor333333], nil) left:15];
        } didSelectRowBlock:^(__kindof CKJCellModel * _Nonnull m) {
            CKJRadioCellModel *radio = m.cell.simpleTableView.currentSelectRadioCellModel;
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
        
        self.simpleTableView.radioCellModels = @[model6, model7, model8];
        
        section.modelArray = @[model1, model2, model3, model4, model5, model6, model7, model8, model9];
        [sections addObject:section];
    }
    
    self.simpleTableView.dataArr = sections;
    [self.simpleTableView kjwd_reloadData];
}

- (void)firstNetwork {
    KJ_typeweakself
    
    NSDictionary *temp = [NSDictionary kjwd_readJsonDataFromLocalWithName:@"billList" type:@"geojson"];
    NSArray <NSDictionary *>*data = WDKJ_ConfirmArray(temp[@"result"]);

    NSMutableArray <__kindof CKJCommonSectionModel *>*sections = [NSMutableArray array];
    
    [data enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]] == NO) return;
        CKJCommonSectionModel *section = [CKJCommonSectionModel new];
        section.footerHeight = 15;
    
        
        RJBillCellModel *model2 = [RJBillCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(RJBillCellModel * _Nonnull m) {
            [m kjwd_setValuesForKeysWithDictionary:obj];
        } didSelectRowBlock:nil];
        
        // 科室
        CKJTableViewCell1Model *model1 = [CKJTableViewCell1Model modelWithCellHeight:40 cellModel_id:nil detailSettingBlock:^(__kindof CKJTableViewCell1Model * _Nonnull m) {
            m.selectionStyle = UITableViewCellSelectionStyleNone;
            NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:WDKJ_ConfirmString(obj[@"DeptName"]) attributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:18]}];
            m.textLabelAttStr = att;
        } didSelectRowBlock:nil];
        
        section.modelArray = @[model1, model2];
        [sections addObject:section];
    }];
    
    [weakSelf.simpleTableView appendCKJCommonSectionModels:sections];
    [weakSelf.simpleTableView kjwd_reloadData];
    
}



@end
