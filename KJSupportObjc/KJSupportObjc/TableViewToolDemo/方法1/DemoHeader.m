//
//  DemoHeader.m
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/5/26.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "DemoHeader.h"
#import <Masonry/Masonry.h>
#import "DemoHeaderModel.h"

@interface DemoHeader()

@property (strong, nonatomic) UILabel *lab;

@end

@implementation DemoHeader

- (void)setupSubViews {
    UILabel *lab = [UILabel new];
    lab.backgroundColor = [UIColor lightGrayColor];
    lab.numberOfLines = 0;
    [self.contentView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    self.lab = lab;
}

- (void)setupData:(CommonHeaderFooterModel *)headerFooterModel section:(NSInteger)section tableView:(UITableView *)tableView {
    DemoHeaderModel *model = (DemoHeaderModel *)headerFooterModel;
    self.lab.text = model.title;
}


@end
