//
//  CKJSimpleTableView.m
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/6/23.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "CKJSimpleTableView.h"
#import "NSObject+WDYHFCategory.h"

@interface CKJSimpleTableView ()

@property (strong, nonatomic) CKJTableViewDelegateObject *tableViewDelegateObject;

@end

@implementation CKJSimpleTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.tableFooterView = [UIView new];
    }
    return self;
}

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
    if ([self.simpleTableViewDelegate respondsToSelector:@selector(kj_tableView:didSelectRowAtSection:row:selectIndexPath:model:cell:)]) {
        NSInteger section = indexPath.section, row = indexPath.row;
        CKJCommonSectionModel *sectionModel = self.dataArr[section];
        // 显示的数组
        NSArray <CKJCommonCellModel *>*displayModelArray = [self displayCellModelArrayAtSection:section];
        
        CKJCommonCellModel *model = displayModelArray[row];
        CKJCommonTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        [self.simpleTableViewDelegate kj_tableView:(CKJSimpleTableView *)tableView didSelectRowAtSection:section row:row selectIndexPath:indexPath model:model cell:cell];
    } else {
        [self.tableViewDelegateObject tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    [self tableViewDelegateObject];
    
    CKJSimpleTableView *temp = (CKJSimpleTableView *)tableView;
    
    // 如果要进行header footer自适应高度，那么一定设置这个, 如果用xib、storyboard进行拖线SimpleTableView，那么xib、storyboard面板有默认的设置，是一个坑
    temp.estimatedSectionHeaderHeight = UITableViewAutomaticDimension;
    temp.estimatedSectionFooterHeight = UITableViewAutomaticDimension;
    
    //        NSLog(@" \n ------------ %@  %@ \n ------------  %@     %@", tableView.dataSource, tableView.delegate, temp.simpleTableViewDataSource, temp.simpleTableViewDelegate);
    
    NSArray *array = self.dataArr;
    
    return array.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // 显示的数组
    NSArray <CKJCommonCellModel *>*displayModelArray = [self displayCellModelArrayAtSection:section];
    
    NSInteger count = displayModelArray.count;
    return count;
}

- (UITableViewCell *)tableView:(CKJSimpleTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section, row = indexPath.row;
    
    CKJCommonSectionModel *sectionModel = self.dataArr[section];
    [sectionModel setValue:@(section) forKey:@"currentSection"];
    // 显示的数组
    NSArray <CKJCommonCellModel *>*displayModelArray = [self displayCellModelArrayAtSection:section];
    
    CKJCommonCellModel *model = displayModelArray[row];
    
    NSString *modelName = [NSString stringWithUTF8String:object_getClassName(model)];
    modelName = [CKJSimpleTableView return_ModelName:modelName];
    
    NSString *kj_nameSpace = [CKJSimpleTableView kj_nameSpace];
    
    
    
    if ([modelName containsString:kj_nameSpace]) { // 为了Swift处理命名空间
        NSUInteger from = [modelName rangeOfString:kj_nameSpace].length;
        modelName = [modelName substringFromIndex:from];
    }
    CKJCommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:modelName];
    if (cell == nil) {
        NSDictionary *dic = self.cell_Model_keyValues[modelName];
        NSString *cellClass = dic[cellKEY];
        BOOL isRegisterNib = [dic[isRegisterNibKEY] boolValue];
        if (cellClass) {
            if (isRegisterNib) {
#warning 如果没有取出cell，看看xib文件有没有加入本项目的target
                cell = [tableView dequeueReusableCellWithIdentifier:cellClass forIndexPath:indexPath];
            } else {
                cell = [tableView dequeueReusableCellWithIdentifier:cellClass forIndexPath:indexPath];
                if (cell == nil) {
                    cell = [[[CKJSimpleTableView returnClass_ClassString:cellClass] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellClass];
                }
                if ([cell isKindOfClass:[CKJCell class]]) {
                    ((CKJCell *)cell).ckjCellDataSource = tableView.ckjCellDataSource;
                }
            }
        } else {
            cell = [[CKJCommonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CKJCommonTableViewCell class])];
        }
    }
    cell.section = section;
    cell.row = row;
    cell.simpleTableView = self;
    cell.cellModel = model;
    model.cell = cell;
    [cell setupData:model section:section row:row selectIndexPath:indexPath tableView:(CKJSimpleTableView *)tableView];
    return cell;
}

- (nullable __kindof CKJCommonCellModel *)cellModelOfFlag:(int)flag {
    for (CKJCommonSectionModel *section in self.dataArr) {
        for (CKJCommonCellModel *model in section.modelArray) {
            if (model.id_flag == flag) {
                return model;
            }
        }
    }
    return nil;
}

