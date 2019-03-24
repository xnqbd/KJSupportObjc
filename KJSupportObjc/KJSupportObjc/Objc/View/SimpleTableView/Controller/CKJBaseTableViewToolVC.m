//
//  CKJBaseTableViewToolVC.m
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/26.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import "CKJBaseTableViewToolVC.h"
#import "CKJSimpleTableView.h"
#import <Masonry/Masonry.h>

@interface CKJBaseTableViewToolVC ()

@end

@implementation CKJBaseTableViewToolVC

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


- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues {
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
    tableV.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *subView = tableV;
    UIView *superView = subView.superview;
    
    if (superView == nil) return;
    
    UIEdgeInsets edge = UIEdgeInsetsZero;
    
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    if (@available(iOS 11.0, *)) {
        
        id item = superView.safeAreaLayoutGuide;
        
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeLeft multiplier:1 constant:edge.left];
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeTop multiplier:1 constant:edge.top];
        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeRight multiplier:1 constant:edge.right];
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeBottom multiplier:1 constant:edge.bottom];
        [superView addConstraints:@[left, top, right, bottom]];
    } else {
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeLeft multiplier:1 constant:edge.left];
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTop multiplier:1 constant:edge.top];
        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeRight multiplier:1 constant:edge.right];
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeBottom multiplier:1 constant:edge.bottom];
        [superView addConstraints:@[left, top, right, bottom]];
    }
}

- (void)installSimpleTableViewData {
    
}

/**
 点击某一行使用这个
 */
- (void)kj_tableView:(CKJSimpleTableView *)tableView didSelectRowAtSection:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath model:(__kindof CKJCommonCellModel *)model cell:(__kindof CKJCommonTableViewCell *)cell {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
