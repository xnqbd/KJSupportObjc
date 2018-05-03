//
//  InformationCell.m
//  TableViewToolDemo
//
//  Created by chenkaijie on 2018/3/14.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "InformationCell.h"
#import "InformationCellModel.h"

@implementation InformationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupData:(CommonTableViewCellModel *)cellModel section:(NSInteger)section row:(NSInteger)row tableView:(UITableView *)tableView {
    [super setupData:cellModel section:section row:row tableView:tableView];
    
    InformationCellModel *model = (InformationCellModel *)cellModel;
    
//    NSLog(@"%@   第%ld分区  第%ld行   可以在这进行自己的操作 ", model.left_Title3, (long)section, (long)row);
}



@end