- (nullable __kindof CKJCommonCellModel *)cellModelOfFilter:(BOOL (^)(__kindof CKJCommonCellModel *cellModel))filterBlock inSection:(NSUInteger)section {
    if (filterBlock == nil) {
        return nil;
    }
    CKJCommonSectionModel *sectionModel = [self.dataArr kjwd_objectAtIndex:section];
    for (CKJCommonCellModel *model in sectionModel.modelArray) {
        if (filterBlock(model)) {
            return model;
        }
    }
    return nil;
}

- (void)do_InSection:(NSUInteger)section conformBlock:(BOOL (^ _Nonnull)(__kindof CKJCommonCellModel *cellModel))conformBlock handle:(void(^ _Nonnull)(BOOL isConform, __kindof CKJCommonCellModel *cellModel))handle {
    if ((conformBlock == nil) || (handle == nil)) {
        return;
    }
    CKJCommonSectionModel *sectionModel = [self.dataArr kjwd_objectAtIndex:section];
    for (CKJCommonCellModel *model in sectionModel.modelArray) {
        if (conformBlock(model)) {
            handle(YES, model);
        } else {
            handle(NO, model);
        }
    }
}


- (nullable NSIndexPath *)indexPathOf_CKJCommonCellModel_Flag:(int)flag {
    __block NSIndexPath *indexPath = nil;
    [self.dataArr enumerateObjectsUsingBlock:^(CKJCommonSectionModel * _Nonnull sectionModel, NSUInteger sectionIdx, BOOL * _Nonnull stop) {
        [sectionModel.modelArray enumerateObjectsUsingBlock:^(CKJCommonCellModel * _Nonnull cellModel, NSUInteger rowIdx, BOOL * _Nonnull stop) {
            if (cellModel.id_flag == flag) {
                indexPath = [NSIndexPath indexPathForRow:rowIdx inSection:sectionIdx];
            }
        }];
    }];
    return indexPath;
}

- (nullable __kindof CKJCommonCellModel *)displayCellModel_AtLastSectionLastRow {
    __block CKJCommonCellModel *model = nil;
    [self.dataArr kjwd_reverseEnumerateObjectsUsingBlock:^(CKJCommonSectionModel *obj, NSUInteger idx, BOOL *stop) {
        NSArray <CKJCommonCellModel *>*cellModelArray = [self displayCellModelArrayAtSection:idx];
        if (cellModelArray.count) { // 如果有值
            model = cellModelArray.lastObject;
            *stop = YES;
        }
    }];
    return model;
}

#pragma mark - 删除添加操作

/**
 拼接在最后一个分区的 最后一行
 */
- (void)appendCellModelAtLastSectionLastRow:(CKJCommonCellModel *)model {
    CKJSimpleTableView *tableV = self;
    NSArray <CKJCommonSectionModel *>*sections = tableV.dataArr;
    NSInteger section = sections.count - 1;
    
    CKJCommonSectionModel *lastSection = sections.lastObject;
    
    NSInteger row = lastSection.modelArray.count;
    
    [self insertCellModel:model atSection:section row:row];
}

/**
 拼接分区
 */
- (void)appendCKJCommonSectionModel:(CKJCommonSectionModel *)sectionModel {
    CKJSimpleTableView *tableV = self;
    NSMutableArray <CKJCommonSectionModel *>*sections = [NSMutableArray arrayWithArray:tableV.dataArr];
    [sections kjwd_addObject:sectionModel];
    tableV.dataArr = sections;
}
/**
 插入模型在某个分区的某一行
 */
- (void)insertCellModel:(CKJCommonCellModel *)model atSection:(NSInteger)section row:(NSInteger)row {
    CKJSimpleTableView *tableV = self;
    
    NSMutableArray <CKJCommonSectionModel *>*sections = [NSMutableArray arrayWithArray:tableV.dataArr];
    CKJCommonSectionModel *sectionModel = [sections kjwd_objectAtIndex:section];
    NSMutableArray <CKJCommonCellModel *>*cellModelArray = [NSMutableArray arrayWithArray:sectionModel.modelArray];
    
    [cellModelArray kjwd_insertObject:model atIndex:row];
    sectionModel.modelArray = cellModelArray;
    
    tableV.dataArr = sections;
}

