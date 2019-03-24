//
//  CKJCommonTableViewCell.h
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/21.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CKJCommonCellModel.h"


@class CKJCommonCellModel, CKJCommonHeaderFooterModel, CKJCommonTableViewTool, CKJSimpleTableView, CKJCommonSectionModel;


@interface CKJCommonTableViewCell <E : CKJCommonCellModel *> : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier configDic:(NSDictionary *)configDic;

@property (strong, nonatomic, nonnull) UIView *bgV;

@property (copy, nonatomic, readonly) NSDictionary *configDic;

@property (nonatomic, strong, nonnull) E cellModel;

@property (assign, nonatomic, readonly) NSInteger section;
@property (assign, nonatomic, readonly) NSInteger row;

@property (weak, nonatomic, readonly) CKJSimpleTableView *simpleTableView;
@property (weak, nonatomic, readonly) __kindof CKJCommonSectionModel *sectionModel;

/**
 当前分区所有Cell模型数组(包括隐藏的)
 */
@property (weak, nonatomic, readonly) NSArray <__kindof CKJCommonCellModel *>*currentSectionAllCellModelArray;




/**
 *  此方法留着给子类重写，通常是拿到这几个参数 给子类cell设置UI数据
 */
- (void)setupData:(E)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *_Nonnull)indexPath tableView:(CKJSimpleTableView *_Nonnull)tableView;

/**
 设置子视图
 */
- (void)setupSubViews;



- (void)_privateMethodWithSimpleTableView:(CKJSimpleTableView *)tabV sectionModel:(CKJCommonSectionModel *)sectionModel section:(NSInteger)section row:(NSInteger)row;

@end
