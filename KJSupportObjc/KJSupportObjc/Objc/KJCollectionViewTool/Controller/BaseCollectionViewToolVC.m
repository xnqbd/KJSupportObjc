//
//  BaseCollectionViewToolVC.m
//  RAC空项目
//
//  Created by chenkaijie on 2018/1/18.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "BaseCollectionViewToolVC.h"
#import "SimpleCollectionView.h"

@interface BaseCollectionViewToolVC ()

@end

@implementation BaseCollectionViewToolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self simpleCollectionView];
}

#pragma mark - 懒加载
- (UICollectionViewLayout *)get_subVC_collectionViewLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    CGRect rect = [UIScreen mainScreen].bounds;
//    layout.itemSize = CGSizeMake(rect.size.width / 4.0, rect.size.width / 4.0);
    layout.itemSize = CGSizeMake(100, 120);
    // 一个分区内，两个cell之间的最小间隔
    layout.minimumLineSpacing = 10;
    // 一个分区内，两个cell之间的最小间隔
    layout.minimumInteritemSpacing = 10;
    return layout;
}

- (SimpleCollectionView *)simpleCollectionView {
    if (_simpleCollectionView) return _simpleCollectionView;
    SimpleCollectionView *collV = [[SimpleCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[self get_subVC_collectionViewLayout]];
    collV.backgroundColor = [UIColor whiteColor];
    collV.simpleCollectionViewDataSource = self;
    collV.simpleCollectionViewDelegate = self;
    [self.view addSubview:collV];
    _simpleCollectionView = collV;
    
    // 设置约束或者frame
    [self layoutCollectionViewFrame:_simpleCollectionView];
    
    return _simpleCollectionView;
}

- (void)layoutCollectionViewFrame:(SimpleCollectionView *)collectionView {
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;

    UIView *subView = collectionView;
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




@end
