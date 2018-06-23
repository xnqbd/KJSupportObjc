//
//  CommonTableViewTool.m
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/21.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import "CommonTableViewTool.h"
#import "CommonTableViewHeaderFooterView.h"
#import "CommonTableViewCell.h"
#import "CommonHeaderFooterModel.h"

@interface CommonTableViewTool () 

@property (strong, nonatomic) NSMutableDictionary *cell_Model_keyValues;
@property (strong, nonatomic) NSMutableDictionary *header_Model_keyValues;
@property (strong, nonatomic) NSMutableDictionary *footer_Model_keyValues;

/**
 *  命名空间，为了防止Swift中没法加载正确的类名
 */
@property (copy, nonatomic) NSString *namespace;

@property (strong, nonatomic) UIView *tempHeaderFooterView;

@end

@implementation CommonTableViewTool


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    CommonHeaderFooterModel *headerModel = self.dataArr[section].headerModel;
    if (headerModel == nil) {
        return nil;
    }
    
    NSString *modelClassName = [NSString stringWithUTF8String:object_getClassName(headerModel)];
    
    if ([modelClassName containsString:self.namespace]) { // 为了Swift处理命名空间
        NSUInteger from = [modelClassName rangeOfString:self.namespace].length;
        modelClassName = [modelClassName substringFromIndex:from];
    }
    
    NSString *headerClass = self.header_Model_keyValues[modelClassName];
    
    if (headerClass) {
        
        CommonTableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerClass];
        
        if (headerView == nil) {
            headerView = [[[self returnClass_ClassString:headerClass] alloc] initWithReuseIdentifier:headerClass];
        }
        headerView.headerFooterModel = headerModel;
        [headerView setupData:headerModel section:section tableView:tableView];
        return headerView;
    } else {
        
        return self.tempHeaderFooterView;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    CommonHeaderFooterModel *footerModel = self.dataArr[section].footerModel;
    if (footerModel == nil) {
        return nil;
    }
    
    NSString *modelClassName = [NSString stringWithUTF8String:object_getClassName(footerModel)];
    
    if ([modelClassName containsString:self.namespace]) { // 为了Swift处理命名空间
        NSUInteger from = [modelClassName rangeOfString:self.namespace].length;
        modelClassName = [modelClassName substringFromIndex:from];
    }
    
    NSString *footerClass = self.footer_Model_keyValues[modelClassName];
    
    if (footerClass) {
        
        CommonTableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerClass];
        
        if (footerView == nil) {
            footerView = [[[self returnClass_ClassString:footerClass] alloc] initWithReuseIdentifier:footerClass];
        }
        footerView.headerFooterModel = footerModel;
        [footerView setupData:footerModel section:section tableView:tableView];
        return footerView;
    } else {
        return self.tempHeaderFooterView;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CommonSectionModel *sectionModel = self.dataArr[section];
    CommonHeaderFooterModel *headerModel = sectionModel.headerModel;
    if (headerModel == nil) {
        return sectionModel.headerHeight;
    } else {
        return UITableViewAutomaticDimension;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CommonSectionModel *sectionModel = self.dataArr[section];
    CommonHeaderFooterModel *footerModel = sectionModel.footerModel;
    if (footerModel == nil) {
        return sectionModel.footerHeight;
    } else {
        return UITableViewAutomaticDimension;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSArray *array = self.dataArr;
    [self cell_Model_keyValues];
    return array.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CommonSectionModel *sectionModel = self.dataArr[section];
    NSInteger count = sectionModel.modelArray.count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section, row = indexPath.row;
    
    CommonTableViewCellModel *cellModel = self.dataArr[section].modelArray[row];
    
    NSString *modelName = [NSString stringWithUTF8String:object_getClassName(cellModel)];
    modelName = [self return_ModelName:modelName];
    
    if ([modelName containsString:self.namespace]) { // 为了Swift处理命名空间
        NSUInteger from = [modelName rangeOfString:self.namespace].length;
        modelName = [modelName substringFromIndex:from];
    }
    CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:modelName];
    if (cell == nil) {
        NSDictionary *dic = self.cell_Model_keyValues[modelName];
        NSString *cellClass = dic[cellKEY];
        BOOL isRegisterNib = [dic[isRegisterNibKEY] boolValue];
        if (cellClass) {
            if (isRegisterNib) {
                cell = [tableView dequeueReusableCellWithIdentifier:cellClass forIndexPath:indexPath];
            } else {
                cell = [[[self returnClass_ClassString:cellClass] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellClass];
            }
        } else {
            cell = [[CommonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CommonTableViewCell class])];
        }
    }
    cell.cellModel = cellModel;
    [cell setupData:cellModel section:section row:row tableView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section, row = indexPath.row;
    CommonSectionModel *sectionModel = self.dataArr[section];
    CommonTableViewCellModel *cellModel = sectionModel.modelArray[row];
    
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtSection:row:selectIndexPath:model:tableViewTool:)]) {
        [self.delegate tableView:tableView didSelectRowAtSection:section row:row selectIndexPath:indexPath model:cellModel tableViewTool:self];
    }
}


