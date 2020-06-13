//
//  CKJCKJSimpleTableView.h
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/6/23.
//  Copyright © 2018年 uback. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKJCommonSectionModel.h"
#import "CKJCommonTableViewHeaderFooterView.h"
#import "CKJTitleStyleHeaderFooterView.h"
#import "CKJCommonTableViewCell.h"

#import "CKJTableViewHeaderFooterEmptyView.h"
#import "CKJCell.h"
#import "CKJSimpleTableViewDelegate.h"
#import "CKJSimpleTableViewDataSource.h"

#import "CKJInputCell.h"
#import "CKJInputCustomSuperCell.h"

#import "CKJTableViewCell1.h"
#import "CKJTableViewCell2.h"
#import "CKJGeneralCell.h"
#import "CKJImageLeftCell.h"
#import "CKJImageRightCell.h"
#import "CKJPayCell.h"

#import "CKJScrollViewCell.h"

#import "CKJLikeQRCell.h"
#import "CKJEmptyHeaderFooterCell.h"
#import "CKJFixMode.h"

#import "CKJSimpleTableViewStyle.h"
#import "CKJImageViewCell.h"
#import "CKJOneBtnCell.h"

#import "CKJLeftRightCenterEqualCell.h"
#import "CKJLeftRightTopEqualCell.h"

#import "CKJTwoBtnCell.h"




UIKIT_EXTERN CGFloat const kOCell_Left_Margin;



@class CKJSimpleTableViewStyle;

#define KJ_typeweakself __weak typeof(self) weakSelf = self;

NS_ASSUME_NONNULL_BEGIN

/*

     CKJSimpleTableView *tableView = [[CKJSimpleTableView alloc] init];
     tableView.backgroundColor = [UIColor clearColor];
     tableView.simpleTableViewDataSource = self;
     tableView.simpleTableViewDelegate = self;
     [tableView kjwd_addToSuperView:bgV constraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
        make.left.right.equalTo(superview);
     }];
     self.simpleTableView = tableView;
 */


@interface CKJSimpleTableView : UITableView <UITableViewDelegate, UITableViewDataSource>



/*
 UIView *tabV = [CKJSimpleTableView createSimpleTableViewWithEdge:UIEdgeInsetsMake(0, 20, 0, 20) style:UITableViewStylePlain detail:^(CKJSimpleTableView * _Nonnull s) {
     s.backgroundColor = [UIColor clearColor];
     s.contentInset = UIEdgeInsetsMake(22, 0, 0, 0);
     s.simpleTableViewDataSource = self;
     s.simpleTableViewDelegate = self;
     self.simpleTableView = s;
 }];
 [tabV kjwd_addToSuperView:bgV constraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
     make.left.right.equalTo(superview);
     make.top.equalTo(headerView.mas_bottom);
 }];
 */
+ (UIView *)createSimpleTableViewWithEdge:(UIEdgeInsets)edge style:(UITableViewStyle)style detail:(void(^)(CKJSimpleTableView * s))detail;

@property (strong, nonatomic) NSArray <__kindof CKJCommonSectionModel *>* _Nullable dataArr;
- (__kindof CKJCommonSectionModel *_Nullable)lastSection;


@property (weak, nonatomic, nullable) IBOutlet id  <CKJSimpleTableViewDataSource> simpleTableViewDataSource;
@property (weak, nonatomic, nullable) IBOutlet id  <CKJSimpleTableViewDelegate> simpleTableViewDelegate;
@property (weak, nonatomic, nullable) IBOutlet id  <TitleStyleHeaderFooterViewDelegate> titleStyleHeaderFooterViewDelegate;


@property (strong, nonatomic) CKJSimpleTableViewStyle *simpleStyle;
- (void)updateStyle:(void(^)(CKJSimpleTableViewStyle *s))update;

/**
 禁止估算高度(防止屏幕乱跳动)
 */
- (void)disableEstimated;

- (void)kjwd_setCellModels:(nullable NSArray <__kindof CKJCommonCellModel *>*)cellModels atSection:(NSInteger)section;

/** 遍历所有的cellModel */
- (void)kjwd_enumAllCellModelWithBlock:(void(^_Nullable)(__kindof CKJCommonCellModel * m, NSInteger section, NSInteger row, BOOL *stop))block;



/** 遍历所有的cellModel 找对应的模型 */
- (void)kjwd_filterCellModelForID:( NSString *)cellModelID finishBlock:(nullable CKJCommonCellModelRowBlock)block;


/**
 取到对应cellModel_id的模型

 @param cellModel_id 唯一标识
 @return 对应的模型
 */
- (nullable __kindof CKJCommonCellModel *)cellModelOfID:( NSString *)cellModel_id;
- (nullable __kindof CKJCellModel *)ckjCellModelOfID:( NSString *)cellModel_id;
- (nullable __kindof CKJInputCellModel *)inputCellModelOfID:( NSString *)cellModel_id;
- (nullable __kindof CKJCommonSectionModel *)sectionModelOfID:( NSString *)sectionModel_id;

