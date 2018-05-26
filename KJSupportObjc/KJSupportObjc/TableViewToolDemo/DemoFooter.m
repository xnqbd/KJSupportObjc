//
//  DemoFooter.m
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/5/26.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "DemoFooter.h"

#import <Masonry/Masonry.h>
#import "DemoFooterModel.h"

@interface DemoFooter()

@property (strong, nonatomic) UILabel *lab;

@end

@implementation DemoFooter

- (void)setupSubViews {
    UILabel *lab = [UILabel new];
    lab.backgroundColor = [UIColor grayColor];
    lab.numberOfLines = 0;
    [self.contentView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    self.lab = lab;
}

- (void)setupData:(CommonHeaderFooterModel *)headerFooterModel section:(NSInteger)section tableView:(UITableView *)tableView {
    DemoFooterModel *model = (DemoFooterModel *)headerFooterModel;
    self.lab.text = model.title;
}


@end
