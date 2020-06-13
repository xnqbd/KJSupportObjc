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

#define kHiddenCellId @"kHiddenCellId"

#define kHeight 100
#define kBottom 10

#pragma mark - CKJSimpleTableView 数据源 和 代理
- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues:(CKJSimpleTableView *_Nonnull)s {
    
    CKJBaseBtnsCellConfig *config1 = [CKJBaseBtnsCellConfig btnsConfigWithH_itemSpacing:0 detail:^(CKJBaseBtnsCellConfig * _Nonnull m) {
        m.fixHeight = 30;
        m.delegate = [m squareWithNumberOfItemsInSingleLine:4];
    }];
    CKJBaseBtnsCellConfig *config2 = [CKJBaseBtnsCellConfig btnsConfigWithH_itemSpacing:1 detail:^(CKJBaseBtnsCellConfig * _Nonnull m) {
        m.delegate = [m squareWithNumberOfItemsInSingleLine:3];
        m.multiHeightByStackView = @0.6;
        m.separatorViewColor = [UIColor kjwd_r:230 g:230 b:230 alpha:1];
        m.detailSettingStackView_superView = ^(UIView * _Nonnull stackView_superView) {
            stackView_superView.kCornerRadius = (kHeight - 2 * kBottom) / 2.0;
            stackView_superView.kBorderColor = [UIColor kjwd_230Color];
            stackView_superView.kBorderWidth = 1;
        };
    }];
    CKJScrollViewCellConfig *scrollViewCellConfig = [CKJScrollViewCellConfig scrollViewCellConfigWithItemWidth:120 itemSpace:20 detail:^(__kindof CKJScrollViewCellConfig * _Nonnull m) {
        m.items_Edge_ScrollView = UIEdgeInsetsMake(10, 20, 10, 20);
        m.delegate = self;
    }];
    return @{
        NSStringFromClass([CKJBtnsCell1Model class]) : @{KJPrefix_cellKEY : NSStringFromClass([CKJBtnsCell1 class]), KJPrefix_isRegisterNibKEY : @NO, KJPrefix_configDicKEY_ConfigModel : config1},
        NSStringFromClass([CKJBtnsCell2Model class]) : @{KJPrefix_cellKEY : NSStringFromClass([CKJBtnsCell2 class]), KJPrefix_isRegisterNibKEY : @NO, KJPrefix_configDicKEY_ConfigModel : config2},
        NSStringFromClass([CKJScrollViewCellModel class]) : @{KJPrefix_cellKEY : NSStringFromClass([CKJScrollViewCell class]), KJPrefix_isRegisterNibKEY : @NO, KJPrefix_configDicKEY_ConfigModel : scrollViewCellConfig}
    };
}

