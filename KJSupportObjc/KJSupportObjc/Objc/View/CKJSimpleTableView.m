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

        self.rowHeight           = UITableViewAutomaticDimension;
        self.sectionHeaderHeight = UITableViewAutomaticDimension;
        self.sectionFooterHeight = UITableViewAutomaticDimension;
        
        self.estimatedRowHeight           = 44;
        self.estimatedSectionHeaderHeight = 20;
        self.estimatedSectionFooterHeight = 20;
        
    }
    return self;
}

- (void)disableEstimated {
    if (@available(iOS 11.0, *)) {
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
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
//        CKJCommonSectionModel *sectionModel = self.dataArr[section];
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
//    temp.estimatedSectionHeaderHeight = UITableViewAutomaticDimension;
//    temp.estimatedSectionFooterHeight = UITableViewAutomaticDimension;
    
    //        NSLog(@" \n ------------ %@  %@ \n ------------  %@     %@", tableView.dataSource, tableView.delegate, temp.simpleTableViewDataSource, temp.simpleTableViewDelegate);
    
    NSArray *array = self.dataArr;
    
    return array.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    CKJCommonSectionModel *sectionModel = [self.dataArr kjwd_objectAtIndex:section];
    [sectionModel setValue:@(section) forKey:@"currentSection"];
    
    // 显示的数组
    NSArray <CKJCommonCellModel *>*displayModelArray = [self displayCellModelArrayAtSection:section];
    
    NSInteger count = displayModelArray.count;
    return count;
}

- (UITableViewCell *)tableView:(CKJSimpleTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section, row = indexPath.row;

    CKJCommonSectionModel *sectionModel = self.dataArr[section];
    // 显示的数组
    NSArray <CKJCommonCellModel *>*displayModelArray = [self displayCellModelArrayAtSection:section];
    
    CKJCommonCellModel *model = displayModelArray[row];
    
    NSString *modelName = [NSString stringWithUTF8String:object_getClassName(model)];
    NSString *key = [modelName copy];
    modelName = [CKJSimpleTableView return_ModelName:modelName];
    
    NSString *kj_nameSpace = [CKJSimpleTableView kj_nameSpace];
    
    if ([modelName containsString:kj_nameSpace]) { // 为了Swift处理命名空间
        NSUInteger from = [modelName rangeOfString:kj_nameSpace].length;
        modelName = [modelName substringFromIndex:from];
    }
    CKJCommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:modelName];
    if (cell == nil) {
        NSDictionary *dic = self.cell_Model_keyValues[key];
        NSString *cellClass = dic[cellKEY];
        BOOL isRegisterNib = [dic[isRegisterNibKEY] boolValue];
        
        if (cellClass) {
            if (isRegisterNib) {
#warning 如果没有取出cell，看看xib文件有没有加入本项目的target
                cell = [tableView dequeueReusableCellWithIdentifier:cellClass forIndexPath:indexPath];
            } else {
                cell = [tableView dequeueReusableCellWithIdentifier:cellClass];
                if (cell == nil) {
                    cell = [[[CKJSimpleTableView returnClass_ClassString:cellClass] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellClass configDic:dic];
                }
                if ([cell isKindOfClass:[CKJCell class]]) {
                    ((CKJCell *)cell).ckjCellDataSource = tableView.ckjCellDataSource;
                }
            }
        } else {
            cell = [[CKJCommonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CKJCommonTableViewCell class])];
        }
    }
    cell.selectionStyle = model.selectionStyle;
    cell.section = section;
    cell.row = row;
    cell.simpleTableView = self;
    cell.cellModel = model;
    model.cell = cell;
    [cell setupData:model section:section row:row selectIndexPath:indexPath tableView:(CKJSimpleTableView *)tableView];
    
    return cell;
}


- (void)kjwd_setCellModels:(nullable NSArray <CKJCommonCellModel *>*)cellModels atSection:(NSInteger)section {
    CKJCommonSectionModel *sectionModel = [self.dataArr kjwd_objectAtIndex:section];
    sectionModel.modelArray = cellModels;
}



