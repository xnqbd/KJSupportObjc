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

- (CGFloat)inputCellHeight {
    return 44;
}
- (instancetype)init {
    if (self = [super init]) {
         __weak typeof(self) weakSelf = self;
        self.input_block1 = ^(CKJInputCellModel *m, CKJInputExpressionRequiredModel * _Nullable emptyModel){
            m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDAtt15_5(nil) left:10];
            m.cellHeight = [weakSelf inputCellHeight];
            [m addRequired:emptyModel];
        };
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:247 / 255.0 green:247 / 255.0 blue:247 / 255.0 alpha:1];
    
    [self CKJSimpleTableView];
    self.simpleTableView.backgroundColor = self.view.backgroundColor;
}

- (UITableViewStyle)simpleTableViewStyle {
//    return UITableViewStylePlain;
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
    
//    tableV.translatesAutoresizingMaskIntoConstraints = NO;
//
//    UIView *subView = tableV;
//    UIView *superView = subView.superview;
//
//    if (superView == nil) return;
//
//    UIEdgeInsets edge = UIEdgeInsetsZero;
//
//    subView.translatesAutoresizingMaskIntoConstraints = NO;
//    if (@available(iOS 11.0, *)) {
//
//        id item = superView.safeAreaLayoutGuide;
//
//        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeLeft multiplier:1 constant:edge.left];
//        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeTop multiplier:1 constant:edge.top];
//        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeRight multiplier:1 constant:edge.right];
//        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeBottom multiplier:1 constant:edge.bottom];
//        [superView addConstraints:@[left, top, right, bottom]];
//    } else {
//        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeLeft multiplier:1 constant:edge.left];
//        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTop multiplier:1 constant:edge.top];
//        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeRight multiplier:1 constant:edge.right];
//        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeBottom multiplier:1 constant:edge.bottom];
//        [superView addConstraints:@[left, top, right, bottom]];
//    }
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

- (UIView *)footerViewWithBtnTitle:(NSString *)title clickHandle:(void(^_Nullable)(UIButton * _Nonnull sender))clickHandle {
    
    CGFloat swidth = [UIScreen mainScreen].bounds.size.width;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, swidth, 80)];
    bgView.backgroundColor = [UIColor clearColor];
    
    
    UIButton *save = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor kjwd_blueBtnColor]];
        [btn setTitle:title forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        [btn kjwd_addTouchUpInsideForCallBack:^(UIButton * _Nonnull sender) {
            if (clickHandle) {
                clickHandle(sender);
            }
        }];
        btn;
    });
    
    [save kjwd_addToSuperView:bgView constraints:^(MASConstraintMaker *make, UIView *superview) {
        make.center.mas_equalTo(superview);
        make.width.equalTo(superview).offset(-40).priority(550);
        make.height.equalTo(@45);
    }];
    return bgView;
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
