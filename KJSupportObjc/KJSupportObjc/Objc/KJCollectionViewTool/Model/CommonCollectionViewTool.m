//
//  CommonCollectionViewTool.m
//  RAC空项目
//
//  Created by chenkaijie on 2018/1/18.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CommonCollectionViewTool.h"

#import "CommonCollectionReusableView.h"
#import "CommonCollectionViewCell.h"



@interface CommonCollectionViewTool ()

@property (strong, nonatomic) NSMutableDictionary *cell_Model_keyValues;
@property (strong, nonatomic) NSMutableDictionary *header_Model_keyValues;
@property (strong, nonatomic) NSMutableDictionary *footer_Model_keyValues;


@property (strong, nonatomic) UIView *tempHeaderFooterView;

/**
 *  命名空间，为了防止Swift中没法加载正确的类名
 */
@property (copy, nonatomic) NSString *namespace;

@end

@implementation CommonCollectionViewTool


#define cellKEY  @"CellKEY"
#define isRegisterNibKEY  @"isRegisterNibKEY"


#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSInteger count = self.dataArr.count;
    return count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    CommonCollectionViewSectionModel *sectionModel = self.dataArr[section];
    NSArray *modelArray = sectionModel.modelArray;
    NSInteger count = modelArray.count;
    return count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
#warning 请一定要保证 self.collectView 有值!!! 不然没法创建cell
    NSInteger section = indexPath.section, item = indexPath.item;
    CommonCollectionViewSectionModel *sectionModel = self.dataArr[indexPath.section];
    CommonCellModel *model = sectionModel.modelArray[indexPath.item];
    
    
    NSString *modelName = [NSString stringWithUTF8String:object_getClassName(model)];
    modelName = [self return_ModelName:modelName];

    if ([modelName containsString:self.namespace]) { // 为了Swift处理命名空间
        NSUInteger from = [modelName rangeOfString:self.namespace].length;
        modelName = [modelName substringFromIndex:from];
    }
    
    NSDictionary *dic = self.cell_Model_keyValues[modelName];
    NSString *cellClass = dic[cellKEY];
    
    CommonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellClass forIndexPath:indexPath];
    
    cell.model = model;
    [cell setupData:model section:section item:item selectIndexPath:indexPath collectionView:collectionView collectionViewTool:self];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section, item = indexPath.item;
    
    CommonCollectionViewSectionModel *sectionModel = self.dataArr[section];
    CommonCellModel *model = sectionModel.modelArray[item];
    
    if ([self.delegate respondsToSelector:@selector(collectionView:didSelectItemAtSection:item:selectIndexPath:model:commonCollectionViewTool:)]) {
        [self.delegate collectionView:collectionView didSelectItemAtSection:section item:item selectIndexPath:indexPath model:model commonCollectionViewTool:self];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section, item = indexPath.item;
    
    CommonCollectionViewSectionModel *sectionModel = self.dataArr[section];
    
    CommonCollectionReusableViewModel *header_footer = nil;
    
    CommonCollectionReusableView *reusableview = nil;
    NSString *modelClass = nil;
    
    
    if (kind == UICollectionElementKindSectionHeader) {
        header_footer = sectionModel.headerModel;
        
        modelClass = NSStringFromClass([header_footer class]);
        NSString *headerClass = self.header_Model_keyValues[modelClass][cellKEY];
        
        
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerClass forIndexPath:indexPath];
        
    } else if (kind == UICollectionElementKindSectionFooter) {
        
        header_footer = sectionModel.footerModel;
        
        modelClass = NSStringFromClass([header_footer class]);
        NSString *footerClass = self.footer_Model_keyValues[modelClass][cellKEY];
        
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerClass forIndexPath:indexPath];
    }
    
    reusableview.reusableViewModel = header_footer;
    [reusableview setupData:header_footer section:section item:item selectIndexPath:indexPath collectionView:collectionView viewForSupplementaryElementOfKind:kind reusableView:reusableview tool:self];
    return reusableview;
}


//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//
//    return CGSizeMake(100, 50);
//}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CommonCollectionViewSectionModel *sectionModel = self.dataArr[section];
    CGSize size = sectionModel.headerSize;
    return size;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    CommonCollectionViewSectionModel *sectionModel = self.dataArr[section];
    CGSize size = sectionModel.footerSize;
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CommonCollectionViewSectionModel *sectionModel = self.dataArr[section];
    UIEdgeInsets edge = sectionModel.edgeInsets;
    return edge;
}



