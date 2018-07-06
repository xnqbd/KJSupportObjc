//
//  SimpleTableView.m
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/6/23.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "SimpleTableView.h"

@implementation SimpleTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self tableViewTool];
    }
    return self;
}

- (CommonTableViewTool *)tableViewTool {
    if (_tableViewTool) return _tableViewTool;
    
    _tableViewTool = [CommonTableViewTool new];
    _tableViewTool.tablView = self;
    _tableViewTool.delegate = self;
    _tableViewTool.dataSource = self;
    
    self.dataSource = _tableViewTool;
    self.delegate = _tableViewTool;
    
    return _tableViewTool;
}

- (void)setDataArr:(NSArray<CommonSectionModel *> *)dataArr {
    _dataArr = dataArr;
    self.tableViewTool.dataArr = dataArr;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtSection:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath model:(CommonCellModel *)model tableViewTool:(CommonTableViewTool *)tool {
    if ([self.simpleTableViewDelegate respondsToSelector:@selector(tableView:didSelectRowAtSection:row:selectIndexPath:model:tableViewTool:)]) {
        [self.simpleTableViewDelegate tableView:tableView didSelectRowAtSection:indexPath.section row:indexPath.row
                 selectIndexPath:indexPath model:model tableViewTool:self.tableViewTool];
    }
}

- (nonnull NSDictionary <NSString *, NSString *> *)returnHeader_Model_keyValues {
    if ([self.simpleTableViewDataSource respondsToSelector:@selector(returnHeader_Model_keyValues)]) {
        return [self.simpleTableViewDataSource returnHeader_Model_keyValues];
    } else {
        return [NSDictionary dictionary];
    }
}
- (nonnull NSDictionary <NSString *, NSString *> *)returnFooter_Model_keyValues {
    if ([self.simpleTableViewDataSource respondsToSelector:@selector(returnFooter_Model_keyValues)]) {
        return [self.simpleTableViewDataSource returnFooter_Model_keyValues];
    } else {
        return [NSDictionary dictionary];
    }
}
- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues {
    if ([self.simpleTableViewDataSource respondsToSelector:@selector(returnCell_Model_keyValues)]) {
        return [self.simpleTableViewDataSource returnCell_Model_keyValues];
    } else {
        return [NSDictionary dictionary];
    }
}


#pragma mark - 删除添加操作

/**
 拼接在最后一个分区的 最后一行
 */
- (void)appendCellModelAtLastSectionLastRow:(CommonCellModel *)model {
    SimpleTableView *tableV = self;
    NSArray <CommonSectionModel *>*sections = tableV.dataArr;
    NSInteger section = sections.count - 1;
    
    CommonSectionModel *lastSection = sections.lastObject;
    
    NSInteger row = lastSection.modelArray.count;
    
    [self insertCellModel:model atSection:section row:row];
}
/**
 插入模型在某个分区的某一行
 */
- (void)insertCellModel:(CommonCellModel *)model atSection:(NSInteger)section row:(NSInteger)row {
    SimpleTableView *tableV = self;
    
    NSMutableArray <CommonSectionModel *>*sections = [NSMutableArray arrayWithArray:tableV.dataArr];
    CommonSectionModel *sectionModel = [sections kj_objectAtIndex:section];
    NSMutableArray <CommonCellModel *>*cellModelArray = [NSMutableArray arrayWithArray:sectionModel.modelArray];
    
    [cellModelArray kj_insertObject:model atIndex:row];
    sectionModel.modelArray = cellModelArray;
    
    tableV.dataArr = sections;
}
/**
 删除模型在某个分区的某一行
 */
- (void)removeCellModelAtSection:(NSInteger)section row:(NSInteger)row {
    SimpleTableView *tableV = self;
    
    NSMutableArray <CommonSectionModel *>*sections = [NSMutableArray arrayWithArray:tableV.dataArr];
    CommonSectionModel *sectionModel = [sections kj_objectAtIndex:section];
    NSMutableArray <CommonCellModel *>*cellModelArray = [NSMutableArray arrayWithArray:sectionModel.modelArray];
    
    [cellModelArray kj_removeObjectAtIndex:row];
    sectionModel.modelArray = cellModelArray;
    
    tableV.dataArr = sections;
}
/**
 删除某个分区
 */
- (void)removeSection:(NSInteger)section {
    SimpleTableView *tableV = self;
    
    NSMutableArray <CommonSectionModel *>*sections = [NSMutableArray arrayWithArray:tableV.dataArr];
    [sections kj_removeObjectAtIndex:section];
    tableV.dataArr = sections;
}




- (void)dealloc {
    NSLog(@"%@ %p 销毁", [self class], self);
}

@end