- (nullable __kindof CKJCommonCellModel *)cellModelOfFlag:(NSInteger)flag {
    for (CKJCommonSectionModel *section in self.dataArr) {
        for (CKJCommonCellModel *model in section.modelArray) {
            if (model.id_flag == flag) {
                return model;
            }
        }
    }
    return nil;
}
- (nullable __kindof CKJCommonSectionModel *)sectionModelOfFlag:(NSInteger)flag {
    for (CKJCommonSectionModel *section in self.dataArr) {
        if (section.id_flag == flag) {
            return section;
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
 拼接分区
 */
- (void)appendCKJCommonSectionModel:(CKJCommonSectionModel *)sectionModel {
    CKJSimpleTableView *tableV = self;
    NSMutableArray <CKJCommonSectionModel *>*sections = [NSMutableArray kjwd_arrayWithArray:tableV.dataArr];
    [sections kjwd_addObject:sectionModel];
    tableV.dataArr = sections;
}
- (void)appendCKJCommonSectionModels:(NSArray <CKJCommonSectionModel *>*_Nullable)sectionModels {
    if (sectionModels == nil) {
        return;
    }
    NSMutableArray <CKJCommonSectionModel *>*sections = [NSMutableArray kjwd_arrayWithArray:self.dataArr];
    [sections kjwd_addObjectsFromArray:sectionModels];
    self.dataArr = sections;
}
//- (void)appendCKJCommonSectionModels:(NSArray <CKJCommonSectionModel *>*_Nonnull)sectionModels withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nullable)(void(^_Nonnull animationBlock)(void)))animationBlock {
//    [self appendCKJCommonSectionModels:sectionModels];
//    
//    void (^block)(void) = ^{
//
//        WDCKJdispatch_async_main_queue(^{
//            [self deleteSections:indexSet withRowAnimation:rowAnimation];
//        });
//    };
//    animationBlock ? animationBlock(block) : nil;
//}

- (BOOL)kjwd_insertCellModelsInAllCellModel:(nullable NSArray<CKJCommonCellModel *>*)array section:(NSInteger)section row:(NSInteger)row {
    
    if (array == nil) {
        return NO;
    }
    
    NSMutableArray <CKJCommonSectionModel *>*sections = [NSMutableArray kjwd_arrayWithArray:self.dataArr];
    
    CKJCommonSectionModel *sectionModel = [sections kjwd_objectAtIndex:section];
    NSMutableArray <CKJCommonCellModel *>*cellModelArray = [NSMutableArray kjwd_arrayWithArray:sectionModel.modelArray];
    
    if ([cellModelArray kjwd_insertObjects:array atIndex:row] == NO) {
        return NO;
    }
    sectionModel.modelArray = cellModelArray;
    self.dataArr = sections;
    return YES;
}


- (void)kjwd_insertCellModelInAllCellModel:(nullable CKJCommonCellModel *)model section:(NSInteger)section row:(NSInteger)row withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nullable)(void(^_Nonnull animationBlock)(void)))animationBlock {
    if (model == nil) {
        return;
    }
    
    if ([self kjwd_insertCellModelsInAllCellModel:@[model] section:section row:row]) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:section];
        [self insertRowsAtIndexPaths:@[path] withRowAnimation:rowAnimation];
    }
}

- (BOOL)appendCellModelArray:(nullable NSArray <CKJCommonCellModel *>*)array atLastRow_InAllCellModelArrayOfSection:(NSInteger)section {
    if (WDKJ_IsNull_Array(array)) {
        return NO;
    }
    
    if (array.count == 0) {
        return NO;
    }
    
    if (section >= self.dataArr.count) {
        return NO;
    }
    
    NSMutableArray <CKJCommonSectionModel *>*sections = [NSMutableArray kjwd_arrayWithArray:self.dataArr];
    
    CKJCommonSectionModel *sectionModel = [sections kjwd_objectAtIndex:section];
    NSMutableArray <CKJCommonCellModel *>*all_cellModelArray = [NSMutableArray kjwd_arrayWithArray:sectionModel.modelArray];

    
    [all_cellModelArray kjwd_addObjectsFromArray:array];
    sectionModel.modelArray = all_cellModelArray;
    
    self.dataArr = sections;
    return YES;
}

