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



@end
