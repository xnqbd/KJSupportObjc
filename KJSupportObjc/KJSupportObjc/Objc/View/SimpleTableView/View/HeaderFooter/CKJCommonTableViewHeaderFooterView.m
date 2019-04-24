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
#import "CKJTitleStyleHeaderFooterView.h"



@implementation CKJCommonTableViewHeaderFooterView

- (nonnull instancetype)initWithReuseIdentifier:(nonnull NSString *)reuseIdentifier tableView:(nonnull CKJSimpleTableView *)tableView {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setValue:tableView forKey:@"simpleTableView"];
        if ([self isKindOfClass:CKJTitleStyleHeaderFooterView.class]) {
            ((CKJTitleStyleHeaderFooterView *)self).delegate = tableView.titleStyleHeaderFooterViewDelegate;
        }
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
}

- (void)setupData:(CKJCommonHeaderFooterModel *)headerFooterModel section:(NSInteger)section tableView:(CKJSimpleTableView *)tableView {
    self.textLabel.text = headerFooterModel.systemTitle;
    self.detailTextLabel.text = headerFooterModel.systemSubTitle;
}


@end