- (void)appendCellModelArray:(nullable NSArray <CKJCommonCellModel *>*)array atLastRow_InAllCellModelArrayOfSection:(NSInteger)section withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nullable)(void(^_Nonnull animationBlock)(void)))animationBlock {
    if (WDKJ_IsNull_Array(array)) {
        return;
    }
    // 获取Array在拼接之前
    NSArray <CKJCommonCellModel *>*before_displayCellModelArray = [self displayCellModelArrayAtSection:section];
    
    if ([self appendCellModelArray:array atLastRow_InAllCellModelArrayOfSection:section] == NO) {
        return;
    }
    NSMutableArray *paths = [NSMutableArray array];
    
    NSUInteger count = before_displayCellModelArray.count;
    
    for (NSUInteger i = count; i < count + array.count; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:section];
        [paths addObject:path];
    }
    if (paths.count == 0) return;
    
    // 注意：在这里有时候，数据没有问题，但是就是会崩溃在这里，有时候是数据不同步
    [self insertRowsAtIndexPaths:paths withRowAnimation:rowAnimation];
}

- (BOOL)appendCellModelArray_atLastRow_InAllCellModelArrayOfLastSection_WithCellModelArray:(nullable NSArray <CKJCommonCellModel *>*)array {
    return [self appendCellModelArray:array atLastRow_InAllCellModelArrayOfSection:self.dataArr.count - 1];
}

- (void)appendCellModelArray_atLastRow_InAllCellModelArrayOfLastSection_WithCellModelArray:(nullable NSArray <CKJCommonCellModel *>*)array withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nullable)(void(^_Nonnull animationBlock)(void)))animationBlock {
    [self appendCellModelArray:array atLastRow_InAllCellModelArrayOfSection:self.dataArr.count - 1 withRowAnimation:rowAnimation animationBlock:animationBlock];
}

/**
 删除模型在某个分区的某一行
 */
- (void)removeCellModelAtSection:(NSInteger)section rows:(NSArray <NSNumber *>*_Nonnull)rows removeHiddenCellModel:(BOOL)removeHiddenCellModel {
    
    
    NSMutableArray <CKJCommonSectionModel *>*sections = [NSMutableArray kjwd_arrayWithArray:self.dataArr];
    
    CKJCommonSectionModel *sectionModel = [sections kjwd_objectAtIndex:section];
    NSMutableArray <CKJCommonCellModel *>*all_cellModelArray = [NSMutableArray kjwd_arrayWithArray:sectionModel.modelArray];
    NSArray <CKJCommonCellModel *>*displayCellModelArray = [self displayCellModelArrayAtSection:section];
    
    // 分为两部分， 1.part1  rows在all_cellModelArray的位置  2.  隐藏的 部分
    
    
    // 找到所有rows在all_cellModelArray的位置
    NSArray <NSNumber *>*part1 = [self returnIdexArray_displayCellModelArray:displayCellModelArray all_cellModelArray:all_cellModelArray displayCellModelArrayRows:rows];
    
    if (removeHiddenCellModel) {
        
        // 所有删除的Index下标
        NSMutableArray <NSNumber *>*allDeleteIndex = [NSMutableArray array];
        
        [allDeleteIndex kjwd_addObjectsFromArray:part1];
        
        // 找到隐藏的部分的下标
        NSArray <NSNumber *>*hiddenIndex = [self returnHiddenIndex_all_cellModelArray:all_cellModelArray];
        [allDeleteIndex kjwd_addObjectsFromArray:hiddenIndex];
        
        NSLog(@"所有删除的下标 %@ ", allDeleteIndex);
        // 进行删除操作
        [all_cellModelArray kjwd_removeAllObjects_IncludedRows:allDeleteIndex];
        
    } else {
        
        [all_cellModelArray kjwd_removeAllObjects_IncludedRows:part1];
    }
    
    sectionModel.modelArray = all_cellModelArray;
    self.dataArr = sections;
}

