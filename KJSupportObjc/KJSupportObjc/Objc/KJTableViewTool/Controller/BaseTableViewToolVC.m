//
//  BaseTableViewToolVC.m
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/26.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import "BaseTableViewToolVC.h"


@interface BaseTableViewToolVC ()


@end

@implementation BaseTableViewToolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (_tableView) return _tableView;
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
    _tableView.dataSource = self.tableViewTool;
    _tableView.delegate = self.tableViewTool;
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_tableView];
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_tableView.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_tableView.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_tableView.superview attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_tableView.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [_tableView.superview addConstraints:@[left, top, right, bottom]];
    
    return _tableView;
}
- (CommonTableViewTool *)tableViewTool {
    if (_tableViewTool) return _tableViewTool;
    _tableViewTool = [CommonTableViewTool new];
    _tableViewTool.delegate = self;
    _tableViewTool.tablView = self.tableView;
    return _tableViewTool;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath model:(CommonTableViewCellModel *)model tableViewTool:(CommonTableViewTool *)tool {
}

@end
