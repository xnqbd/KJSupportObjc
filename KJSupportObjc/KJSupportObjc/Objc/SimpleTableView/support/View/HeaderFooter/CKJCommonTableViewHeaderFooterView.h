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


//- (nonnull instancetype)initWithReuseIdentifier:(nonnull NSString *)reuseIdentifier tableView:(nonnull CKJSimpleTableView *)tableView;


@property (strong, nonatomic, nonnull) __kindof CKJCommonHeaderFooterModel *headerFooterModel;


/**
 *  此方法留着给子类重写，通常是拿到这几个参数 给子类的区头或区尾设置UI数据
 */
- (void)setupData:(nonnull CKJCommonHeaderFooterModel *)headerFooterModel section:(NSInteger)section tableView:(nonnull CKJSimpleTableView *)tableView;

- (void)setupSubViews;

@end
