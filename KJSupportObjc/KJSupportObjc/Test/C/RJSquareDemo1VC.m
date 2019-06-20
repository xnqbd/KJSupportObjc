//
//  RJSquareVC.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/28.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "RJSquareDemo1VC.h"
#import "CKJStackCell.h"
#import "CKJBaseBtnsCell.h"
#import "RJDemoExpertItemView.h"
#import "CKJBtnsCell1.h"

@interface RJSquareDemo1VC () <CKJScrollViewCellDelegate>

@end

@implementation RJSquareDemo1VC

#define kHidCellId 128

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"StackCell、ScrollViewCell示例1";
    [self initSimpleTableViewData];
}


- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues {
    CKJBtnsCell1Config *config1 = [CKJBtnsCell1Config configWithDetailSettingBlock:^(CKJBtnsCell1Config * _Nonnull m) {
        m.stackView_Edge_SuperView = UIEdgeInsetsMake(5, 10, 5, 10);
        m.delegate = [m squareWithNumberOfItemsInSingleLine:3];
        m.h_itemSpacing = 20;
    }];
    CKJScrollViewCellConfig *scrollViewCellConfig = [CKJScrollViewCellConfig configWithDetailSettingBlock:^(__kindof CKJScrollViewCellConfig * _Nonnull m) {
        m.itemWidth = 100;
        m.itemSpace = 20;
        m.items_Edge_ScrollView = UIEdgeInsetsMake(15, 20, 15, 20);
        m.delegate = self;
    }];
    return @{
             NSStringFromClass([CKJBtnsCell1Model class]) : @{cellKEY : NSStringFromClass([CKJBtnsCell1 class]), isRegisterNibKEY : @NO, configDicKEY_ConfigModel : config1},
             NSStringFromClass([CKJScrollViewCellModel class]) : @{cellKEY : NSStringFromClass([CKJScrollViewCell class]), isRegisterNibKEY : @NO, configDicKEY_ConfigModel : scrollViewCellConfig},

             };
}