- (void)searchSectionModelOfID:( NSString *)sectionModel_id doSomething:(void(^_Nullable)(__kindof CKJCommonSectionModel * sm))doSomething;

- (void)searchCellModelOfID:( NSString *)cellModel_id doSomething:(nullable CKJCommonCellModelRowBlock)doSomething;


/**
 在某个分区过滤模型
 */
- (nullable __kindof CKJCommonCellModel *)cellModelOfFilter:(BOOL (^)(__kindof CKJCommonCellModel *cellModel))filterBlock inSection:(NSUInteger)section;

/**
 在全部CellModel里过滤
 */
- (NSArray <__kindof CKJCommonCellModel *>*)kjwd_filterCellModelsAtAllCellModelWithBlock:(BOOL (^)(__kindof CKJCommonCellModel * cellModel))filterBlock;



/**
 根据

 @param section 分区
 @param conformBlock 遵守规则的条件
 @param handle 回调
 */
- (void)do_InSection:(NSUInteger)section conformBlock:(BOOL (^_Nullable)(__kindof CKJCommonCellModel *cellModel))conformBlock handle:(void(^_Nullable)(BOOL isConform, __kindof CKJCommonCellModel *cellModel))handle;

/**
 根据ID取出对应的索引
 */
- (nullable NSIndexPath *)indexPathOf_CellModel_id:( NSString *)cellModel_id;


/**
 属性是displayInTableView最后一个分区最后一行的模型

 @return 最后一个模型
 */
- (nullable __kindof CKJCommonCellModel *)displayCellModel_AtLastSectionLastRow;

#pragma mark - 操作相关
/**
 需要显示在TableView上的cellModel模型数组
 
 @param section 想查询的对应的分区
 @return 对应分区cellModel模型数组
 */
- (NSArray <__kindof CKJCommonCellModel *>*)displayCellModelArrayAtSection:(NSInteger)section;


/**
 拼接分区
 */
- (void)appendCKJCommonSectionModel:(nullable __kindof CKJCommonSectionModel *)sectionModel;
- (void)appendCKJCommonSectionModels:(nullable NSArray <__kindof CKJCommonSectionModel *>*)sectionModels;


/**
 在某个模型的后面 插入模型
 **************这个插入数据之后，需要手动的刷新数据，因为在insertRowsAtIndexPaths会位置出现， insertRowsAtIndexPaths每次只能插入一个数据，同时插入多个数据会造成插入动画数据有问题**************
 */
- (BOOL)kjwd_insertCellModelsInAllCellModel:(nullable NSArray<__kindof CKJCommonCellModel *>*)cellModels afterCellModel:(__kindof CKJCommonCellModel *_Nullable)positionModel;

/**
 使用动画 在某个模型的后面 插入模型
 **************调用此方法插入数据后，不要使用reloadRowsAtIndexPaths刷新，不然会崩溃，可以刷新当前所在的分区**************
 */
- (BOOL)kjwd_insertCellModelInAllCellModel:(__kindof CKJCommonCellModel *_Nullable)cellModel afterCellModel:(__kindof CKJCommonCellModel *_Nullable)positionModel withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nullable)(void(^ animationBlock)(void)))animationBlock;



/**
 在指定分区的末尾拼接模型数组 (拼接在某一个分区所有CellModelArray包括隐藏的模型的 最后一行)
 */
- (BOOL)appendCellModelArray:(nullable NSArray <__kindof CKJCommonCellModel *>*)array atLastRow_InAllCellModelArrayOfSection:(NSInteger)section;
/**
 使用动画 在指定分区的末尾拼接模型数组 (拼接在某一个分区所有CellModelArray包括隐藏的模型的 最后一行)
 */
- (void)appendCellModelArray:(nullable NSArray <__kindof CKJCommonCellModel *>*)array atLastRow_InAllCellModelArrayOfSection:(NSInteger)section withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nullable)(void(^ animationBlock)(void)))animationBlock;

/** 拼接在最后一个分区最后一行 */
- (BOOL)appendCellModelArray_atLastRow_InAllCellModelArrayOfLastSection_WithCellModelArray:(nullable NSArray <__kindof CKJCommonCellModel *>*)array;
/** 使用动画 拼接在最后一个分区最后一行 */
- (void)appendCellModelArray_atLastRow_InAllCellModelArrayOfLastSection_WithCellModelArray:(nullable NSArray <__kindof CKJCommonCellModel *>*)array withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nullable)(void(^ animationBlock)(void)))animationBlock;


/**
 删除模型在某个分区的某一行
 rows 是指 displayInTableView为YES的模型的 rows
 */
- (void)removeCellModelAtSection:(NSInteger)section rows:(NSArray <NSNumber *>*)rows removeHiddenCellModel:(BOOL)removeHiddenCellModel;


/**
 使用动画 删除模型在某个分区的某一行
 rows 是指 displayInTableView为YES的模型的 rows
 */
- (void)removeCellModelAtSection:(NSInteger)section rows:(NSArray <NSNumber *>*)rows removeHiddenCellModel:(BOOL)removeHiddenCellModel withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nullable)(void(^ animationBlock)(void)))animationBlock;