#pragma mark - 键值对
- (NSMutableDictionary *)cell_Model_keyValues {
    if (_cell_Model_keyValues) return _cell_Model_keyValues;
    _cell_Model_keyValues = [NSMutableDictionary dictionary];
    
    NSDictionary *dic = @{
                          NSStringFromClass([CommonTableViewCellModel class]) : @{cellKEY : NSStringFromClass([CommonTableViewCell class]), isRegisterNibKEY : @NO},
                          
                          NSStringFromClass([KJCellModel class]) : @{cellKEY : NSStringFromClass([KJCell class]), isRegisterNibKEY : @NO}
                          
                          // 上面这两个个不要删除，只需 这样的键值对添加即可
                          };
    if ([self.dataSource respondsToSelector:@selector(returnCell_Model_keyValues)]) {
        NSDictionary *temp = [self.dataSource returnCell_Model_keyValues];
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
            [self.tablView registerNib:[UINib nibWithNibName:cellClass bundle:nil] forCellReuseIdentifier:cellClass];
        }
    }
    return _cell_Model_keyValues;
}

- (NSMutableDictionary *)header_Model_keyValues {
    if (_header_Model_keyValues) return _header_Model_keyValues;
    _header_Model_keyValues = [NSMutableDictionary dictionary];
    
    
    if ([self.dataSource respondsToSelector:@selector(returnHeader_Model_keyValues)]) {
        NSDictionary *temp = [self.dataSource returnHeader_Model_keyValues];
        [_header_Model_keyValues addEntriesFromDictionary:temp];
    }
    NSDictionary *dic = @{
                          NSStringFromClass([CommonHeaderFooterModel class]) :
                          NSStringFromClass([CommonTableViewHeaderFooterView class])
                          };
    [_header_Model_keyValues addEntriesFromDictionary:dic];
    return _header_Model_keyValues;
}

- (NSMutableDictionary *)footer_Model_keyValues {
    if (_footer_Model_keyValues) return _footer_Model_keyValues;
    _footer_Model_keyValues = [NSMutableDictionary dictionary];
    
    
    if ([self.dataSource respondsToSelector:@selector(returnFooter_Model_keyValues)]) {
        NSDictionary *temp = [self.dataSource returnFooter_Model_keyValues];
        [_footer_Model_keyValues addEntriesFromDictionary:temp];
    }
    NSDictionary *dic = @{
                          NSStringFromClass([CommonHeaderFooterModel class]) :
                              NSStringFromClass([CommonTableViewHeaderFooterView class])
                          };
    [_footer_Model_keyValues addEntriesFromDictionary:dic];
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
    NSLog(@"%@ 销毁", self);
}


@end
