//
//  CKJCommonTableViewCell.h
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/21.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKJCommonCellModel.h"
#import "NSObject+WDYHFCategory.h"
#import "CKJCombineCellProtocol.h"
#import "CKJWorker.h"



@class CKJCommonCellModel, CKJCommonHeaderFooterModel, CKJCommonTableViewTool, CKJSimpleTableView, CKJCommonSectionModel, CKJEmptyCellModel, CKJCommonCellConfig;

typedef void(^CKJCommonCellConfigBlock)(__kindof CKJCommonCellConfig *_Nonnull m);


#define configDicKEY_ConfigModel @"configDicKEY_ConfigModel"


@interface CKJCommonCellConfig : CKJBaseModel

+ (nonnull instancetype)configWithDetailSettingBlock:(nullable CKJCommonCellConfigBlock)detailSettingBlock;

@end




@interface CKJCommonTableViewCell <E : CKJCommonCellModel *> : UITableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nonnull NSString *)reuseIdentifier configDic:(nonnull NSDictionary *)configDic;


@property (strong, nonatomic, nonnull) UIView *bgV;


/**
 此属性只读，请不要手动修改它
 纯代码和Nib自定义Cell的时候，这configDic有先后顺序，具体请看.m文件
 */
@property (copy, nonatomic, nullable) NSDictionary *configDic;
@property (strong, nonatomic, readonly, nullable) __kindof CKJCommonCellConfig *configModel;

@property (nonatomic, strong, nonnull) E cellModel;

@property (assign, nonatomic, readonly) NSInteger section;
@property (assign, nonatomic, readonly) NSInteger row;

@property (weak, nonatomic, readonly, nullable) CKJSimpleTableView *simpleTableView;
@property (nonatomic, readonly, nonnull) __kindof CKJCommonSectionModel *sectionModel;

/**
 当前分区所有Cell模型数组(包括隐藏的)
 */
@property (nonatomic, readonly, nonnull) NSArray <__kindof CKJCommonCellModel *>*currentSectionAllCellModelArray;

/**
 *  此方法留着给子类重写，通常是拿到这几个参数 给子类cell设置UI数据
 */
- (void)setupData:(nonnull __kindof CKJCommonCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *_Nonnull)indexPath tableView:(CKJSimpleTableView *_Nonnull)tableView;

/**
 设置子视图
 */
- (void)setupSubViews;

- (void)_privateMethodWithSimpleTableView:(nonnull CKJSimpleTableView *)tabV sectionModel:(nonnull CKJCommonSectionModel *)sectionModel section:(NSInteger)section row:(NSInteger)row;


@end