- (void)initSimpleTableViewData {
    NSMutableArray <__kindof CKJCommonSectionModel *>*sections = [NSMutableArray array];
    
    KJ_typeweakself
    
    {
        CKJCommonSectionModel *section = [CKJCommonSectionModel new];
        
        CKJCellModel *model1 = [CKJCellModel modelWithCellHeight:120 cellModel_id:nil detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
            m.selectionStyle = UITableViewCellSelectionStyleNone;
            m.bgVColor = [UIColor kjwd_r:25 g:130 b:197 alpha:1];
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:nil left:15];
            
            m.view5Model = [CKJView5Model view5ModelWithTopAttributedText:WDCKJAttributed2(@"预交金余额(元)", [UIColor whiteColor], @15) bottomAttributedText:WDCKJAttributed5(@"2000.00", [UIColor whiteColor], @42) topEdge:UIEdgeInsetsMake(15, 0, 0, 0) bottomEdge:UIEdgeInsetsMake(0, 0, 25, 0)];
            
            m.btn8Model = [CKJBtn8Model btn8ModelWithSize:CGSizeMake(60, 30) normalImage:nil rightMargin:20 detailSettingBlock:^(CKJBtn8Model * _Nonnull sender) {
                sender.normalAttributedTitle = WDCKJAttributed2(@"充值", [UIColor whiteColor], @15);
                sender.cornerRadius = 15;
                sender.borderColor = [UIColor kjwd_r:169 g:218 b:255 alpha:1];
                sender.borderWidth = 2;
            } didClickBtn8Handle:^(CKJCell * _Nonnull cell, CKJBtn8Model * _Nonnull btn8Model) {
                NSLog(@"点击充值");
            }];
        } didSelectRowBlock:nil];
        section.modelArray = @[model1];
        [sections addObject:section];
    }
    {
        CKJCommonSectionModel *section = [CKJCommonSectionModel new];
        section.headerHeight = 15;
        
        CKJCellModel *model1 = [CKJCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
            m.selectionStyle = UITableViewCellSelectionStyleNone;
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed2(@"预交金明细", [UIColor kjwd_titleColor333333], nil) left:15];
            
            m.btn8Model = [CKJBtn8Model btn8ModelWithSize:CGSizeMake(60, 30) normalImage:nil rightMargin:12 detailSettingBlock:^(CKJBtn8Model * _Nonnull sender) {
                sender.normalAttributedTitle = WDCKJAttributed2(@"筛选", [UIColor kjwd_r:25 g:130 b:197 alpha:1], nil);
            } didClickBtn8Handle:^(CKJCell * _Nonnull cell, CKJBtn8Model * _Nonnull btn8Model) {
                NSLog(@"点击筛选");
                if (cell.currentSectionAllCellModelArray.count > 1) return;
                [cell.simpleTableView appendCellModelArray:[weakSelf extensionCellModels] atLastRow_InAllCellModelArrayOfSection:cell.section withRowAnimation:UITableViewRowAnimationTop animationBlock:^(void (^ _Nonnull animationBlock)(void)) {
                    animationBlock();
                }];
            }];
        } didSelectRowBlock:nil];
        section.modelArray = @[model1];
        [sections addObject:section];
    }
    {
        
        CKJCommonSectionModel *section = [CKJCommonSectionModel new];
        section.headerHeight = 10;
      
        CKJScrollViewCellModel *model2 = [CKJScrollViewCellModel modelWithCellHeight:160 cellModel_id:nil detailSettingBlock:^(__kindof CKJScrollViewCellModel * _Nonnull m) {
            NSArray *data = @[
                              @{@"avatarImageName" : @"newhome_报告", @"name" : @"狄文1", @"job" : @"主任", @"department" : @"胸外科"},
                              @{@"avatarImageName" : @"newhome_药费查询", @"name" : @"赵小强1", @"job" : @"经理", @"department" : @"心内科"},
                              @{@"avatarImageName" : @"newhome_报告", @"name" : @"狄文2", @"job" : @"主任", @"department" : @"胸外科"},
                              @{@"avatarImageName" : @"newhome_药费查询", @"name" : @"赵小强2", @"job" : @"经理", @"department" : @"心内科"},
                              @{@"avatarImageName" : @"newhome_报告", @"name" : @"狄文3", @"job" : @"主任", @"department" : @"胸外科"},
                              @{@"avatarImageName" : @"newhome_药费查询", @"name" : @"赵小强3", @"job" : @"经理", @"department" : @"心内科"},
                              @{@"avatarImageName" : @"newhome_报告", @"name" : @"狄文4", @"job" : @"主任", @"department" : @"胸外科"},
                              @{@"avatarImageName" : @"newhome_药费查询", @"name" : @"赵小强4", @"job" : @"经理", @"department" : @"心内科"},
                              @{@"avatarImageName" : @"newhome_报告", @"name" : @"狄文5", @"job" : @"主任", @"department" : @"胸外科"},
                              @{@"avatarImageName" : @"newhome_药费查询", @"name" : @"赵小强5", @"job" : @"经理", @"department" : @"心内科"}
                              ];
            
            m.data = [RJDemoExpertItemData scrollViewCellItemsWithDics:data detailSetting:^(__kindof RJDemoExpertItemData *__weak  _Nonnull itemData, NSUInteger index) {
                itemData.tapBlock = ^{
                    NSLog(@"点击了 %@  下标 %lu", itemData.name, index);
                };
            }];
            
        } didSelectRowBlock:nil];
        
        section.modelArray = @[ model2];
        [sections addObject:section];
    }
    
    self.simpleTableView.dataArr = sections;
    [self.simpleTableView kjwd_reloadData];
}

