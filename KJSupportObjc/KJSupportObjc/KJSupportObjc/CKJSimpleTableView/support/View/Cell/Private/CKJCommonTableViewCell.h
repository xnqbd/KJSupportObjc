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
#import "CKJBaseModel.h"
#import "CKJSimpleTableViewDelegate.h"


NS_ASSUME_NONNULL_BEGIN


@class CKJCommonCellModel, CKJCommonHeaderFooterModel, CKJCommonTableViewTool, CKJSimpleTableView, CKJCommonSectionModel, CKJEmptyCellModel, CKJCommonCellConfig, CKJCornerLayer;

typedef void(^CKJCommonCellConfigBlock)(__kindof CKJCommonCellConfig *m);



@interface CKJCommonCellConfig : CKJCommonConfig


/// cellConfig
+ (instancetype)cellConfigWithDetail:(nullable CKJCommonCellConfigBlock)detailSettingBlock;

@end






@interface CKJCommonTableViewCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier configDic:(NSDictionary *)configDic;


/**
 和Cell一样大的唯一视图
 */
@property (strong, nonatomic, nonnull) UIView *onlyView;


/**
 如果是用xib、storyboard描述的，不需要把子视图加到这个bgV上，这个subviews_SuperView只是用纯代码的时候把子视图添加到这个上面
 */
@property (strong, nonatomic, nonnull) UIView *subviews_SuperView;

@property (strong, nonatomic) UIImageView *bgImageView;

@property (strong, nonatomic, nullable) CAShapeLayer *cornerLayer;


/**
 此属性只读，请不要手动修改它
 纯代码和Nib自定义Cell的时候，这configDic有先后顺序，具体请看.m文件
 */
@property (copy, nonatomic, nullable) NSDictionary *readOnly_configDic;
@property (strong, nonatomic, readonly, nullable) __kindof CKJCommonCellConfig *configModel;

@property (nonatomic, strong, nonnull) __kindof CKJCommonCellModel *cellModel;

@property (assign, nonatomic, readonly) NSInteger section;
@property (assign, nonatomic, readonly) NSInteger row;

- (CKJSimpleTableView *)simpleTableView;
- (__kindof CKJCommonSectionModel *)sectionModel;


/// 当前分区所有Cell模型数组(包括隐藏的)
@property (nonatomic, readonly, nonnull) NSArray <__kindof CKJCommonCellModel *>*currentSectionAllCellModelArray;


/// 此方法留着给子类重写，通常是拿到这几个参数 给子类cell设置UI数据
- (void)setupData:(__kindof CKJCommonCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView;



/// 设置子视图
- (void)setupSubViews;


/// 这是私有方法，不要私自调用
- (void)_privateMethodWithSimpleTableView:(nonnull CKJSimpleTableView *)tabV sectionModel:(CKJCommonSectionModel *)sectionModel section:(NSInteger)section row:(NSInteger)row cell:(CKJCommonTableViewCell *)cell model:(CKJCommonCellModel *)model;





@end


NS_ASSUME_NONNULL_END
