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

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupData:(CommonTableViewCellModel *)cellModel section:(NSInteger)section row:(NSInteger)row tableView:(UITableView *)tableView {
    DemoModel *model = (DemoModel *)cellModel;
    self.textLabel.text = model.name;
}

@end
