//
//  TableViewCellDemoVC.m
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/10/26.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "TableViewCellDemoVC.h"

@interface TableViewCellDemoVC ()

@end

@implementation TableViewCellDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"CKJTableViewCell示例";
    [self initSimpleTableViewData];
}


// 初始化分区数据
- (void)initSimpleTableViewData {
    
    CKJCommonSectionModel *section1 = [CKJCommonSectionModel sectionWithDetail:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        
        CKJTableViewCell1Model *model1 = [CKJTableViewCell1Model baseTableViewCellWithCellHeight:@(UITableViewAutomaticDimension) cellModel_id:nil detailSettingBlock:^(__kindof CKJTableViewCell1Model * _Nonnull m) {
            [m _setText:@"古之欲明明德于天下者，先治其国。欲治其国者，先齐其家。欲齐其家者，先修其身。欲修其身者，先正其心。欲正其心者，先诚其意。欲诚其意者，先致其知；致知在格物。物格而后知至，知至而后意诚，意诚而后心正，心正而后身修，身修而后家齐，家齐而后国治，国治而后天下平。"];
            m.numberOfLines = 0;
        } didSelectRowBlock:nil];
        CKJTableViewCell1Model *model2 = [CKJTableViewCell1Model baseTableViewCellWithCellHeight:@40 cellModel_id:nil detailSettingBlock:^(__kindof CKJTableViewCell1Model * _Nonnull m) {
            [m _setText:@"出自《礼记·大学》"];
            m.textAlignment = NSTextAlignmentRight;
        } didSelectRowBlock:nil];
        _sec.modelArray = @[model1, model2];
    }];
    self.simpleTableView.dataArr = @[section1];
}

@end
