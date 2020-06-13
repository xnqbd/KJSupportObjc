//
//  CKJEmptyCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/13.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJEmptyCell.h"

#import "CKJSimpleTableView.h"

@implementation CKJEmptyCellModel

- (instancetype)init {
    if (self = [super init]) {
        [self _showLine:NO];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

+ (instancetype)emptyCellModelWithHeight:(CGFloat)cellHeight showLine:(BOOL)showLine {
    CKJEmptyCellModel *model = [[CKJEmptyCellModel alloc] init];
    model.cellHeight = @(cellHeight);
    [model _showLine:showLine];
    return model;
}

@end




@interface CKJEmptyCell ()

@property (strong, nonatomic) UILabel *emptyLabel;

@end


@implementation CKJEmptyCell

- (void)setupData:(__kindof CKJCommonCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
//    WDCKJ_ifDEBUG(^{
//        self.emptyLabel.text = [NSString stringWithFormat:@"CKJEmptyCell   分区%ld 行%ld", section, row];
//        self.emptyLabel.backgroundColor = [UIColor orangeColor];
//    }, nil);
}

- (void)setupSubViews {
    UILabel *title = [[UILabel alloc] init];
    title.backgroundColor = [UIColor clearColor];
    //    WDCKJBGColor_Arc4Color(title);
    title.textColor = [UIColor kjwd_title];
    title.font = [UIFont systemFontOfSize:9];
    
    [self.subviews_SuperView addSubview:title];
    
    [title kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.edges.equalTo(superview);
    }];
    self.emptyLabel = title;
}


@end
