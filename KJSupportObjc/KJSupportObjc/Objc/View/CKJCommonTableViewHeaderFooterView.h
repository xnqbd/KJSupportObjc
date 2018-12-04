//
//  CKJCKJCommonTableViewHeaderFooterView.h
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/21.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CKJCommonHeaderFooterModel, CKJSimpleTableView;

@interface CKJCommonTableViewHeaderFooterView : UITableViewHeaderFooterView


- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier tableView:(CKJSimpleTableView *)tableView;


/**
 名字不要改
 */
@property (weak, nonatomic, readonly) CKJSimpleTableView *simpleTableView;
@property (strong, nonatomic) CKJCommonHeaderFooterModel *headerFooterModel;

- (void)setupSubViews;


/**
 *  此方法留着给子类重写，通常是拿到这几个参数 给子类的区头或区尾设置UI数据
 */
- (void)setupData:(CKJCommonHeaderFooterModel *)headerFooterModel section:(NSInteger)section tableView:(CKJSimpleTableView *)tableView;



@end
