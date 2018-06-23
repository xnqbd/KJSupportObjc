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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath model:(CommonTableViewCellModel *)model tableViewTool:(CommonTableViewTool *)tool {
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

- (void)dealloc {
    NSLog(@"%@ 销毁", self);
}

@end

