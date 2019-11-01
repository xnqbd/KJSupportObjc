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




@interface CKJEmptyCell ()

@property (strong, nonatomic) UILabel *emptyLabel;

@end


@implementation CKJEmptyCell

- (void)setupData:(__kindof CKJCommonCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
#ifdef DEBUG
//    self.emptyLabel.text = [NSString stringWithFormat:@"CKJEmptyCell   分区%ld 行%ld", section, row];
//    self.emptyLabel.backgroundColor = [UIColor orangeColor];
#endif
}

- (void)setupSubViews {
    //    self.textLabel.font = [UIFont systemFontOfSize:10];
    self.subviews_SuperView.backgroundColor = [UIColor colorWithRed:247 / 255.0 green:247 / 255.0 blue:247 / 255.0 alpha:1];
    
    
    UILabel *title = [UILabel new];
    //    WDCKJBGColor_Arc4Color(title);
    title.textColor = [UIColor kjwd_titleColor333333];
    title.font = [UIFont systemFontOfSize:9];
    
    [self.subviews_SuperView addSubview:title];
    
    [title kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.edges.equalTo(superview);
    }];
    self.emptyLabel = title;
}


@end