- (void)removeCellModelAtSection:(NSInteger)section rows:(NSArray <NSNumber *>*_Nonnull)rows removeHiddenCellModel:(BOOL)removeHiddenCellModel withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nullable)(void(^_Nonnull animationBlock)(void)))animationBlock {
    
    NSArray <CKJCommonCellModel *>*displayCellModelArray = [self displayCellModelArrayAtSection:section];
    
    
    // 取交集
    NSArray <NSNumber *>*arr = [displayCellModelArray.kjwd_indexArray kjwd_intersectWithArray:rows].allObjects;
//    NSIndexSet *indexSet = arr.kjwd_indexSetValue;
    
    NSMutableArray <NSIndexPath *>*paths = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:obj.integerValue inSection:section];
        [paths addObject:path];
    }];

    void (^block)(void) = ^{
        WDCKJdispatch_async_main_queue(^{
            [self deleteRowsAtIndexPaths:paths withRowAnimation:rowAnimation];
        });
    };
    
    [self removeCellModelAtSection:section rows:rows removeHiddenCellModel:removeHiddenCellModel];
    
    animationBlock ? animationBlock(block) : nil;
}

- (void)removeAllCellModelAtSection:(NSInteger)section keepDisplayRows:(NSArray <NSNumber *>*)keepDisplayRows removeHiddenCellModel:(BOOL)removeHiddenCellModel {
    NSMutableArray <CKJCommonSectionModel *>*sections = [NSMutableArray kjwd_arrayWithArray:self.dataArr];
    
    CKJCommonSectionModel *sectionModel = [sections kjwd_objectAtIndex:section];
    NSMutableArray <CKJCommonCellModel *>*all_cellModelArray = [NSMutableArray kjwd_arrayWithArray:sectionModel.modelArray];
    NSArray <CKJCommonCellModel *>*displayCellModelArray = [self displayCellModelArrayAtSection:section];
    
    if (removeHiddenCellModel) {
        [all_cellModelArray kjwd_removeAllObjects_notIncludedRows:keepDisplayRows];
    } else {
        // 分为两部分， 1.part1  保留部分notIncludedRows (应该找notIncludedRows在all_cellModelArray的位置)   2.  隐藏的 部分
        
        // 所有保留的Indexb下标
        NSMutableArray <NSNumber *>*allKeepIndex = [NSMutableArray array];
        
        // 找到所有notIncludedRows在all_cellModelArray的位置
        NSArray <NSNumber *>*part1 = [self returnIdexArray_displayCellModelArray:displayCellModelArray all_cellModelArray:all_cellModelArray displayCellModelArrayRows:keepDisplayRows];
        [allKeepIndex kjwd_addObjectsFromArray:part1];
        
        // 找到隐藏的部分的下标
        NSArray <NSNumber *>*hiddenIndex = [self returnHiddenIndex_all_cellModelArray:all_cellModelArray];
        [allKeepIndex kjwd_addObjectsFromArray:hiddenIndex];
        
//        NSLog(@"所有保留的下标 %@ ", allKeepIndex);
        // 进行删除操作
        [all_cellModelArray kjwd_removeAllObjects_notIncludedRows:allKeepIndex];
    }
    
    sectionModel.modelArray = all_cellModelArray;
    self.dataArr = sections;
}

