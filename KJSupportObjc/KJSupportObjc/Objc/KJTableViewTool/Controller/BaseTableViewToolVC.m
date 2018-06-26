//
//  BaseTableViewToolVC.m
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/26.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import "BaseTableViewToolVC.h"
#import "SimpleTableView.h"


@interface BaseTableViewToolVC ()


@end

@implementation BaseTableViewToolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self simpleTableView];
}
#pragma mark - 懒加载
- (SimpleTableView *)simpleTableView {
    if (_simpleTableView) return _simpleTableView;
    SimpleTableView *tabV = [[SimpleTableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    tabV.simpleTableViewDelegate = self;
    tabV.simpleTableViewDataSource = self;
    [self.view addSubview:tabV];
    _simpleTableView = tabV;
    [self layoutTableViewFrame];
    return _simpleTableView;
}

- (void)layoutTableViewFrame {
    self.simpleTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *subView = self.simpleTableView;
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


- (void)tableView:(UITableView *)tableView didSelectRowAtSection:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath model:(CommonTableViewCellModel *)model tableViewTool:(CommonTableViewTool *)tool {
    
}


@end
