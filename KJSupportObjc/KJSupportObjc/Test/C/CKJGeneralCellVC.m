//
//  CKJGeneralCellVC.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/7/7.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJGeneralCellVC.h"

@interface CKJGeneralCellVC ()

@end

@implementation CKJGeneralCellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"CKJGeneralCell示例";
    [self initSimpleTableViewData];
}

- (void)initSimpleTableViewData {
    
    CKJCommonSectionModel *section1 = [CKJCommonSectionModel sectionWithHeaderAttString:WDCKJAttributed2(@"CKJGeneralCell的结构", [UIColor grayColor], @15) detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        
        CKJGeneralCellModel *model1 = [CKJGeneralCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(__kindof CKJGeneralCellModel * _Nonnull m) {
            m.image2Model = [CKJImage2Model image2ModelWithImageString:@"touxiang.jpg" size:CGSizeMake(25, 25) left:15];
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed2(@"title3", [UIColor kjwd_titleColor333333], nil) left:10];
            m.likePrice8Model = [CKJLikePriceLabel8Model likePriceLabel8ModelWithAttText:WDCKJAttributed2(@"likePrice8", [UIColor kjwd_subTitleColor969696], @14) left:0 right:0];
            m.arrow9Model = [CKJArrow9Model arrow9SystemModel];
        } didSelectRowBlock:nil];
        
        _sec.modelArray = @[model1];
    }];
    
    CKJCommonSectionModel *section2 = [CKJCommonSectionModel sectionWithHeaderHeight:10 detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        
        CKJGeneralCellModel *model1 = [CKJGeneralCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(__kindof CKJGeneralCellModel * _Nonnull m) {
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed2(@"title3", [UIColor kjwd_titleColor333333], nil) left:10];
        } didSelectRowBlock:nil];
        
        CKJGeneralCellModel *model2 = [CKJGeneralCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(__kindof CKJGeneralCellModel * _Nonnull m) {
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed2(@"title3", [UIColor kjwd_titleColor333333], nil) left:10];
            m.arrow9Model = [CKJArrow9Model arrow9SystemModel];
        } didSelectRowBlock:nil];
        
        CKJGeneralCellModel *model3 = [CKJGeneralCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(__kindof CKJGeneralCellModel * _Nonnull m) {
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed2(@"title3", [UIColor kjwd_titleColor333333], nil) left:10];
            m.likePrice8Model = [CKJLikePriceLabel8Model likePriceLabel8ModelWithAttText:WDCKJAttributed2(@"likePrice8", [UIColor kjwd_subTitleColor969696], @14) left:0 right:0];
            m.arrow9Model = [CKJArrow9Model arrow9SystemModel];
        } didSelectRowBlock:nil];
        
        
        CKJGeneralCellModel *model4 = [CKJGeneralCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(__kindof CKJGeneralCellModel * _Nonnull m) {
            
            UIImage *image = [[UIImage kjwd_imageWithColor:[UIColor redColor] size:CGSizeMake(3, 22)] kjwd_setCornerRadius:1.5];
            
            m.image2Model = [CKJImage2Model image2ModelWithNormalImage:image size:nil left:15];
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed2(@"title3", [UIColor kjwd_titleColor333333], nil) left:7];
            m.likePrice8Model = [CKJLikePriceLabel8Model likePriceLabel8ModelWithAttText:WDCKJAttributed2(@"更多", [UIColor kjwd_subTitleColor969696], @14) left:0 right:0];
            m.arrow9Model = [CKJArrow9Model arrow9SystemModel];
        } didSelectRowBlock:nil];
        
        
        _sec.modelArray = @[model1, model2, model3, model4];
        
    }];
    
    self.simpleTableView.dataArr = @[section1, section2];
    [self.simpleTableView kjwd_reloadData];
}


@end
