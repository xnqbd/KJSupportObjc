//
//  CKJCKJBaseTableVC.h
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/26.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import "CKJBaseViewController.h"
#import "CKJSimpleTableView.h"

NS_ASSUME_NONNULL_BEGIN


#warning  注意: 继承于本来的子类， 需实现 CKJSimpleTableViewDataSource 协议
@interface CKJBaseTableVC : CKJBaseViewController <CKJSimpleTableViewDataSource, CKJSimpleTableViewDelegate, TitleStyleHeaderFooterViewDelegate>


@property (strong, nonatomic) IBOutlet CKJSimpleTableView *simpleTableView;
- (UITableViewStyle)simpleTableViewStyle;

/**
 CKJSimpleTableView的约束或者 frame
 */
- (void)layoutTableViewFrame:(CKJSimpleTableView *)tableV;

- (void)initSimpleTableViewData;


/// 添加尾视图
- (void)createFooterViewWithBtnTitle:(NSString *)title clickHandle:(void(^_Nullable)(UIButton * _Nonnull sender, __kindof CKJBaseTableVC *se, CKJSimpleTableView *simpleTableView))clickHandle;

- (UIView *)footerViewWithBtnTitle:(NSString *)title clickHandle:(void(^_Nullable)(UIButton * _Nonnull sender))clickHandle;


#pragma mark - 输入框相关
@property (copy, nonatomic, nonnull) void (^input_block1)(CKJInputCellModel *m, CKJInputExpressionRequiredModel *_Nullable emptyModel);
- (CGFloat)inputCellHeight;

@end

NS_ASSUME_NONNULL_END
