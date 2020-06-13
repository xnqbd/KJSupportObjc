//
//  RJVisitPersonMessageVc.m
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/10/12.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "PersonInfoDemoVC.h"

@interface PersonInfoDemoVC ()

@end

@implementation PersonInfoDemoVC


- (UITableViewStyle)simpleTableViewStyle {
    return UITableViewStylePlain;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"就诊人信息";
    
    CKJGeneralCellModel *(^block)(NSString *title, NSString *likePrice8) = ^CKJGeneralCellModel *(NSString *title, NSString *likePrice8){
        CKJGeneralCellModel *model1 = [CKJGeneralCellModel generalWithCellHeight:@44 cellModel_id:nil detailSettingBlock:^(__kindof CKJGeneralCellModel * _Nonnull m) {
            m.title3Model = [CKJTitle3Model title3ModelWithText:WDCKJAttributed2(title, [UIColor kjwd_title], nil) left:15];
            m.likePrice8Model = [CKJLikePriceLabel8Model likePriceLabel8ModelWithAttText:WDCKJAttributed2(likePrice8, [UIColor kjwd_subTitle], @13) left:0 right:15];
            m.selectionStyle = UITableViewCellSelectionStyleNone;
        } didSelectRowBlock:nil];
        return model1;
    };
    
    CKJGeneralCellModel *name = block(@"姓名", @"张彬彬");
    CKJGeneralCellModel *idCardType = block(@"证件类型", @"身份证");
    CKJGeneralCellModel *idCardNumber = block(@"证件号", @"300*****1616");
    CKJGeneralCellModel *sex = block(@"性别", @"男");
    CKJGeneralCellModel *birthday = block(@"出生日期", @"1995-02-05");
    CKJGeneralCellModel *relate = block(@"关系", @"配偶");
    CKJGeneralCellModel *phone = block(@"手机号", @"18822223333");
    
    CKJGeneralCellModel *jianhuren_name = block(@"监护人姓名", @"张三丰");
    CKJGeneralCellModel *jianhuren_idCard = block(@"监护人身份证", @"562******2621");
//    CKJGeneralCellModel *model102 = block(@"关系", @"家人");
//    CKJGeneralCellModel *model103 = block(@"手机号", @"15522229999");
    
    CKJGeneralCellModel *card = [CKJGeneralCellModel generalWithCellHeight:@44 cellModel_id:nil detailSettingBlock:^(__kindof CKJGeneralCellModel * _Nonnull m) {
        m.title3Model = [CKJTitle3Model title3ModelWithText:WDCKJAttributed2(@"就诊卡", [UIColor kjwd_title], nil) left:15];
        m.likePrice8Model = [CKJLikePriceLabel8Model likePriceLabel8ModelWithAttText:WDCKJAttributed2(@"点击查看", [UIColor kjwd_blueBtnColor], @13) left:0 right:15];
        m.arrow9Model = [CKJArrow9Model arrow9SystemModel];
    } didSelectRowBlock:^(__kindof CKJGeneralCellModel *__weak  _Nonnull m) {
        NSLog(@"点击了就诊卡");
    }];
    
    CKJGeneralCellModel *status = [CKJGeneralCellModel generalWithCellHeight:@44 cellModel_id:nil detailSettingBlock:^(__kindof CKJGeneralCellModel * _Nonnull m) {
        m.title3Model = [CKJTitle3Model title3ModelWithText:WDCKJAttributed2(@"实名状态", [UIColor kjwd_title], nil) left:15];
        UIImage *image = [[UIImage kjwd_imageNamed:@"new_personal_已实名"] kjwd_scaleToSize:CGSizeMake(60, 20)];
        m.arrow9Model = [CKJArrow9Model arrow9ModelWithImage:image right:@15 click:nil];
        m.selectionStyle = UITableViewCellSelectionStyleNone;
    } didSelectRowBlock:nil];
    
    
    
    if (NO) { // 大于14岁
        CKJCommonSectionModel *section1 = [CKJCommonSectionModel sectionWithDetail:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
            _sec.modelArray = @[name, idCardType, idCardNumber, status, sex, birthday, relate, phone];
        }];
        CKJCommonSectionModel *section2 = [CKJCommonSectionModel sectionWithDetail:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
            _sec.modelArray = @[card];
        }];
        self.simpleTableView.dataArr = @[section1, section2];
    } else {
        CKJCommonSectionModel *section1 = [CKJCommonSectionModel sectionWithDetail:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
            _sec.modelArray = @[name, idCardType, idCardNumber, sex, birthday];
        }];
        CKJCommonSectionModel *section2 = [CKJCommonSectionModel sectionWithDetail:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
            _sec.modelArray = @[card];
        }];
        CKJCommonSectionModel *section3 = [CKJCommonSectionModel sectionWithDetail:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
            _sec.modelArray = @[jianhuren_name, jianhuren_idCard, status, relate, phone];
        }];
        self.simpleTableView.dataArr = @[section1, section2, section3];
    }
}


@end
