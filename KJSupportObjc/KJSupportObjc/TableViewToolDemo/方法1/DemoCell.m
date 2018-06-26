//
//  DemoCell.m
//  FDS
//
//  Created by chenkaijie on 2018/5/9.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "DemoCell.h"
#import "DemoModel.h"

@implementation DemoCell

- (void)setupData:(DemoModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView tableViewTool:(CommonTableViewTool *)tool {
    self.textLabel.text = model.name;
}

@end
