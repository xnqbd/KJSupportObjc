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
#import "DemoHeader.h"
#import "DemoHeaderModel.h"

#import "DemoFooter.h"
#import "DemoFooterModel.h"

@interface DemoTableVC ()

@end

@implementation DemoTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray <CommonSectionModel *>*sections = [NSMutableArray array];
    
    {   // 分区1
        CommonSectionModel *section = [CommonSectionModel new];
        
        
        DemoModel *model1 = [DemoModel new];
        model1.name = @"张三";
        DemoModel *model2 = [DemoModel new];
        model2.name = @"李四";
        DemoModel *model3 = [DemoModel new];
        model3.name = @"王五";
        DemoHeaderModel *hearder = [DemoHeaderModel new];
        hearder.title = @"section0 头 自适应启高度-自适应启高度-自适应启高度-自适应启高度-自适应启高度-自适应启高度-自适应启高度";
        
        DemoFooterModel *footer = [DemoFooterModel new];
        footer.title = @"section0 尾";
        
        section.modelArray = @[model1, model2, model3];
        section.headerModel = hearder;
        section.footerModel = footer;
        
        [sections addObject:section];
    }
    {   // 分区2
        CommonSectionModel *section = [CommonSectionModel new];
        
        
        DemoModel *model1 = [DemoModel new];
        model1.name = @"刘备";
        DemoModel *model2 = [DemoModel new];
        model2.name = @"关羽";
        DemoModel *model3 = [DemoModel new];
        model3.name = @"张飞";
        DemoHeaderModel *hearder = [DemoHeaderModel new];
        hearder.title = @"section1 头";
        
        DemoFooterModel *footer = [DemoFooterModel new];
        footer.title = @"section1 尾 自适应启高度-自适应启高度-自适应启高度-自适";
        section.modelArray = @[model1, model2, model3];
        section.headerModel = hearder;
        section.footerModel = footer;
        
        [sections addObject:section];
    }
    
    
    self.simpleTableView.dataArr = sections;
    [self.simpleTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtSection:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath model:(CommonCellModel *)cellModel tableViewTool:(CommonTableViewTool *)tool {
    // 如果需要点击cell 进行处理事件， 可以在这里 写
    DemoModel *model = (DemoModel *)cellModel;
    NSLog(@"点击了 %@", model.name);
}

/**
 这个方法一定要实现
 */
- (nonnull NSDictionary<NSString *,NSDictionary<NSString *,id> *> *)returnCell_Model_keyValues {
    return @{NSStringFromClass([DemoModel class]) : @{cellKEY : NSStringFromClass([DemoCell class]), isRegisterNibKEY: @NO}};
}
- (NSDictionary<NSString *,NSString *> *)returnHeader_Model_keyValues {
  return @{ NSStringFromClass([DemoHeaderModel class]) : NSStringFromClass([DemoHeader class])
            };
}
- (NSDictionary<NSString *,NSString *> *)returnFooter_Model_keyValues {
    return @{ NSStringFromClass([DemoFooterModel class]) : NSStringFromClass([DemoFooter class])
              };
}


@end
