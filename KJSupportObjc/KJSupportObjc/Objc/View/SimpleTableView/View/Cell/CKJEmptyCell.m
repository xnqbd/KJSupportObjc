//
//  CKJEmptyCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/13.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJEmptyCell.h"


@implementation CKJEmptyCellModel

- (instancetype)init {
    if (self = [super init]) {
        self.showLine = NO;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

+ (instancetype)emptyCellModelWithHeight:(CGFloat)cellHeight showLine:(BOOL)showLine {
    CKJEmptyCellModel *model = [[CKJEmptyCellModel alloc] init];
    model.cellHeight = cellHeight;
    model.showLine = showLine;
    return model;
}

@end


@implementation CKJEmptyCell

- (void)setupData:(__kindof CKJCommonCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
#ifdef DEBUG
//    self.textLabel.text = [NSString stringWithFormat:@"CKJEmptyCell   分区%ld 行%ld", section, row];
#endif
}

- (void)setupSubViews {
    self.textLabel.font = [UIFont systemFontOfSize:10];
    self.bgV.backgroundColor = [UIColor colorWithRed:247 / 255.0 green:247 / 255.0 blue:247 / 255.0 alpha:1];
}

@end