- (void)removeAllCellModelAtSection:(NSInteger)section keepDisplayRows:(NSArray <NSNumber *>*)keepDisplayRows removeHiddenCellModel:(BOOL)removeHiddenCellModel withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nonnull)(void(^_Nonnull animationBlock)(void)))animationBlock {
    
    NSArray <CKJCommonCellModel *>*displayCellModelArray = [self displayCellModelArrayAtSection:section];
    
    // blockz要在删除之前取到 index
    void (^block)(void) = [self deleteAnimation_displayCellModelArray:displayCellModelArray youWantDeleteRows:nil orYouWantKeepRows:keepDisplayRows withRowAnimation:rowAnimation section:section];
    
    [self removeAllCellModelAtSection:section keepDisplayRows:keepDisplayRows removeHiddenCellModel:removeHiddenCellModel];
    animationBlock ? animationBlock(block) : nil;
}


/**
 删除某个分区
 */
- (void)removeSections:(NSArray <NSNumber *>*_Nonnull)includedSections {
    if (includedSections == nil) return;
    
    NSMutableArray <CKJCommonSectionModel *>*_sections = [NSMutableArray kjwd_arrayWithArray:self.dataArr];
    
    /*
     
     一共下面5个分区，
     
     0
     1  需要删除
     2
     3  需要删除
     4
     
     includedSections == @[ @1,  @3 , @9,  @20 ]
     
     */
    

   NSSet *set1 = [self.dataArr.kjwd_indexArray kjwd_intersectWithArray:includedSections];
    //NSLog(@"差集 %@ ", set1);
    
    [_sections removeObjectsAtIndexes:set1.allObjects.kjwd_indexSetValue];
    
    self.dataArr = _sections;
}

- (void)removeSections:(NSArray <NSNumber *>*_Nonnull)includedSections withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nonnull)(void(^_Nonnull animationBlock)(void)))animationBlock {
    
    if (includedSections == nil) return;
    
    // 不要删除这个
    NSArray *temp = self.dataArr;
    
    void (^block)(void) = ^{
        // 取交集
        NSArray *arr = [temp.kjwd_indexArray kjwd_intersectWithArray:includedSections].allObjects;
        NSIndexSet *indexSet = arr.kjwd_indexSetValue;
        
        WDCKJdispatch_async_main_queue(^{
            [self deleteSections:indexSet withRowAnimation:rowAnimation];
        });
    };
    
    [self removeSections:includedSections];
    
    animationBlock ? animationBlock(block) : nil;
}

/**
 删除全部分区（只保留指定分区）
 */
- (void)removeAllSection_notIncludedSection:(NSArray<NSNumber *> *_Nonnull)notIncludedSections {
    
    NSMutableArray <CKJCommonSectionModel *>*sections = [NSMutableArray kjwd_arrayWithArray:self.dataArr];
    
    [sections kjwd_removeAllObjects_notIncludedRows:notIncludedSections];
    self.dataArr = sections;
}

- (void)removeAllSection_notIncludedSection:(NSArray <NSNumber *>*_Nonnull)notIncludedSections withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nullable)(void(^_Nonnull animationBlock)(void)))animationBlock {
    
    NSMutableArray <CKJCommonSectionModel *>*sections = [NSMutableArray kjwd_arrayWithArray:self.dataArr];
    NSIndexSet *willDelete = [sections kjwd_returnIndexSet_notIncludedRowsOfYou:notIncludedSections];
    
    [self removeAllSection_notIncludedSection:notIncludedSections];

    void (^block)(void) = ^{
        WDCKJdispatch_async_main_queue(^{
            [self deleteSections:willDelete withRowAnimation:rowAnimation];
        });
    };
    animationBlock ? animationBlock(block) : nil;
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
//            NSLog(@"注册Nib %@ ", cellClass);
            [self registerNib:[UINib nibWithNibName:cellClass bundle:nil] forCellReuseIdentifier:cellClass];
        } else {
//            NSLog(@"注册Class %@ ", cellClass);
//            [self registerClass:NSClassFromString(cellClass) forCellReuseIdentifier:cellClass];
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
- (void)dealloc {
//    NSLog(@"%@ %p 销毁", [self class], self);
}

#pragma mark - 其他



#pragma mark - 公用
- (NSArray <NSNumber *>*)returnIdexArray_displayCellModelArray:(NSArray <CKJCommonCellModel *>*)displayCellModelArray all_cellModelArray:(NSArray <CKJCommonCellModel *>*)all_cellModelArray displayCellModelArrayRows:(NSArray <NSNumber *>*)displayCellModelRows {
    
    // 找到所有notIncludedRows在all_cellModelArray的位置
    NSMutableArray <NSNumber *>*idexArray = [NSMutableArray array];
    
    [displayCellModelRows enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CKJCommonCellModel *displayCellModel = [displayCellModelArray kjwd_objectAtIndex:obj.integerValue];
        NSNumber *idexNumber = [all_cellModelArray kjwd_indexOfObject:displayCellModel];
        [idexArray kjwd_addObject:idexNumber];
    }];
    return idexArray;
}

