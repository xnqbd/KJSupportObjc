//
//  DemoTableVC.m
//  FDS
//
//  Created by chenkaijie on 2018/5/9.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "DemoTableVC.h"
#import "DemoModel.h"

#import "DemoCell.h"

@interface DemoTableVC ()

@end

@implementation DemoTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DemoModel *model1 = [DemoModel new];
    model1.name = @"张三";
    DemoModel *model2 = [DemoModel new];
    model2.name = @"李四";
    DemoModel *model3 = [DemoModel new];
    model3.name = @"王五";
    
    CommonSectionModel *section = [CommonSectionModel new];
    section.modelArray = @[model1, model2, model3];
    self.tableViewTool.dataArr = @[section];
    [self.tableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtSection:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath model:(CommonTableViewCellModel *)cellModel tableViewTool:(CommonTableViewTool *)tool {
    // 如果需要点击cell 进行处理事件， 可以在这里 写
    DemoModel *model = (DemoModel *)cellModel;
    NSLog(@"点击了 %@", model.name);
}

/**
 这个方法一定要实现
 */
- (NSDictionary<NSString *,NSDictionary<NSString *,id> *> *)returnCell_Model_keyValues {
    return @{NSStringFromClass([DemoModel class]) : @{cellKEY : NSStringFromClass([DemoCell class]), isRegisterNibKEY: @NO}};
}


@end
