//
//  SimpleCollectionView.m
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/6/25.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "SimpleCollectionView.h"

@implementation SimpleCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self collectionViewTool];
    }
    return self;
}
//- (void)setSimpleCollectionViewDelegate:(id<CommonCollectionViewToolDelegate>)simpleCollectionViewDelegate {
//    
//}


- (CommonCollectionViewTool *)collectionViewTool {
    if (_collectionViewTool) return _collectionViewTool;
    
    _collectionViewTool = [CommonCollectionViewTool new];
    _collectionViewTool.collectView = self;
    _collectionViewTool.delegate = self;
    _collectionViewTool.dataSource = self;
    
    self.dataSource = _collectionViewTool;
    self.delegate = _collectionViewTool;
    
    return _collectionViewTool;
}

- (void)setDataArr:(NSArray<CommonCollectionViewSectionModel *> *)dataArr {
    _dataArr = dataArr;
    self.collectionViewTool.dataArr = dataArr;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtSection:(NSInteger)section item:(NSInteger)item selectIndexPath:(NSIndexPath *)indexPath model:(CommonCollectionViewCellModel *)model commonCollectionViewTool:(CommonCollectionViewTool *)commonCollectionViewTool {
    if ([self.simpleCollectionViewDelegate respondsToSelector:@selector(collectionView:didSelectItemAtSection:item:selectIndexPath:model:commonCollectionViewTool:)]) {
        [self.simpleCollectionViewDelegate collectionView:collectionView didSelectItemAtSection:section item:item selectIndexPath:indexPath model:model commonCollectionViewTool:self.collectionViewTool];
    }
}

- (NSDictionary<NSString *,NSDictionary<NSString *,id> *> *)returnCell_Model_keyValues {
    if ([self.simpleCollectionViewDataSource respondsToSelector:@selector(returnCell_Model_keyValues)]) {
        return [self.simpleCollectionViewDataSource returnCell_Model_keyValues];
    } else {
        return [NSDictionary dictionary];
    }
}

- (void)dealloc {
    NSLog(@"%@ %p 销毁", [self class], self);
}


@end
