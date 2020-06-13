//
//  RJTopEqualVC.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/20.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "RJConfigVC.h"
#import "SelectDateCell.h"
#import "CKJLeftRightTopEqualCell.h"
#import "CKJLeftRightCenterEqualCell.h"

#import "RJBillDetailModel.h"
#import "RJBillCell.h"

#import "CKJPayCell.h"

@interface RJConfigVC ()

/**
 2019-03-11 这样的格式
 */
@property (copy, nonatomic) NSString *beginDate;

@end

@implementation RJConfigVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"自定义Cell、配置Cell、聚合Cell";
    
    [self initSimpleTableViewData];
    [self firstNetwork];
}

#pragma mark - CKJSimpleTableView 数据源 和 代理
- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues:(CKJSimpleTableView *_Nonnull)s {
    SelectDateCellConfig *config1 = [SelectDateCellConfig cellConfigWithDetail:^(SelectDateCellConfig * _Nonnull m) {
        m.endDateUserInteractionEnabled = NO;
        m.beginDate = BeginDate_Today;
        m.endDate = EndDate_Today;
    }];
    
    
    
    return @{
        NSStringFromClass([RJBillCellModel class]) : @{KJPrefix_cellKEY : NSStringFromClass([RJBillCell class]), KJPrefix_isRegisterNibKEY : @YES},
        NSStringFromClass([SelectDateCellModel class]) : @{KJPrefix_cellKEY : NSStringFromClass([SelectDateCell class]), KJPrefix_isRegisterNibKEY : @NO, KJPrefix_configDicKEY_ConfigModel : config1},
        NSStringFromClass([CKJLeftRightTopEqualCellModel class]) : @{KJPrefix_cellKEY : NSStringFromClass([CKJLeftRightTopEqualCell class]), KJPrefix_isRegisterNibKEY : @NO},
        
    };
}


- (void)kj_tableView:(CKJSimpleTableView *)tableView didSelectRowAtSection:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath model:(__kindof CKJCommonCellModel *)model cell:(__kindof CKJCommonTableViewCell *)cell {
    if ([model isKindOfClass:[CKJLeftRightTopEqualCellModel class]]) {
        
        RJBillDetailModel *target = model.extension_Obj1;
        
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
    NSMutableAttributedString *header = WDCKJAttributed2(@"一般可以在returnCell_Model_keyValues:(CKJSimpleTableView *_Nonnull)s里面进行对Cell初始化的配置，以统一配置不同的界面不同的风格情况， 比如下面的SelectDateCell可以配置开始和结束默认时间，以及CKJLeftRightCell居中对齐和顶部对齐。", [UIColor redColor], nil);
    [header appendAttributedString:WDCKJAttributed2(@"\n\n在本Demo中CKJCombineCellProtocol协议将几个CKJLeftRightCell聚合成一个虚拟的RJBillDetailCell，(本质上还是那几个CKJLeftRightCell)，\n要特别注意：这个协议仅仅是展示作用，如果虚拟的RJBillDetailCell想要在某一时刻修改内容，那么请自定义Cell!", [UIColor redColor], nil)];
    
    CKJCommonSectionModel *section = [CKJCommonSectionModel sectionWithHeaderAttString:header headerAlignment:NSTextAlignmentLeft detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        _sec.footerHeight = @15;
        
        SelectDateCellModel *model1 = [SelectDateCellModel commonWithCellHeight:@44 cellModel_id:nil detailSettingBlock:^(SelectDateCellModel *m) {
            [m updateBGConfig:^(CKJCommonCellBGImageViewConfig * _Nonnull bg) {
                bg.bgColor = [UIColor groupTableViewBackgroundColor];
            }];
        } didSelectRowBlock:nil];
        
        _sec.modelArray = @[model1];
        
    }];
    
    
    self.simpleTableView.dataArr = @[section];
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
        section.footerHeight = @15;
        
        
        RJBillCellModel *model2 = [RJBillCellModel commonWithCellHeight:@44 cellModel_id:nil detailSettingBlock:^(RJBillCellModel * _Nonnull m) {
            [m kjwd_setValuesForKeysWithDictionary:obj];
        } didSelectRowBlock:nil];
        
        // 科室
        CKJTableViewCell1Model *model1 = [CKJTableViewCell1Model baseTableViewCellWithCellHeight:@40 cellModel_id:nil detailSettingBlock:^(__kindof CKJTableViewCell1Model * _Nonnull m) {
            m.selectionStyle = UITableViewCellSelectionStyleNone;
            NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:WDKJ_ConfirmString(obj[@"DeptName"]) attributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:18]}];
            m.attText = att;
        } didSelectRowBlock:nil];
        
        section.modelArray = @[model1, model2];
        [sections addObject:section];
    }];
    
    [weakSelf.simpleTableView appendCKJCommonSectionModels:sections];
    [weakSelf.simpleTableView kjwd_reloadData];
}



@end
