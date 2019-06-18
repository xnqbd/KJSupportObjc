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
#import "CKJRadioCell.h"
#import "CKJInputCell.h"
#import "CKJTableViewCell1.h"
#import "CKJTableViewCell2.h"


#define KJ_typeweakself __weak typeof(self) weakSelf = self;


@protocol CKJSimpleTableViewDataSource <NSObject>

@required;
/**
 一定要匹配匹配正确
 键值对
 OC版本
 return @{NSStringFromClass([CKJCommonCellModel class]) : @{cellKEY : NSStringFromClass([CKJCommonTableViewCell class]), isRegisterNibKEY : @YES}};
 Swift版本
 return [NSStringFromClass(HZYHFWDYHFPayNotesCell2CellModel.self) : [cellKEY : NSStringFromClass(HZYHFWDYHFPayNotesCell2Cell.self), isRegisterNibKEY : false]]

 @return 键值对
 */
- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues;

@optional;

/**
 一定要匹配匹配正确
 键值对     return @{ NSStringFromClass([DemoHeaderModel class]) : NSStringFromClass([DemoHeader class])};
 @return 键值对
 */
- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnHeader_Model_keyValues;
- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnFooter_Model_keyValues;

/**
 保留Plain样式 区头悬浮
 */
- (BOOL)savePlainStyleSectionHeaderSuspension;

@end


@interface CKJSimpleTableView : UITableView <UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) NSArray <__kindof CKJCommonSectionModel *>* _Nullable dataArr;

@property (weak, nonatomic, nullable) IBOutlet id  <CKJSimpleTableViewDataSource> simpleTableViewDataSource;
@property (weak, nonatomic, nullable) IBOutlet id  <CKJSimpleTableViewDelegate> simpleTableViewDelegate;
@property (weak, nonatomic, nullable) IBOutlet id  <TitleStyleHeaderFooterViewDelegate> titleStyleHeaderFooterViewDelegate;



/**
 禁止估算高度(防止屏幕乱跳动)
 */
- (void)disableEstimated;

- (void)kjwd_setCellModels:(nullable NSArray <__kindof CKJCommonCellModel *>*)cellModels atSection:(NSInteger)section;

/** 遍历所有的cellModel */
- (void)kjwd_enumAllCellModelWithBlock:(nullable CKJCommonCellModelRowBlock)block;



/** 遍历所有的cellModel 找对应的模型 */
- (void)kjwd_filterCellModelForID:(NSInteger)cellModelID finishBlock:(nullable CKJCommonCellModelRowBlock)block;


/**
 取到对应cellModel_id的模型

 @param cellModel_id 唯一标识
 @return 对应的模型
 */
- (nullable __kindof CKJCommonCellModel *)cellModelOfID:(NSInteger)cellModel_id;
- (nullable __kindof CKJCommonSectionModel *)sectionModelOfID:(NSInteger)sectionModel_id;
- (void)searchCellModelOfID:(NSInteger)cellModel_id doSomething:(nullable CKJCommonCellModelRowBlock)doSomething;


/**
 在某个分区过滤模型
 */
- (nullable __kindof CKJCommonCellModel *)cellModelOfFilter:(BOOL (^)(__kindof CKJCommonCellModel *cellModel))filterBlock inSection:(NSUInteger)section;

/**
 在全部CellModel里过滤
 */
- (NSArray <__kindof CKJCommonCellModel *>*)kjwd_filterCellModelsAtAllCellModelWithBlock:(BOOL (^_Nonnull)(__kindof CKJCommonCellModel *_Nonnull cellModel))filterBlock;



/**
 根据

 @param section 分区
 @param conformBlock 遵守规则的条件
 @param handle 回调
 */
- (void)do_InSection:(NSUInteger)section conformBlock:(BOOL (^ _Nonnull)(__kindof CKJCommonCellModel *cellModel))conformBlock handle:(void(^ _Nonnull)(BOOL isConform, __kindof CKJCommonCellModel *cellModel))handle;

/**
 根据ID取出对应的索引
 */
- (nullable NSIndexPath *)indexPathOf_CellModel_id:(NSInteger)cellModel_id;


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
 插入模型在某个分区的某一行
 **************这个插入数据之后，需要手动的刷新数据，因为在insertRowsAtIndexPaths会位置出现， insertRowsAtIndexPaths每次只能插入一个数据，同时插入多个数据会造成插入动画数据有问题**************
 */
- (BOOL)kjwd_insertCellModelsInAllCellModel:(nullable NSArray<__kindof CKJCommonCellModel *>*)array section:(NSInteger)section row:(NSInteger)row;
/**
 使用动画 插入模型在某个分区的某一行
 **************调用此方法插入数据后，不要使用reloadRowsAtIndexPaths刷新，不然会崩溃，可以刷新当前所在的分区**************
 */
