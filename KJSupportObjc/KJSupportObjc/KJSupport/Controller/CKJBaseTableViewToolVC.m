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
    return UITableViewStylePlain;
}

#pragma mark - 懒加载
- (CKJSimpleTableView *)CKJSimpleTableView {
    if (_simpleTableView) return _simpleTableView;
    CKJSimpleTableView *tabV = [[CKJSimpleTableView alloc] initWithFrame:CGRectZero style:[self simpleTableViewStyle]];
    tabV.tableFooterView = [UIView new];
    tabV.delegate = self;
    tabV.simpleTableViewDataSource = self;
    tabV.titleStyleHeaderFooterViewDelegate = self;
    tabV.ckjCellDataSource = self;
    [self.view addSubview:tabV];
    _simpleTableView = tabV;
    [self layoutTableViewFrame:_simpleTableView];
    return _simpleTableView;
}


- (CKJTableViewDelegateObject *)tableViewDelegateObject {
    if (_tableViewDelegateObject) return _tableViewDelegateObject;
    _tableViewDelegateObject = [CKJTableViewDelegateObject new];
    _tableViewDelegateObject.simpleTableView = self.simpleTableView;
    return _tableViewDelegateObject;
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

//- (void)imageBtn2_setup_left_Image_width_height:(MASConstraintMaker *)make section:(NSInteger)section row:(NSInteger)row {
//     make.width.height.equalTo(@(30));
//}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.tableViewDelegateObject tableView:tableView heightForHeaderInSection:section];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self.tableViewDelegateObject tableView:tableView viewForHeaderInSection:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self.tableViewDelegateObject tableView:tableView heightForFooterInSection:section];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self.tableViewDelegateObject tableView:tableView viewForFooterInSection:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.tableViewDelegateObject tableView:tableView heightForRowAtIndexPath:indexPath];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSInteger section = indexPath.section, row = indexPath.row;
    CKJCommonSectionModel *sectionModel = self.simpleTableView.dataArr[section];
    // 显示的数组
    NSArray <CKJCommonCellModel *>*displayModelArray = [self.simpleTableView displayCellModelArrayAtSection:section];
    
    CKJCommonCellModel *model = displayModelArray[row];
    
    CKJCommonTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [self kj_tableView:(CKJSimpleTableView *)tableView didSelectRowAtSection:section row:row selectIndexPath:indexPath model:model cell:cell];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableViewDelegateObject scrollViewDidScroll:scrollView];
}


/**
 点击某一行使用这个
 */
- (void)kj_tableView:(CKJSimpleTableView *)tableView didSelectRowAtSection:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath model:(__kindof CKJCommonCellModel *)model cell:(__kindof CKJCommonTableViewCell *)cell {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