/** 删除模型在某个分区除了指定行的全有行（只保留指定行）*/
- (void)removeAllCellModelAtSection:(NSInteger)section keepDisplayRows:(NSArray <NSNumber *>*)keepDisplayRows removeHiddenCellModel:(BOOL)removeHiddenCellModel;
/** 使用动画  删除模型在某个分区除了指定行的全有行（只保留指定行）*/
- (void)removeAllCellModelAtSection:(NSInteger)section keepDisplayRows:(NSArray <NSNumber *>*)keepDisplayRows removeHiddenCellModel:(BOOL)removeHiddenCellModel withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^)(void(^ animationBlock)(void)))animationBlock;




/** 删除最后一个分区 */
- (void)removeLastSection;

/** 删除某个分区 */
- (void)removeSections:(NSArray <NSNumber *>*)includedSections;
/** 使用动画 删除某个分区 */
- (void)removeSections:(NSArray <NSNumber *>*)includedSections withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^)(void(^ animationBlock)(void)))animationBlock;

/** 删除全部分区（只保留指定分区）*/
- (void)removeAllSection_notIncludedSection:(NSArray <NSNumber *>*)notIncludedSections;
/** 使用动画 删除全部分区（只保留指定分区）*/
- (void)removeAllSection_notIncludedSection:(NSArray <NSNumber *>*)notIncludedSections withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nullable)(void(^ animationBlock)(void)))animationBlock;

- (void)removeCellModelsByGroupId:(nullable NSString *)groupId inSection:(NSInteger)section removeHiddenCellModel:(BOOL)removeHiddenCellModel withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nullable)(void(^ animationBlock)(void)))animationBlock;


/**
 根据cellModel找出 它在数组中的下标
 */
- (nullable NSArray <NSNumber *>*)returnRowsInSection:(NSInteger)section  handle:(BOOL(^_Nullable)(__kindof CKJCommonCellModel * m))handle;




#pragma mark - 选中样式 相关

/**
 整个TableView只有一行是选中的 样式
 
 self.leftTableView.selectStyleBlock = ^(__kindof CKJTableViewCell1Model *  m, BOOL isCurrentCellModel) {
 m.cell_bgColor = isCurrentCellModel ? [UIColor whiteColor] : [UIColor kjwd_r:246 g:246 b:246 alpha:1];
 };
 */
@property (copy, nonatomic, nullable) void (^selectStyleBlock)(__kindof CKJCommonCellModel * m, BOOL isCurrentCellModel);

- (void)enumAllCellModelsAndSet_SelectedStyleWithCellModel:(__kindof CKJCommonCellModel *_Nullable)cellModel;

#pragma mark - 单选相关

- (void)addRadioCellModels:(NSArray <__kindof CKJCommonCellModel *>*_Nullable)radioCellModels;
@property (strong, nonatomic, nullable) NSArray <__kindof CKJCommonCellModel *>*radioCellModels;
@property (strong, nonatomic, nullable, readonly) __kindof CKJCommonCellModel *currentSelectRadioCellModel;

/**
 触发了单选事件

 @param m 触发事件Cell的模型
 */
- (void)triggerRadioActionWithCellModel:(__kindof CKJCommonCellModel *)m;


#pragma mark - 输入框相关

/// 控制台输出 输入框的值
- (void)readInputValue;

/// 验证所有CKJInputCell的输入框是否为空
- (BOOL)verityInputFail;


/// 标题(可为空) 输入框
/// @param title 如果不需要标题，可以设置为nil或""
/// @param emptyRequirdText 如果不需要空必须，可以设置为nil或""
- (CKJInputCellModel *)_newtitle:(NSString *_Nullable)title tfText:(NSString *)text placeholder:(id)placeholder emptyRequirdText:(nullable NSString *)emptyRequirdText cellId:(nonnull NSString *)cellId detail:(nullable CKJInputCellModelRowBlock)detail;




@end



#pragma mark - 分类
@interface NSMutableArray <ObjectType> (CKJSimpleTableView)


/**
 网络获取Models模型数组 转成 CellModels数组
 
 @param ResponseDataModels 网络模型数组
 @param CellModelClass CellModelClass类（必须是CKJCommonCellModel子类）
 @param callBack 可以详细设置CellModel数据， 比如高度或者其他
 */
+ (instancetype )kjwd_arrayWithResponseDataModels:(NSArray * _Nullable)ResponseDataModels CellModelClass:(Class )CellModelClass callBack:(void(^_Nullable )(__kindof CKJCommonCellModel * currentModel))callBack;

/**
 Dics 转 CellMoldes和ResponseDataModels
 */
+ (instancetype)kjwd_arrayWithResponseDics:(NSArray <NSDictionary *>* _Nullable)responseDics ResponseDataModelClass:(Class)responseDataModelClass CellModelClass:(Class _Nonnull)CellModelClass callBack:(void(^_Nullable )(__kindof CKJCommonCellModel *currentModel, id dataModel))callBack;



@end


NS_ASSUME_NONNULL_END
