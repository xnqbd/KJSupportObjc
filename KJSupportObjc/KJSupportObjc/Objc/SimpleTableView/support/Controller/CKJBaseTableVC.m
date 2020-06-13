//
//  CKJBaseTableVC.m
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/26.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import "CKJBaseTableVC.h"
#import "CKJSimpleTableView.h"
#import <Masonry/Masonry.h>

@interface CKJBaseTableVC ()

@end

@implementation CKJBaseTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CKJSimpleTableView];
    self.view.backgroundColor = self.simpleTableView.backgroundColor;
}

- (UITableViewStyle)simpleTableViewStyle {
    return UITableViewStyleGrouped;
}

- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues:(CKJSimpleTableView *_Nonnull)s {
    return @{};
}

#pragma mark - 懒加载
- (CKJSimpleTableView *)CKJSimpleTableView {
    if (_simpleTableView) return _simpleTableView;
    CKJSimpleTableView *tabV = [[CKJSimpleTableView alloc] initWithFrame:CGRectZero style:[self simpleTableViewStyle]];
    {
        // 解决tableView在deleteRowsAtIndexPaths操作时 屏幕上下跳动问题, 可以搜索 Self-Sizing  https://blog.csdn.net/SurpassBlack/article/details/78426655
//        if (@available(iOS 11.0, *)) {
//            tabV.estimatedRowHeight = 0;
//            tabV.estimatedSectionHeaderHeight = 0;
//            tabV.estimatedSectionFooterHeight = 0;
//        }
    }
    
    tabV.tableFooterView = [UIView new];
    tabV.simpleTableViewDelegate = self;
    tabV.simpleTableViewDataSource = self;
    tabV.titleStyleHeaderFooterViewDelegate = self;
    [self.view addSubview:tabV];
    _simpleTableView = tabV;
    [self layoutTableViewFrame:_simpleTableView];
    return _simpleTableView;
}


- (void)layoutTableViewFrame:(CKJSimpleTableView *)tableV {
    [tableV kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(superview.kjwdMas_safeAreaLeft);
        make.right.equalTo(superview.kjwdMas_safeAreaRight);
        make.top.equalTo(superview.kjwdMas_safeAreaTop);
        make.bottom.equalTo(superview.kjwdMas_safeAreaBottom);
    }];
}

- (void)installSimpleTableViewData {
}

- (void)initSimpleTableViewData {
}

/**
 点击某一行使用这个
 */
- (void)kj_tableView:(CKJSimpleTableView *)tableView didSelectRowAtSection:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath model:(__kindof CKJCommonCellModel *)model cell:(__kindof CKJCommonTableViewCell *)cell {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)createFooterViewWithBtnTitle:(NSString *)title clickHandle:(void(^_Nullable)(UIButton * _Nonnull sender, __kindof CKJBaseTableVC *se, CKJSimpleTableView *simpleTableView))clickHandle {
    
    KJ_typeweakself
    self.simpleTableView.tableFooterView = [self footerViewWithBtnTitle:title clickHandle:^(UIButton * _Nonnull sender) {
        if (clickHandle) {
            clickHandle(sender, weakSelf, weakSelf.simpleTableView);
        }
    }];
}



//- (void)dealloc {
//    [self kj_removeNotification];
//}
//- (void)kj_removeNotification {
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNoti_LoginSuccess object:nil];
//}
//
//- (void)kj_addNotification {
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucc:) name:kNoti_LoginSuccess object:nil];
//}




@end
