//
//  RJScrollViewCellVC.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/6/18.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "RJSquareDemo2VC.h"
#import "CKJBaseBtnsCell.h"
#import "CKJScrollViewCell.h"
#import "RJDemoScrollItemView.h"
#import "UIView+CKJDesingable.h"
#import "CKJBtnsCell1.h"
#import "CKJBtnsCell2.h"

@interface RJSquareDemo2VC ()<CKJScrollViewCellDelegate>

@end

@implementation RJSquareDemo2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"CKJBtnsCell、CKJScrollViewCell示例2";
    [self initSimpleTableViewData];
}

#define kHiddenCellId 17

#define kHeight 100

#pragma mark - CKJSimpleTableView 数据源 和 代理
- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues:(CKJSimpleTableView *_Nonnull)s {
    
    CKJBaseBtnsCellConfig *config1 = [CKJBaseBtnsCellConfig configWithDetailSettingBlock:^(CKJBaseBtnsCellConfig * _Nonnull m) {
        m.stackView_Edge_SuperView = UIEdgeInsetsMake(0, 15, 0, 15);
        m.delegate = [m squareWithNumberOfItemsInSingleLine:4];
    }];
    CKJBaseBtnsCellConfig *config2 = [CKJBaseBtnsCellConfig configWithDetailSettingBlock:^(CKJBaseBtnsCellConfig * _Nonnull m) {
        CGFloat topBottom = 10;
        
        m.stackView_Edge_SuperView = UIEdgeInsetsMake(topBottom, 15, topBottom, 15);
        m.delegate = [m squareWithNumberOfItemsInSingleLine:3];
        m.multiHeightByStackView = @0.6;
        m.separatorViewColor = [UIColor kjwd_r:230 g:230 b:230 alpha:1];
        m.h_itemSpacing = 1;
        m.detailSetting = ^(UIView * _Nonnull stackView_superView) {
            stackView_superView.kCornerRadius = (kHeight - 2 * topBottom) / 2.0;
            stackView_superView.kBorderColor = [UIColor kjwd_230Color];
            stackView_superView.kBorderWidth = 1;
        };
    }];
    CKJScrollViewCellConfig *scrollViewCellConfig = [CKJScrollViewCellConfig configWithDetailSettingBlock:^(__kindof CKJScrollViewCellConfig * _Nonnull m) {
        m.itemWidth = 120;
        m.itemSpace = 20;
        m.items_Edge_ScrollView = UIEdgeInsetsMake(10, 20, 10, 20);
        m.delegate = self;
    }];
    return @{
        NSStringFromClass([CKJBtnsCell1Model class]) : @{cellKEY : NSStringFromClass([CKJBtnsCell1 class]), isRegisterNibKEY : @NO, configDicKEY_ConfigModel : config1},
        NSStringFromClass([CKJBtnsCell2Model class]) : @{cellKEY : NSStringFromClass([CKJBtnsCell2 class]), isRegisterNibKEY : @NO, configDicKEY_ConfigModel : config2},
        NSStringFromClass([CKJScrollViewCellModel class]) : @{cellKEY : NSStringFromClass([CKJScrollViewCell class]), isRegisterNibKEY : @NO, configDicKEY_ConfigModel : scrollViewCellConfig}
    };
}