- (void)kjwd_insertCellModelInAllCellModel:(nullable __kindof CKJCommonCellModel *)model section:(NSInteger)section row:(NSInteger)row withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nullable)(void(^_Nonnull animationBlock)(void)))animationBlock;

/** 在AllCellModels的某一个模型后面插入数据 */
- (BOOL)kjwd_insertCellModelsInAllCellModel:(nullable NSArray<__kindof CKJCommonCellModel *>*)array afterCellModel:(__kindof CKJCommonCellModel *_Nullable)cellModel;



/**
 在指定分区的末尾拼接模型数组 (拼接在某一个分区所有CellModelArray包括隐藏的模型的 最后一行)
 */
- (BOOL)appendCellModelArray:(nullable NSArray <__kindof CKJCommonCellModel *>*)array atLastRow_InAllCellModelArrayOfSection:(NSInteger)section;
/**
 使用动画 在指定分区的末尾拼接模型数组 (拼接在某一个分区所有CellModelArray包括隐藏的模型的 最后一行)
 */
- (void)appendCellModelArray:(nullable NSArray <__kindof CKJCommonCellModel *>*)array atLastRow_InAllCellModelArrayOfSection:(NSInteger)section withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nullable)(void(^_Nonnull animationBlock)(void)))animationBlock;

/** 拼接在最后一个分区最后一行 */
- (BOOL)appendCellModelArray_atLastRow_InAllCellModelArrayOfLastSection_WithCellModelArray:(nullable NSArray <__kindof CKJCommonCellModel *>*)array;
/** 使用动画 拼接在最后一个分区最后一行 */
- (void)appendCellModelArray_atLastRow_InAllCellModelArrayOfLastSection_WithCellModelArray:(nullable NSArray <__kindof CKJCommonCellModel *>*)array withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nullable)(void(^_Nonnull animationBlock)(void)))animationBlock;


/**
 删除模型在某个分区的某一行
 rows 是指 displayInTableView为YES的模型的 rows
 */
- (void)removeCellModelAtSection:(NSInteger)section rows:(NSArray <NSNumber *>*_Nonnull)rows removeHiddenCellModel:(BOOL)removeHiddenCellModel;


/**
 使用动画 删除模型在某个分区的某一行
 rows 是指 displayInTableView为YES的模型的 rows
 */
- (void)removeCellModelAtSection:(NSInteger)section rows:(NSArray <NSNumber *>*_Nonnull)rows removeHiddenCellModel:(BOOL)removeHiddenCellModel withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nullable)(void(^_Nonnull animationBlock)(void)))animationBlock;


/** 删除模型在某个分区除了指定行的全有行（只保留指定行）*/
- (void)removeAllCellModelAtSection:(NSInteger)section keepDisplayRows:(NSArray <NSNumber *>*)keepDisplayRows removeHiddenCellModel:(BOOL)removeHiddenCellModel;
/** 使用动画  删除模型在某个分区除了指定行的全有行（只保留指定行）*/
- (void)removeAllCellModelAtSection:(NSInteger)section keepDisplayRows:(NSArray <NSNumber *>*)keepDisplayRows removeHiddenCellModel:(BOOL)removeHiddenCellModel withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nonnull)(void(^_Nonnull animationBlock)(void)))animationBlock;


/** 删除最后一个分区 */
- (void)removeLastSection;

/** 删除某个分区 */
- (void)removeSections:(NSArray <NSNumber *>*_Nonnull)includedSections;
/** 使用动画 删除某个分区 */
- (void)removeSections:(NSArray <NSNumber *>*_Nonnull)includedSections withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nonnull)(void(^_Nonnull animationBlock)(void)))animationBlock;

/** 删除全部分区（只保留指定分区）*/
- (void)removeAllSection_notIncludedSection:(NSArray <NSNumber *>*_Nonnull)notIncludedSections;
/** 使用动画 删除全部分区（只保留指定分区）*/
- (void)removeAllSection_notIncludedSection:(NSArray <NSNumber *>*_Nonnull)notIncludedSections withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nullable)(void(^_Nonnull animationBlock)(void)))animationBlock;

- (void)removeCellModelsByGroupId:(nullable NSString *)groupId inSection:(NSInteger)section removeHiddenCellModel:(BOOL)removeHiddenCellModel withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nullable)(void(^_Nonnull animationBlock)(void)))animationBlock;


/**
 根据cellModel找出 它在数组中的下标
 */
- (nullable NSArray <NSNumber *>*)returnRowsInSection:(NSInteger)section  handle:(BOOL(^_Nullable)(__kindof CKJCommonCellModel *_Nonnull m))handle;

#pragma mark - CKJPayCell相关
@property (strong, nonatomic, nullable) NSArray <__kindof CKJRadioCellModel *>*radioCellModels;
@property (strong, nonatomic, nullable, readonly) __kindof CKJRadioCellModel *currentSelectRadioCellModel;

@end
