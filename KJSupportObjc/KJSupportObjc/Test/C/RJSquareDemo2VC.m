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
    self.navigationItem.title = @"StackCell、ScrollViewCell示例2";
    [self initSimpleTableViewData];
}

#define kHiddenCellId 17

#define kHeight 100

#pragma mark - CKJSimpleTableView 数据源 和 代理
- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues {
    
    CKJBtnsCell1Config *config1 = [CKJBtnsCell1Config configWithDetailSettingBlock:^(CKJBtnsCell1Config * _Nonnull m) {
        m.stackView_Edge_SuperView = UIEdgeInsetsMake(0, 15, 0, 15);
        m.delegate = [m squareWithNumberOfItemsInSingleLine:4];
    }];
    CKJBtnsCell2Config *config2 = [CKJBtnsCell2Config configWithDetailSettingBlock:^(CKJBtnsCell2Config * _Nonnull m) {
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
    
    NSMutableArray <__kindof CKJCommonSectionModel *>*sections = [NSMutableArray array];
    
    KJ_typeweakself
    
    {
        NSMutableArray *cellModels = [NSMutableArray array];
        CKJCommonSectionModel *section = [CKJCommonSectionModel new];

        UIImage *(^b_image)(NSString *imageName) = ^UIImage *(NSString *imageName) {
            return [[UIImage kjwd_imageNamed:imageName] kjwd_scaleToSize:CGSizeMake(30, 30)];
        };
        NSArray <NSDictionary *>*data = @[
                                          @{cNormalAttTitle : WDAtt1(@"报告查询"), cNormalImage : b_image(@"newhome_报告")},
                                          @{cNormalAttTitle : WDAtt1(@"药费查询"), cNormalImage : b_image(@"newhome_药费查询")},
                                          @{cNormalAttTitle : WDAtt1(@"处方查询"), cNormalImage : b_image(@"newhome_处方")},
                                          @{cNormalAttTitle : WDAtt1(@"药品查询"), cNormalImage : b_image(@"newhome_药品")},
                                          @{cNormalAttTitle : WDAtt1(@"精准预约"), cNormalImage : b_image(@"newhome_预约")},
                                          @{cNormalAttTitle : WDAtt1(@"日间手术"), cNormalImage : b_image(@"newhome_手术")},
                                          @{cNormalAttTitle : WDAtt1(@"小i机器人"), cNormalImage : b_image(@"newhome_机器人")},
                                          @{cNormalAttTitle : WDAtt1(@"更多"), cNormalImage : b_image(@"newhome_更多"),  cSelectedAttTitle : WDAtt1(@"日间手术"), cSelectedImage : b_image(@"日间手术")},
                                          
                                          @{cNormalAttTitle : WDAtt1(@"预约检查"), cNormalImage : b_image(@"预约检查")},
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
        
        NSArray <CKJCommonCellModel *>*arr = [CKJBtnsCell1Model modelWithItems:items numberOfItemsInSingleLine:4 cellHeight:80 topMargin:0 centerMargin:0 bottomMargin:0 groupId:nil detailSetting:^(CKJBtnsCell1Model * _Nonnull m, NSUInteger cellModel_index) {
            if (cellModel_index == 2) {
                m.cellModel_id = kHiddenCellId;
                m.displayInTableView = NO;
            }
        }];
        [cellModels addObjectsFromArray:arr];
        
        section.modelArray = cellModels;
        [sections addObject:section];
    }
    {
        NSMutableArray *cellModels = [NSMutableArray array];
        CKJCommonSectionModel *section = [CKJCommonSectionModel new];
        section.headerHeight = 10;
        
        
        UIImage *(^b_image)(NSString *imageName) = ^UIImage *(NSString *imageName) {
            return [[UIImage kjwd_imageNamed:imageName] kjwd_scaleToSize:CGSizeMake(30, 30)];
        };
        
        NSArray <NSDictionary *>*data = @[
                                          @{cNormalAttTitle : WDAtt1(@"报告查询"), cNormalImage : b_image(@"newhome_报告")},
                                          @{cNormalAttTitle : WDAtt1(@"药费查询"), cNormalImage : b_image(@"newhome_药费查询")},
                                          @{cNormalAttTitle : WDAtt1(@"处方查询"), cNormalImage : b_image(@"newhome_处方")}
                                          ];
        NSArray <CKJBaseBtnsCellItemData *>*items = [CKJBaseBtnsCellItemData returnItemsWithDics:data detailSetting:^(CKJBaseBtnsCellItemData * _Nonnull __weak itemData, NSUInteger index) {
            itemData.layoutButton = ^(UIButton * _Nonnull btn) {
                [btn kjwd_layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop imageTitleSpace:10];
            };
            itemData.callBack_Block = ^(CKJBaseBtnsCellItemData * _Nonnull itemData, __kindof CKJBaseBtnsCell * _Nonnull __weak cell) {
            };
        }];
        
        NSArray <CKJCommonCellModel *>*arr = [CKJBtnsCell2Model modelWithItems:items numberOfItemsInSingleLine:3 cellHeight:kHeight topMargin:0 centerMargin:0 bottomMargin:0 groupId:nil detailSetting:nil];
        [cellModels addObjectsFromArray:arr];
        
        section.modelArray = cellModels;
        [sections addObject:section];
    }
    {
        CKJCommonSectionModel *section = [CKJCommonSectionModel new];
        section.headerHeight = 10;
        
        CKJCellModel *model0 = [CKJCellModel modelWithCellHeight:40 cellModel_id:nil detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
            m.selectionStyle = UITableViewCellSelectionStyleNone;
            m.showLine = NO;
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed2(@"住院信息", nil, nil) left:15];
        } didSelectRowBlock:nil];
        
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
        section.modelArray = @[model0, model1];
        [sections addObject:section];
    }
    
    self.simpleTableView.dataArr = sections;
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