- (void(^)(void))deleteAnimation_displayCellModelArray:(NSArray <CKJCommonCellModel *>*)displayCellModelArray youWantDeleteRows:(NSArray <NSNumber *>*)deleteRows orYouWantKeepRows:(NSArray <NSNumber *>*)keepRows  withRowAnimation:(UITableViewRowAnimation)rowAnimation section:(NSInteger)section {
    
    NSMutableArray *displayArray = [NSMutableArray kjwd_arrayWithArray:displayCellModelArray];
    
    NSIndexSet *indexSet = [NSIndexSet indexSet];
    
    if (deleteRows) {
        indexSet = [displayArray kjwd_returnIndexSet_IncludedRowsOfYou:deleteRows];
    } else if (keepRows) {
        indexSet = [displayArray kjwd_returnIndexSet_notIncludedRowsOfYou:keepRows];
    }

    void (^block)(void) = ^{
        NSArray *temp = @[];
        if (deleteRows) {
            temp = deleteRows;
        } else if (keepRows) {
            temp = [displayArray kjwd_returnIndexSet_notIncludedRowsOfYou:keepRows].kjwd_returnArray;
        }
        
        if ([self verification_deleteIndex:temp displayModel:displayArray] == NO) {
            return;
        }
        WDCKJdispatch_async_main_queue(^{
            NSMutableArray <NSIndexPath *>*result = [NSMutableArray array];
            [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                NSIndexPath *path = [NSIndexPath indexPathForRow:idx inSection:section];
                [result addObject:path];
            }];
            [self deleteRowsAtIndexPaths:result withRowAnimation:rowAnimation];
        });
    };
    return block;
}

- (NSArray <NSNumber *>*)returnHiddenIndex_all_cellModelArray:(NSArray <CKJCommonCellModel *>*)all_cellModelArray {
    NSMutableArray <NSNumber *>*hiddenIndex = [NSMutableArray array];
    [all_cellModelArray kjwd_do_conformBlock:^BOOL(CKJCommonCellModel *obj, NSUInteger idx) {
        return obj.displayInTableView == NO;
    } handle:^(BOOL isConform, CKJCommonCellModel *obj, NSUInteger idx) {
        if (isConform) {
            [hiddenIndex addObject:@(idx)];
        }
    }];
    return hiddenIndex;
}

- (BOOL)verification_deleteIndex:(NSArray <NSNumber *>*)deleteIndex displayModel:(NSArray *)displayModel {
    
    NSNumber *max = [deleteIndex valueForKeyPath:@"@max.self"];
    if (max.integerValue >= displayModel.count) {
        NSLog(@"警告!  不包含的越界，不包含的行Index是 %ld, 当前数组个数是%ld 当前数组%@", (long)max.integerValue, (long)displayModel.count, displayModel);
        [self kjwd_reloadData];
        return NO;
    }
    return YES;
}

@end

