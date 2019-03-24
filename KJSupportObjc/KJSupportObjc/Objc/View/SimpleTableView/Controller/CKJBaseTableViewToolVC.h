//
//  CKJCKJBaseTableViewToolVC.h
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/26.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import "CKJBaseViewController.h"

#import "CKJSimpleTableView.h"

@class CKJSimpleTableView;

#warning  注意: 继承于本来的子类， 需实现 CKJSimpleTableViewDataSource 协议
@interface CKJBaseTableViewToolVC : CKJBaseViewController <CKJSimpleTableViewDataSource, CKJSimpleTableViewDelegate, TitleStyleHeaderFooterViewDelegate>


@property (strong, nonatomic, nonnull) IBOutlet CKJSimpleTableView *simpleTableView;
- (UITableViewStyle)simpleTableViewStyle;

/**
 CKJSimpleTableView的约束或者 frame
 */
- (void)layoutTableViewFrame:(CKJSimpleTableView *)tableV;

- (void)installSimpleTableViewData;


@end