- (void)initSimpleTableViewData {
    
    KJ_typeweakself
    
    CKJCommonSectionModel *section1 = [CKJCommonSectionModel sectionWithHeaderAttString:WDCKJAttributed2(@"CKJBtnsCell示例", [UIColor kjwd_subTitle], nil) headerAlignment:NSTextAlignmentLeft detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        
        UIImage *(^b_image)(NSString *imageName) = ^UIImage *(NSString *imageName) {
            return [[UIImage kjwd_imageNamed:imageName] kjwd_scaleToSize:CGSizeMake(30, 30)];
        };
        NSArray *data = @[
            @[
                @{KJPrefix_cNormalAttTitle : WDAtt13(@"报告查询"), KJPrefix_cNormalImage : b_image(@"newhome_报告")},
                @{KJPrefix_cNormalAttTitle : WDAtt13(@"药费查询"), KJPrefix_cNormalImage : b_image(@"newhome_药费查询")},
                @{KJPrefix_cNormalAttTitle : WDAtt13(@"处方查询"), KJPrefix_cNormalImage : b_image(@"newhome_处方")},
                @{KJPrefix_cNormalAttTitle : WDAtt13(@"药品查询"), KJPrefix_cNormalImage : b_image(@"newhome_药品")}
            ],
            
            @[
                @{KJPrefix_cNormalAttTitle : WDAtt13(@"精准预约"), KJPrefix_cNormalImage : b_image(@"newhome_预约")},
                @{KJPrefix_cNormalAttTitle : WDAtt13(@"日间手术"), KJPrefix_cNormalImage : b_image(@"newhome_手术")},
                @{KJPrefix_cNormalAttTitle : WDAtt13(@"小i机器人"), KJPrefix_cNormalImage : b_image(@"newhome_机器人")},
                @{KJPrefix_cNormalAttTitle : WDAtt13(@"更多"), KJPrefix_cNormalImage : b_image(@"newhome_更多"),  KJPrefix_cSelectedAttTitle : WDAtt13(@"日间手术"), KJPrefix_cSelectedImage : b_image(@"日间手术")}
            ],
            @[
                @{KJPrefix_cNormalAttTitle : WDCKJAttributed2(@"预约检查", nil, @13), KJPrefix_cNormalImage : b_image(@"预约检查")}
            ]
        ];
        
        data = [CKJBtnItemData returnItemsWithDicsnew:data detailSetting:^(CKJBtnItemData *__weak  _Nonnull itemData, NSUInteger index) {
            itemData.layout_Button = ^(UIButton * _Nonnull btn) {
                [btn kjwd_layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop imageTitleSpace:10];
            };
            itemData.click_Button = ^(UIButton * _Nonnull btn, __kindof CKJBtnItemData * _Nonnull itemData) {
                if ([itemData.normalAttTitle.string isEqualToString:@"更多"]) {
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
        
        CGFloat topMargin = 10, centerMargin = 10, bottomMargin = 10;
        
        NSArray <CKJBaseBtnsCellModel *>*arr = [CKJBtnsCell1Model btnsCellModelWithItemsnew:data cellHeight:@(UITableViewAutomaticDimension) leftMargin:@10 rightMargin:@10 detailSetting:^(__kindof CKJBaseBtnsCellModel *__weak  _Nonnull m, NSUInteger cellModel_index) {
            if (cellModel_index == 0) {
                m.stackView_topMargin = @(topMargin);
                m.stackView_bottomMargin = @(centerMargin / 2.0);
            } else if (cellModel_index == 1) {
                m.stackView_topMargin = @(centerMargin / 2.0);
                m.stackView_bottomMargin = @(centerMargin / 2.0);
            } else if (cellModel_index == 2) {
                m.stackView_topMargin = @(centerMargin / 2.0);
                m.stackView_bottomMargin = @(bottomMargin);
                m.cellModel_id = kHiddenCellId;
                m.displayInTableView = NO;
            }
        }];
        _sec.modelArray = arr;
    }];
    CKJCommonSectionModel *section2 = [CKJCommonSectionModel sectionWithHeaderAttString:WDCKJAttributed2(@"CKJBtnsCell示例", [UIColor kjwd_subTitle], nil) headerAlignment:NSTextAlignmentLeft detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        
        UIImage *(^b_image)(NSString *imageName) = ^UIImage *(NSString *imageName) {
            return [[UIImage kjwd_imageNamed:imageName] kjwd_scaleToSize:CGSizeMake(30, 30)];
        };
        
        NSArray *data = @[
            @{KJPrefix_cNormalAttTitle : WDAtt13(@"报告查询"), KJPrefix_cNormalImage : b_image(@"newhome_报告")},
            @{KJPrefix_cNormalAttTitle : WDAtt13(@"药费查询"), KJPrefix_cNormalImage : b_image(@"newhome_药费查询")},
            @{KJPrefix_cNormalAttTitle : WDAtt13(@"处方查询"), KJPrefix_cNormalImage : b_image(@"newhome_处方")}
        ];
        NSArray <CKJBtnItemData *>*items = [CKJBtnItemData returnItemsWithDics:data detailSetting:^(CKJBtnItemData * _Nonnull __weak itemData, NSUInteger index) {
            itemData.layout_Button = ^(UIButton * _Nonnull btn) {
                [btn kjwd_layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop imageTitleSpace:10];
            };
        }];
        
        NSArray <CKJCommonCellModel *>*arr = [CKJBtnsCell2Model btnsCellModelWithItemsnew:@[items] cellHeight:@100 leftMargin:@15 rightMargin:@15 detailSetting:^(__kindof CKJBaseBtnsCellModel *__weak  _Nonnull m, NSUInteger cellModel_index) {
            m.stackView_topMargin = @(kBottom);
            m.stackView_bottomMargin = @(kBottom);
        }];
        
        _sec.modelArray = arr;
    }];
    
    CKJCommonSectionModel *section3 = [CKJCommonSectionModel sectionWithHeaderAttString:WDCKJAttributed2(@"CKJScrollViewCell示例", [UIColor kjwd_subTitle], nil) headerAlignment:NSTextAlignmentLeft detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        CKJScrollViewCellModel *model1 = [CKJScrollViewCellModel scrollViewWithCellHeight:@85 detailSettingBlock:nil];
        _sec.modelArray = @[model1];
    }];
    
    self.simpleTableView.dataArr = @[section1, section2, section3];
    [self.simpleTableView kjwd_reloadData];
}

#pragma mark - CKJScrollViewCellDelegate
- (NSArray <__kindof UIView *>*)createItemViewForCKJScrollViewCell:(__kindof CKJScrollViewCell *_Nonnull __weak)cell {
    NSArray *data = @[
        @{@"title" : @"入院取号", @"imageName" : @"newhome_入院取号"},
        @{@"title" : @"出院取号", @"imageName" : @"newhome_出院取号"},
        @{@"title" : @"住院日清单", @"imageName" : @"newhome_住院清单"},
        @{@"title" : @"入院取号2", @"imageName" : @"newhome_入院取号"},
        @{@"title" : @"出院取号2", @"imageName" : @"newhome_出院取号"},
        @{@"title" : @"住院日清单2", @"imageName" : @"newhome_住院清单"}
    ];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < data.count; i++) {
        NSDictionary *itemData = data[i];
        NSString *title = itemData[@"title"];
        RJDemoScrollItemView *itemView = [RJDemoScrollItemView kjwd_instanceUsingAutoNib];
        itemView.imageV.image = [UIImage kjwd_imageNamed:itemData[@"imageName"]];
        itemView.lab.text = title;
        itemView.tapBlock = ^{
            NSLog(@"点击了 %@   ", title);
        };
        [arr addObject:itemView];
    }
    return arr;
}

@end