- (void)initSimpleTableViewData {
    
    KJ_typeweakself
    CKJCommonSectionModel *section1 = [CKJCommonSectionModel sectionWithHeaderAttString:WDCKJAttributed2(@"CKJBtnsCell示例", [UIColor kjwd_subTitleColor969696], nil) headerAlignment:NSTextAlignmentLeft detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        
        UIImage *(^b_image)(NSString *imageName) = ^UIImage *(NSString *imageName) {
            return [[UIImage kjwd_imageNamed:imageName] kjwd_scaleToSize:CGSizeMake(30, 30)];
        };
        NSArray <NSDictionary *>*data = @[
            @{cNormalAttTitle : WDAtt13(@"报告查询"), cNormalImage : b_image(@"newhome_报告")},
            @{cNormalAttTitle : WDAtt13(@"药费查询"), cNormalImage : b_image(@"newhome_药费查询")},
            @{cNormalAttTitle : WDAtt13(@"处方查询"), cNormalImage : b_image(@"newhome_处方")},
            @{cNormalAttTitle : WDAtt13(@"药品查询"), cNormalImage : b_image(@"newhome_药品")},
            @{cNormalAttTitle : WDAtt13(@"精准预约"), cNormalImage : b_image(@"newhome_预约")},
            @{cNormalAttTitle : WDAtt13(@"日间手术"), cNormalImage : b_image(@"newhome_手术")},
            @{cNormalAttTitle : WDAtt13(@"小i机器人"), cNormalImage : b_image(@"newhome_机器人")},
            @{cNormalAttTitle : WDAtt13(@"更多"), cNormalImage : b_image(@"newhome_更多"),  cSelectedAttTitle : WDAtt13(@"日间手术"), cSelectedImage : b_image(@"日间手术")},
            
            @{cNormalAttTitle : WDAtt13(@"预约检查"), cNormalImage : b_image(@"预约检查")},
        ];
        NSArray <CKJBaseBtnsCellItemData *>*items = [CKJBaseBtnsCellItemData returnItemsWithDics:data detailSetting:^(CKJBaseBtnsCellItemData * _Nonnull __weak itemData, NSUInteger index) {
            
            itemData.layoutButton = ^(UIButton * _Nonnull btn) {
                [btn kjwd_layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop imageTitleSpace:10];
            };
            itemData.callBack_Block = ^(CKJBaseBtnsCellItemData * _Nonnull itemData, __kindof CKJBaseBtnsCell * _Nonnull __weak cell) {
                if (index == 7) {
                    if (itemData.selected) {
                    } else {
                        itemData.selected = YES;
                        [weakSelf.simpleTableView kjwd_filterCellModelForID:kHiddenCellId finishBlock:^(__kindof CKJCommonCellModel * _Nonnull m) {
                            m.displayInTableView = YES;
                        }];
                        [weakSelf.simpleTableView reloadData];
                    }
                }
            };
        }];
        
        NSArray <CKJCommonCellModel *>*arr = [CKJBtnsCell1Model btnsCellModelWithItems:items numberOfItemsInSingleLine:4 cellHeight:80 topMargin:0 centerMargin:0 bottomMargin:0 groupId:nil detailSetting:^(CKJBtnsCell1Model * _Nonnull __weak m, NSUInteger cellModel_index) {
            if (cellModel_index == 2) {
                m.cellModel_id = kHiddenCellId;
                m.displayInTableView = NO;
            }
        }];
        
        _sec.modelArray = arr;
    }];
    
    
    CKJCommonSectionModel *section2 = [CKJCommonSectionModel sectionWithHeaderAttString:WDCKJAttributed2(@"CKJBtnsCell示例", [UIColor kjwd_subTitleColor969696], nil) headerAlignment:NSTextAlignmentLeft detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        
        UIImage *(^b_image)(NSString *imageName) = ^UIImage *(NSString *imageName) {
            return [[UIImage kjwd_imageNamed:imageName] kjwd_scaleToSize:CGSizeMake(30, 30)];
        };
        
        NSArray <NSDictionary *>*data = @[
            @{cNormalAttTitle : WDAtt13(@"报告查询"), cNormalImage : b_image(@"newhome_报告")},
            @{cNormalAttTitle : WDAtt13(@"药费查询"), cNormalImage : b_image(@"newhome_药费查询")},
            @{cNormalAttTitle : WDAtt13(@"处方查询"), cNormalImage : b_image(@"newhome_处方")}
        ];
        NSArray <CKJBaseBtnsCellItemData *>*items = [CKJBaseBtnsCellItemData returnItemsWithDics:data detailSetting:^(CKJBaseBtnsCellItemData * _Nonnull __weak itemData, NSUInteger index) {
            itemData.layoutButton = ^(UIButton * _Nonnull btn) {
                [btn kjwd_layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop imageTitleSpace:10];
            };
            itemData.callBack_Block = ^(CKJBaseBtnsCellItemData * _Nonnull itemData, __kindof CKJBaseBtnsCell * _Nonnull __weak cell) {
            };
        }];
        
        NSArray <CKJCommonCellModel *>*arr = [CKJBtnsCell2Model btnsCellModelWithItems:items numberOfItemsInSingleLine:3 cellHeight:kHeight topMargin:0 centerMargin:0 bottomMargin:0 groupId:nil detailSetting:nil];
        _sec.modelArray = arr;
    }];
    
    CKJCommonSectionModel *section3 = [CKJCommonSectionModel sectionWithHeaderAttString:WDCKJAttributed2(@"CKJScrollViewCell示例", [UIColor kjwd_subTitleColor969696], nil) headerAlignment:NSTextAlignmentLeft detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        
        CKJScrollViewCellModel *model1 = [CKJScrollViewCellModel modelWithCellHeight:85 cellModel_id:nil detailSettingBlock:^(__kindof CKJScrollViewCellModel * _Nonnull m) {
            NSArray *data = @[
                @{@"title" : @"入院取号", @"imageName" : @"newhome_入院取号"},
                @{@"title" : @"出院取号", @"imageName" : @"newhome_出院取号"},
                @{@"title" : @"住院日清单", @"imageName" : @"newhome_住院清单"},
                @{@"title" : @"入院取号2", @"imageName" : @"newhome_入院取号"},
                @{@"title" : @"出院取号2", @"imageName" : @"newhome_出院取号"},
                @{@"title" : @"住院日清单2", @"imageName" : @"newhome_住院清单"}
            ];
            NSArray *items = [RJDemoScrollItemData scrollViewCellItemsWithDics:data detailSetting:^(__kindof RJDemoScrollItemData *__weak  _Nonnull itemData, NSUInteger index) {
                itemData.tapBlock = ^{
                    NSLog(@"点击了 %@  下标 %lu", itemData.title, index);
                };
            }];
            m.data = items;
        } didSelectRowBlock:nil];
        _sec.modelArray = @[model1];
    }];
    
    self.simpleTableView.dataArr = @[section1, section2, section3];
    [self.simpleTableView kjwd_reloadData];
}

#pragma mark - CKJScrollViewCellDelegate
- (NSArray <__kindof CKJScrollViewCellItemView *>*)createItemViewForCKJScrollViewCell:(__kindof CKJScrollViewCell *_Nonnull __weak)cell {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        RJDemoScrollItemView *item = [RJDemoScrollItemView kjwd_instanceUsingAutoNib];
        [arr addObject:item];
    }
    return arr;
}
- (void)updateItemView:(__kindof RJDemoScrollItemView *)itemView itemData:(__kindof RJDemoScrollItemData *)itemData index:(NSInteger)index {
    itemView.imageV.image = [UIImage kjwd_imageNamed:itemData.imageName];
    itemView.lab.text = WDKJ_SpaceString(itemData.title);
}



@end
