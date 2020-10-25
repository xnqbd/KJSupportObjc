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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"部分Cell代码示例";
    [self installComplementData];
}

#define kPriceCellID @"kPriceCellID"

#pragma mark - CKJSimpleTableView 数据源 和 代理
- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues:(CKJSimpleTableView *_Nonnull)s {
    // 有些KJSupportObjc库系统的Cell可以进行在这里配置
    CKJImageLeftCellConfig *leftConfig = [CKJImageLeftCellConfig imageLeftCellConfigWithDetail:^(__kindof CKJImageLeftCellConfig * _Nonnull m) {
        [m updateImgConfig:^(CKJImageViewConfig * _Nonnull c) {
            c.imageSize = CGSizeMake(80, 80);
        }];
        m.fiveConfig = [CKJFiveLabelViewConfig fiveLabelViewConfigWithDetail:^(__kindof CKJFiveLabelViewConfig * _Nonnull m) {
            m.subTitle_numberOfLines = 3;
        }];
    }];
    return @{
        NSStringFromClass([CKJImageLeftCellModel class]) : @{KJPrefix_cellKEY : NSStringFromClass([CKJImageLeftCell class]), KJPrefix_isRegisterNibKEY : @NO, KJPrefix_configDicKEY_ConfigModel : leftConfig},
    };
}

- (void)installComplementData {
    
    CKJCommonSectionModel *section1 = [CKJCommonSectionModel sectionWithHeaderHeight:@10 detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        CKJImageLeftCellModel *model1 = [CKJImageLeftCellModel imageLeftWithCellHeight:@(UITableViewAutomaticDimension) cellModel_id:nil detailSettingBlock:^(__kindof CKJImageLeftCellModel * _Nonnull m) {
            m.b_Image_URL = @"http://image.cmsfg.com/Images/20180608/2018060812432648.jpg";
            [m updateFiveData:^(CKJFiveLabelModel * _Nonnull fm) {
                fm.title = WDCKJAttributed2(@"鼻饲流质", [UIColor kjwd_title], nil);
                fm.subTitle = WDCKJAttributed2(@"鼻饲流质营养治疗适用于不能自行经口进食、昏迷、手术前后营养不良、食欲低下但有一定消化吸收功能者", [UIColor kjwd_subTitle], nil);
            }];
        } didSelectRowBlock:nil];
        _sec.modelArray = @[model1];
    }];
    
    CKJCommonSectionModel *section2 = [CKJCommonSectionModel sectionWithHeaderAttString:@"铃声设置" headerAlignment:NSTextAlignmentLeft detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        __weak typeof(self) weakSelf = self;
        _sec.rowHeight = @38;
          CKJCellModel *model1 = [CKJCellModel ckjCellWithCellHeight:@60 cellModel_id:nil detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
              m.view5Model = [CKJView5Model view5ModelWithTopAttributedText:WDCKJAttributed2(@"无线局域网", [UIColor kjwd_title], @15) bottomAttributedText:WDCKJAttributed2(@"隔空投送、隔空播放需要无线局域网", [UIColor kjwd_subTitle], @13) centerMarign:5 topBottomMargin:8 leftMargin:kO_super_margin_title rightMargin:0];
              m.switch6Model = [CKJSwitch6Model switch6ModelWithSwitchOn:YES left:0 top:0 bottom:0 callBack:^(BOOL switchOn, CKJCellModel *cellModel, UISwitch *senderSwitch) {
                  if (senderSwitch.on) { // 使用动画删除Cell
                      [cellModel.cell.simpleTableView appendCellModelArray:[weakSelf wifiCellModels] atLastRow_InAllCellModelArrayOfSection:1 withRowAnimation:UITableViewRowAnimationBottom animationBlock:^(void (^ _Nonnull animationBlock)(void)) {
                          animationBlock();
                      }];
                  } else {      // 使用动画增加Cell
                      [cellModel.cell.simpleTableView removeAllCellModelAtSection:1 keepDisplayRows:@[@0] removeHiddenCellModel:NO withRowAnimation:UITableViewRowAnimationTop animationBlock:^(void (^ _Nonnull animationBlock)(void)) {
                         animationBlock();
                      }];
                  }
              }];
              m.likePrice61Model = [CKJLikePriceLabel61Model likePriceModelWithLeftMargin:10];
          } didSelectRowBlock:nil];
        
        [_sec addCellModel:model1];
        [_sec addCellModels:[self wifiCellModels]];
    }];
    CKJCommonSectionModel *section3 = [CKJCommonSectionModel sectionWithHeaderHeight:@10 detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        CKJGeneralCellModel *model1 = [CKJGeneralCellModel generalWithCellHeight:@44 cellModel_id:kPriceCellID detailSettingBlock:^(__kindof CKJGeneralCellModel * _Nonnull m) {
            m.image2Model = [CKJImage2Model image2ModelWithImageString:@"demo余额.png" size:CGSizeMake(22, 22) left:15];
            m.title3Model = [CKJTitle3Model title3ModelWithText:WDCKJAttributed2(@"余额", [UIColor kjwd_title], nil) left:10];
            m.likePrice8Model = [CKJLikePriceLabel8Model likePriceLabel8ModelWithAttText:WDCKJAttributed2(@"620.86元", [UIColor kjwd_subTitle], @14) left:0 right:0];
            m.arrow9Model = [CKJArrow9Model arrow9SystemModel];
        } didSelectRowBlock:nil];
        
        CKJTableViewCell1Model *model2 = [CKJTableViewCell1Model baseTableViewCellWithCellHeight:@44 cellModel_id:nil detail:^(__kindof CKJTableViewCell1Model * _Nonnull m) {
            m.attText = WDCKJAttributed2(@"点击本行更新余额", [UIColor kjwd_subTitle], nil);
            m.textAlignment = NSTextAlignmentCenter;
        } didSelectRowBlock:^(__kindof CKJTableViewCell1Model * _Nonnull m) {
            [m.cell.simpleTableView kjwd_filterCellModelForID:kPriceCellID finishBlock:^(CKJGeneralCellModel * _Nonnull m) {
                NSString *arc1 = [NSString kjwd_returnArc4randomWithNum:3 type:KJWDArc4randomType_Number];
                NSString *point = [NSString kjwd_returnArc4randomWithNum:2 type:KJWDArc4randomType_Number];
                [m.likePrice8Model changeText:[NSString stringWithFormat:@"%@.%@元", arc1, point]];
            }];
        }];
        _sec.modelArray = @[model1, model2];
    }];
    
    self.simpleTableView.dataArr = @[section1, section2, section3];
}

- (NSArray <CKJCommonCellModel *>*)wifiCellModels {
    CGSize size = CGSizeMake(23, 23);
    CKJGeneralCellModel *model2 = [CKJGeneralCellModel generalWithTitle:@"Wonders" arrow:[CKJArrow9Model arrow9ModelWithImage:[[UIImage kjwd_imageNamed:@"wifi"] kjwd_scaleToSize:size] right:@12 click:nil] didSelectRowBlock:nil];
    CKJGeneralCellModel *model3 = [CKJGeneralCellModel generalWithTitle:@"Wonders-VIP" arrow:[CKJArrow9Model arrow9ModelWithImage:[[UIImage kjwd_imageNamed:@"wifi"] kjwd_scaleToSize:size] right:@12 click:nil] didSelectRowBlock:nil];
    return @[model2, model3];
}


@end
