//
//  CommonTableViewHeaderFooterView.m
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/21.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import "CommonTableViewHeaderFooterView.h"

@implementation CommonTableViewHeaderFooterView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
}

- (void)setupData:(CommonHeaderFooterModel *)headerFooterModel section:(NSInteger)section tableView:(UITableView *)tableView {
}


@end