- (void)appendCellModelArray:(NSArray <CKJCommonCellModel *>*)array atLastRowOfSection:(NSInteger)section {
    
    CKJSimpleTableView *tableV = self;
    
    NSMutableArray <CKJCommonSectionModel *>*sections = [NSMutableArray arrayWithArray:tableV.dataArr];
    CKJCommonSectionModel *sectionModel = [sections kjwd_objectAtIndex:section];
    NSMutableArray <CKJCommonCellModel *>*cellModelArray = [NSMutableArray arrayWithArray:sectionModel.modelArray];
    
    [cellModelArray kjwd_addObjectsFromArray:array];
    sectionModel.modelArray = cellModelArray;
    
    tableV.dataArr = sections;
}
/**
 删除模型在某个分区的某一行
 */
- (void)removeCellModelAtSection:(NSInteger)section row:(NSInteger)row {
    CKJSimpleTableView *tableV = self;
    
    NSMutableArray <CKJCommonSectionModel *>*sections = [NSMutableArray arrayWithArray:tableV.dataArr];
    CKJCommonSectionModel *sectionModel = [sections kjwd_objectAtIndex:section];
    NSMutableArray <CKJCommonCellModel *>*cellModelArray = [NSMutableArray arrayWithArray:sectionModel.modelArray];
    
    [cellModelArray kjwd_removeObjectAtIndex:row];
    sectionModel.modelArray = cellModelArray;
    
    tableV.dataArr = sections;
}
/**
 删除模型在某个分区除了指定行的全有行（只保留指定行）
 */
- (void)removeAllCellModelAtSection:(NSInteger)section notIncludedRow:(NSInteger)notIncludedRow {
    
    NSMutableArray <CKJCommonSectionModel *>*sections = [NSMutableArray arrayWithArray:self.dataArr];
    CKJCommonSectionModel *sectionModel = [sections kjwd_objectAtIndex:section];
    NSMutableArray <CKJCommonCellModel *>*cellModelArray = [NSMutableArray arrayWithArray:sectionModel.modelArray];
    
    [cellModelArray kjwd_reverseEnumerateObjectsUsingBlock:^(CKJCommonCellModel *obj, NSUInteger idx, BOOL *stop) {
        if (idx != notIncludedRow) {
            [cellModelArray kjwd_safeRemoveObjectAtIndex:idx];
        }
    }];
    sectionModel.modelArray = cellModelArray;
    self.dataArr = sections;
}


- (void)removeAllCellModelAtSection:(NSInteger)section notIncludedRows:(NSArray <NSNumber *>*)notIncludedRows {
    
    NSMutableArray <CKJCommonSectionModel *>*sections = [NSMutableArray arrayWithArray:self.dataArr];
    CKJCommonSectionModel *sectionModel = [sections kjwd_objectAtIndex:section];
    NSMutableArray <CKJCommonCellModel *>*cellModelArray = [NSMutableArray arrayWithArray:sectionModel.modelArray];
    [cellModelArray kjwd_removeAllObjects_notIncludedRows:notIncludedRows];
    
    sectionModel.modelArray = cellModelArray;
    self.dataArr = sections;
}

/**
 删除某个分区
 */
- (void)removeSection:(NSInteger)section {
    CKJSimpleTableView *tableV = self;
    
    NSMutableArray <CKJCommonSectionModel *>*sections = [NSMutableArray arrayWithArray:tableV.dataArr];
    [sections kjwd_removeObjectAtIndex:section];
    tableV.dataArr = sections;
}

/**
 删除全部分区（只保留指定分区）
 */
- (void)removeAllSection_notIncludedSection:(NSInteger)notIncludedSection {
    
    NSMutableArray <CKJCommonSectionModel *>*sections = [NSMutableArray arrayWithArray:self.dataArr];
    [sections kjwd_reverseEnumerateObjectsUsingBlock:^(CKJCommonSectionModel *obj, NSUInteger idx, BOOL *stop) {
        if (idx != notIncludedSection) {
            [sections kjwd_safeRemoveObjectAtIndex:idx];
        }
    }];
    self.dataArr = sections;
}

- (CKJTableViewDelegateObject *)tableViewDelegateObject {
    if (_tableViewDelegateObject) return _tableViewDelegateObject;
    _tableViewDelegateObject = [CKJTableViewDelegateObject new];
    _tableViewDelegateObject.simpleTableView = self;
    return _tableViewDelegateObject;
}




- (NSArray <CKJCommonCellModel *>*)displayCellModelArrayAtSection:(NSInteger)section {
    
    CKJCommonSectionModel *sectionModel = [self.dataArr kjwd_objectAtIndex:section];
    
    // 显示的数组
    NSMutableArray <CKJCommonCellModel *>*displayModelArray = [NSMutableArray array];
    for (CKJCommonCellModel *model in sectionModel.modelArray) {
        if (model.displayInTableView) {
            [displayModelArray addObject:model];
        }
    }
    return displayModelArray;
}


