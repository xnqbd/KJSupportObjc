//
//  CKJCommonTableViewHeaderFooterView.m
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/21.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import "CKJCommonTableViewHeaderFooterView.h"
#import "CKJCommonHeaderFooterModel.h"
#import "CKJSimpleTableView.h"

@implementation CKJCommonTableViewHeaderFooterView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        // 我没有在这进行 setupSubViews， 而是在 initWithReuseIdentifier 返回之后 setupSubViews，达到一样布局的效果
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
}

- (void)setupData:(CKJCommonHeaderFooterModel *)headerFooterModel section:(NSInteger)section tableView:(UITableView *)tableView {
    self.textLabel.text = headerFooterModel.systemTitle;
    self.detailTextLabel.text = headerFooterModel.systemSubTitle;
}


@end