#pragma mark - 键值对
- (NSMutableDictionary *)cell_Model_keyValues {
    if (_cell_Model_keyValues) return _cell_Model_keyValues;
    _cell_Model_keyValues = [NSMutableDictionary dictionary];
    
    NSDictionary *dic = @{
                          NSStringFromClass([CommonCellModel class]) : @{cellKEY : NSStringFromClass([CommonCollectionViewCell class]), isRegisterNibKEY : @NO}
                          };
    if ([self.dataSource respondsToSelector:@selector(cl_returnCell_Model_keyValues)]) {
        NSDictionary *temp = [self.dataSource cl_returnCell_Model_keyValues];
        [_cell_Model_keyValues addEntriesFromDictionary:temp];
    }
    
    [_cell_Model_keyValues addEntriesFromDictionary:dic];
    
    for (NSString *key in _cell_Model_keyValues.allKeys) {
        NSString *modelClass = key;
        NSDictionary *dic = _cell_Model_keyValues[modelClass];
        
        NSString *cellClass = dic[cellKEY];
        BOOL isRegisterNib = [dic[isRegisterNibKEY] boolValue];
        
        if (cellClass == nil) {
            continue;
        }

        if (isRegisterNib) {
            [self.collectView registerNib:[UINib nibWithNibName:cellClass bundle:nil] forCellWithReuseIdentifier:cellClass];
        } else {
            [self.collectView registerClass:NSClassFromString(cellClass) forCellWithReuseIdentifier:cellClass];
        }
    }
    
    return _cell_Model_keyValues;
}


- (NSMutableDictionary *)header_Model_keyValues {
    if (_header_Model_keyValues) return _header_Model_keyValues;
    _header_Model_keyValues = [NSMutableDictionary dictionary];

    NSDictionary *dic = @{
                          NSStringFromClass([CommonCollectionReusableViewModel class]) : @{cellKEY : NSStringFromClass([CommonCollectionReusableView class]), isRegisterNibKEY : @NO}
                          };
  
    if ([self.dataSource respondsToSelector:@selector(cl_returnHeader_Model_keyValues)]) {
        NSDictionary *temp = [self.dataSource cl_returnHeader_Model_keyValues];
        [_header_Model_keyValues addEntriesFromDictionary:temp];
    }
    
    [_header_Model_keyValues addEntriesFromDictionary:dic];
    
    for (NSString *key in _header_Model_keyValues.allKeys) {
        NSString *modelClass = key;
        NSDictionary *dic = _header_Model_keyValues[modelClass];
        
        NSString *cellClass = dic[cellKEY];
        BOOL isRegisterNib = [dic[isRegisterNibKEY] boolValue];
        
        if (cellClass == nil) {
            continue;
        }
        
        if (isRegisterNib) {
            [self.collectView registerNib:[UINib nibWithNibName:cellClass bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cellClass];
        } else {
            [self.collectView registerClass:NSClassFromString(cellClass) forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cellClass];
        }
    }
    return _header_Model_keyValues;
}

- (NSMutableDictionary *)footer_Model_keyValues {
    if (_footer_Model_keyValues) return _footer_Model_keyValues;
    _footer_Model_keyValues = [NSMutableDictionary dictionary];
    
    NSDictionary *dic = @{
                          NSStringFromClass([CommonCollectionReusableViewModel class]) : @{cellKEY : NSStringFromClass([CommonCollectionReusableView class]), isRegisterNibKEY : @NO}
                          };
    
    if ([self.dataSource respondsToSelector:@selector(cl_returnFooter_Model_keyValues)]) {
        NSDictionary *temp = [self.dataSource cl_returnFooter_Model_keyValues];
        [_footer_Model_keyValues addEntriesFromDictionary:temp];
    }
    
    [_footer_Model_keyValues addEntriesFromDictionary:dic];
    
    for (NSString *key in _footer_Model_keyValues.allKeys) {
        NSString *modelClass = key;
        NSDictionary *dic = _footer_Model_keyValues[modelClass];
        
        NSString *cellClass = dic[cellKEY];
        BOOL isRegisterNib = [dic[isRegisterNibKEY] boolValue];
        
        if (cellClass == nil) {
            continue;
        }
        
        if (isRegisterNib) {
            [self.collectView registerNib:[UINib nibWithNibName:cellClass bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:cellClass];
        } else {
            [self.collectView registerClass:NSClassFromString(cellClass) forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:cellClass];
        }
    }
    return _footer_Model_keyValues;
}



- (UIView *)tempHeaderFooterView {
    if (_tempHeaderFooterView) return _tempHeaderFooterView;
    _tempHeaderFooterView = [UIView new];
    return _tempHeaderFooterView;
}

#pragma mark - Swift命名空间处理
- (NSString *)namespace {
    if (_namespace) return _namespace;
    NSString *namespace = [NSBundle mainBundle].infoDictionary[@"CFBundleExecutable"];
    namespace = [NSString stringWithFormat:@"%@.", namespace];
    _namespace = namespace;
    return _namespace;
}
- (NSString *)return_ModelName:(NSString *)modelName {
    if ([modelName containsString:self.namespace]) { // 为了Swift处理命名空间
        NSUInteger from = [modelName rangeOfString:self.namespace].length;
        modelName = [modelName substringFromIndex:from];
    }
    return modelName;
}
- (Class)returnClass_ClassString:(NSString *)classString {
    // 为了Swift处理命名空间
    Class ocClass = NSClassFromString(classString);
    Class swiftClass = NSClassFromString([NSString stringWithFormat:@"%@%@", self.namespace, classString]);
    return ocClass ? ocClass : swiftClass;
}



- (void)dealloc {
    NSLog(@"%@ %p 销毁", [self class], self);
}


@end