- (NSArray <__kindof CKJCommonCellModel *>*)extensionCellModels {
    
    NSString *dateGroupId = @"dateGroupId";
    
    NSMutableArray *cellModels = [NSMutableArray array];
    
    
    KJ_typeweakself
    CKJCellModel *model1 = [CKJCellModel modelWithCellHeight:40 cellModel_id:nil detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
        [m addGroupId:dateGroupId];
        m.showLine = NO;
        m.selectionStyle = UITableViewCellSelectionStyleNone;
        m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed5(@"月份筛选", [UIColor blackColor], @17) left:15];
    } didSelectRowBlock:nil];
    
    [cellModels addObject:model1];
    
    UIImage *image = [UIImage kjwd_imageWithColor:[UIColor kjwd_r:245 g:245 b:245 alpha:1] size:CGSizeMake(150, 50)];
    
    NSArray *titles = @[@"2019年05月", @"2019年04月", @"2019年03月", @"2019年02月", @"2019年01月", @"2018年12月", @"2018年11月", @"2018年10月"];
    NSMutableArray *data = [NSMutableArray array];
    
    for (NSString *title in titles) {
        [data addObject:@{cNormalAttTitle : WDAtt1(title), cNormalBgImage : image, cCornerRadius : @(5)}];
    }
    
    NSArray <CKJBaseBtnsCellItemData *>*items = [CKJBaseBtnsCellItemData returnItemsWithDics:data detailSetting:^(CKJBaseBtnsCellItemData * _Nonnull __weak itemData, NSUInteger index) {
        itemData.callBack_Block = ^(CKJBaseBtnsCellItemData * _Nonnull itemData, __kindof CKJBaseBtnsCell * _Nonnull __weak cell) {
            NSLog(@"点击了  %@ ", itemData.normalAttTitle.string);
            [weakSelf.simpleTableView removeCellModelsByGroupId:dateGroupId inSection:cell.section removeHiddenCellModel:NO withRowAnimation:UITableViewRowAnimationTop animationBlock:^(void (^ _Nonnull animationBlock)(void)) {
                animationBlock();
            }];
        };
    }];
    NSArray <CKJCommonCellModel *>*models = [CKJBtnsCell1Model modelWithItems:items numberOfItemsInSingleLine:3 cellHeight:44 topMargin:0 centerMargin:0 bottomMargin:0 groupId:dateGroupId detailSetting:^(CKJBtnsCell1Model * _Nonnull m, NSUInteger cellModel_index) {
    }];
    [cellModels addObjectsFromArray:models];
    
    CKJTableViewCell1Model *model4 = [CKJTableViewCell1Model modelWithCellHeight:40 cellModel_id:nil detailSettingBlock:^(__kindof CKJTableViewCell1Model * _Nonnull m) {
        [m addGroupId:dateGroupId];
        m.showLine = NO;
        m.selectionStyle = UITableViewCellSelectionStyleNone;
        m.textLabelAttStr = WDCKJAttributed2(@"显示最近半年明细", [UIColor kjwd_subTitleColor969696], @13.5);
        m.textAlignment = NSTextAlignmentCenter;
    } didSelectRowBlock:nil];
    [cellModels addObject:model4];
    
    return cellModels;
}

#pragma mark - CKJScrollViewCellDelegate
- (NSArray <__kindof CKJScrollViewCellItemView *>*)createItemViewForCKJScrollViewCell:(__kindof CKJScrollViewCell *_Nonnull __weak)cell {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        [arr addObject:[RJDemoExpertItemView kjwd_instanceUsingAutoNib]];
    }
    return arr;
}
- (void)updateItemView:(__kindof RJDemoExpertItemView *)itemView itemData:(__kindof RJDemoExpertItemData *)itemData index:(NSInteger)index {
    itemView.avatarImageView.image = [UIImage kjwd_imageNamed:itemData.avatarImageName];
    itemView.nameLab.text = WDKJ_SpaceString(itemData.name);
    itemView.jobLab.text = WDKJ_SpaceString(itemData.job);
    [itemView.departmentLab setTitle:WDKJ_SpaceString(itemData.department) forState:UIControlStateNormal];
}

@end