#pragma mark - Swift命名空间相关
+ (NSString *)kj_nameSpace {
    NSString *namespace = [NSBundle mainBundle].infoDictionary[@"CFBundleExecutable"];
    namespace = [NSString stringWithFormat:@"%@.", namespace];
    return namespace;
}
+ (NSString *)return_ModelName:(NSString *)modelName {
    if ([modelName containsString:[self kj_nameSpace]]) { // 为了Swift处理命名空间
        NSUInteger from = [modelName rangeOfString:[self kj_nameSpace]].length;
        modelName = [modelName substringFromIndex:from];
    }
    return modelName;
}
+ (Class)returnClass_ClassString:(NSString *)classString {
    // 为了Swift处理命名空间
    Class ocClass = NSClassFromString(classString);
    Class swiftClass = NSClassFromString([NSString stringWithFormat:@"%@%@", [self kj_nameSpace], classString]);
    return ocClass ? ocClass : swiftClass;
}


#pragma mark - 键值对
- (NSMutableDictionary *)cell_Model_keyValues {
    if (_cell_Model_keyValues) return _cell_Model_keyValues;
    _cell_Model_keyValues = [NSMutableDictionary dictionary];
    
    NSDictionary *dic = @{
                          NSStringFromClass([CKJCommonCellModel class]) : @{cellKEY : NSStringFromClass([CKJCommonTableViewCell class]), isRegisterNibKEY : @NO},
                          NSStringFromClass([CKJCellModel class]) : @{cellKEY : NSStringFromClass([CKJCell class]), isRegisterNibKEY : @NO},
                          
                          // 上面这两个个不要删除，只需 这样的键值对添加即可
                          };
    if ([self.simpleTableViewDataSource respondsToSelector:@selector(returnCell_Model_keyValues)]) {
        NSDictionary *temp = [self.simpleTableViewDataSource returnCell_Model_keyValues];
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
            [self registerNib:[UINib nibWithNibName:cellClass bundle:nil] forCellReuseIdentifier:cellClass];
        } else {
            [self registerClass:NSClassFromString(cellClass) forCellReuseIdentifier:cellClass];
        }
    }
    
    return _cell_Model_keyValues;
}

- (NSMutableDictionary *)header_Model_keyValues {
    if (_header_Model_keyValues) return _header_Model_keyValues;
    _header_Model_keyValues = [NSMutableDictionary dictionary];
    
    
    if ([self.simpleTableViewDataSource respondsToSelector:@selector(returnHeader_Model_keyValues)]) {
        NSDictionary *temp = [self.simpleTableViewDataSource returnHeader_Model_keyValues];
        [_header_Model_keyValues addEntriesFromDictionary:temp];
    }
    NSDictionary *dic = @{
                          NSStringFromClass([CKJCommonHeaderFooterModel class]) :
                              NSStringFromClass([CKJCommonTableViewHeaderFooterView class]),
                          NSStringFromClass([CKJTableViewHeaderFooterEmptyModel class]) :
                              NSStringFromClass([CKJTableViewHeaderFooterEmptyView class]),
                          NSStringFromClass([CKJTitleStyleHeaderFooterModel class]) : NSStringFromClass([CKJTitleStyleHeaderFooterView class])
                          };
    [_header_Model_keyValues addEntriesFromDictionary:dic];
    return _header_Model_keyValues;
}

- (NSMutableDictionary *)footer_Model_keyValues {
    if (_footer_Model_keyValues) return _footer_Model_keyValues;
    _footer_Model_keyValues = [NSMutableDictionary dictionary];
    
    
    if ([self.simpleTableViewDataSource respondsToSelector:@selector(returnFooter_Model_keyValues)]) {
        NSDictionary *temp = [self.simpleTableViewDataSource returnFooter_Model_keyValues];
        [_footer_Model_keyValues addEntriesFromDictionary:temp];
    }
    NSDictionary *dic = @{
                          NSStringFromClass([CKJCommonHeaderFooterModel class]) :
                              NSStringFromClass([CKJCommonTableViewHeaderFooterView class]),
                          NSStringFromClass([CKJTableViewHeaderFooterEmptyModel class]) :
                              NSStringFromClass([CKJTableViewHeaderFooterEmptyView class]),
                          NSStringFromClass([CKJTitleStyleHeaderFooterModel class]) : NSStringFromClass([CKJTitleStyleHeaderFooterView class])
                          };
    [_footer_Model_keyValues addEntriesFromDictionary:dic];
    return _footer_Model_keyValues;
}
//- (void)dealloc {
//    NSLog(@"%@ %p 销毁", [self class], self);
//}

@end

