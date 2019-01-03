//
//  CKJCKJBaseTableViewToolVC.h
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/26.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CKJSimpleTableView.h"


@class CKJSimpleTableView;


#define  WDSuperDidSelectRow   [super kj_tableView:tableView didSelectRowAtSection:section row:row selectIndexPath:indexPath model:model cell:cell];



#warning  注意: 继承于本来的子类， 需实现 CKJSimpleTableViewDataSource 协议
@interface CKJBaseTableViewToolVC : UIViewController <UITableViewDelegate, CKJSimpleTableViewDataSource, CKJSimpleTableViewDelegate, TitleStyleHeaderFooterViewDelegate, CKJCellDataSource>


@property (strong, nonatomic, nonnull) IBOutlet CKJSimpleTableView *simpleTableView;
- (UITableViewStyle)simpleTableViewStyle;

/**
 CKJSimpleTableView的约束或者 frame
 */
- (void)layoutTableViewFrame:(CKJSimpleTableView *)tableV;

- (void)installSimpleTableViewData;


@end
