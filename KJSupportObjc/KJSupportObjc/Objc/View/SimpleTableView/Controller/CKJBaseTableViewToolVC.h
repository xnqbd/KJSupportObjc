//
//  CKJCKJBaseTableViewToolVC.h
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/26.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import "CKJBaseViewController.h"
#import "CKJSimpleTableView.h"

/*
 
 例子
 
 - (void)initSimpleTableViewData {
 
 CKJArrow9Model *arrow = [CKJArrow9Model arrow9ModelWithImage:[[UIImage kjwd_imageNamed:@"wdyhfsdkright arrow"] kjwd_scaleToSize:CGSizeMake(15, 18)] right:nil];
 
 NSMutableArray <__kindof CKJCommonSectionModel *>*sections = [NSMutableArray array];
 NSDictionary *leftDic = @{NSForegroundColorAttributeName : [UIColor kjwd_titleColor333333]};
 NSDictionary *rightDic = @{NSForegroundColorAttributeName : [UIColor kjwd_subTitleColor969696], NSFontAttributeName : [UIFont systemFontOfSize:16]};
 
 NSDictionary *headerFooterDic = @{NSForegroundColorAttributeName : [UIColor darkGrayColor], NSFontAttributeName : [UIFont systemFontOfSize:16]};
 
 
 KJ_typeweakself
 
 CGFloat leftMarign = 15;
 CGFloat rightMarign = 15;
 
 CGFloat headerHeight = 10;
 CGFloat footerHeight = 10;
 {
 CKJCommonSectionModel *section = [CKJCommonSectionModel new];
 section.headerModel = [CKJTitleStyleHeaderFooterModel modelWithAttributedString:WDCKJAttributed(@"区头", headerFooterDic) type:(CKJCommonHeaderFooterType_HEADER)];
 section.footerHeight = footerHeight;
 
 CKJCellModel *model1 = [CKJCellModel modelWithCellHeight:44 cellModel_id:nil detailSettingBlock:^(__kindof CKJCellModel * _Nonnull m) {
 m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDCKJAttributed(@"建议反馈", leftDic) left:leftMarign];
 m.arrow9Model = arrow;
 } didSelectRowBlock:nil];
 
 section.modelArray = @[model1];
 [sections addObject:section];
 }
 
 self.simpleTableView.dataArr = sections;
 [self.simpleTableView kjwd_reloadData];
 }


*/



#warning  注意: 继承于本来的子类， 需实现 CKJSimpleTableViewDataSource 协议
@interface CKJBaseTableViewToolVC : CKJBaseViewController <CKJSimpleTableViewDataSource, CKJSimpleTableViewDelegate, TitleStyleHeaderFooterViewDelegate>


@property (strong, nonatomic, nonnull) IBOutlet CKJSimpleTableView *simpleTableView;
- (UITableViewStyle)simpleTableViewStyle;

/**
 CKJSimpleTableView的约束或者 frame
 */
- (void)layoutTableViewFrame:(CKJSimpleTableView *_Nonnull)tableV;

- (void)initSimpleTableViewData;




@end
