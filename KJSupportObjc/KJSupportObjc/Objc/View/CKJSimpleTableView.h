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
#import "CKJSimpleTableView.h"
#import "CKJCommonTableViewCell.h"
#import "CKJTableViewDelegateObject.h"
#import "CKJTableViewHeaderFooterEmptyView.h"
#import "CKJCell.h"

#define cellKEY  @"CellKEY"
#define isRegisterNibKEY  @"isRegisterNibKEY"
#define configDicKEY_Key1 @"configDicKEY_Key1"
#define configDicKEY_Key2 @"configDicKEY_Key2"



#define KJ_typeweakself __weak typeof(self) weakSelf = self;


@protocol CKJSimpleTableViewDataSource <NSObject>

@required;
/**
 一定要匹配匹配正确
 键值对
 OC版本
 return @{NSStringFromClass([CKJCommonCellModel class]) : @{cellKEY : NSStringFromClass([CKJCommonTableViewCell class]), isRegisterNibKEY : @YES}};
 return @{NSStringFromClass([WDYHFCompleteOrderCellModel class]) : @{cellKEY : NSStringFromClass([WDYHFOrderDetailsQRCodeCell class]), isRegisterNibKEY : @NO, configDicKEY_CKJPayStyleCellInstall : @3}}

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
- (nonnull NSDictionary <NSString *, NSString *> *)returnHeader_Model_keyValues;
- (nonnull NSDictionary <NSString *, NSString *> *)returnFooter_Model_keyValues;

/**
 保留Plain样式 区头悬浮
 */
- (BOOL)savePlainStyleSectionHeaderSuspension;

@end


@protocol CKJSimpleTableViewDelegate <NSObject>

- (void)kj_tableView:(nonnull CKJSimpleTableView *)tableView didSelectRowAtSection:(NSInteger)section row:(NSInteger)row selectIndexPath:(nonnull NSIndexPath *)indexPath model:(nonnull __kindof CKJCommonCellModel *)model cell:(nonnull __kindof CKJCommonTableViewCell *)cell;

@end


@interface CKJSimpleTableView : UITableView <UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) NSArray <CKJCommonSectionModel *>* _Nullable dataArr;

@property (weak, nonatomic, nullable) IBOutlet id  <CKJSimpleTableViewDataSource> simpleTableViewDataSource;
@property (weak, nonatomic, nullable) IBOutlet id  <CKJSimpleTableViewDelegate> simpleTableViewDelegate;
@property (weak, nonatomic, nullable) IBOutlet id  <TitleStyleHeaderFooterViewDelegate> titleStyleHeaderFooterViewDelegate;
@property (weak, nonatomic, nullable) IBOutlet id  <CKJCellDataSource> ckjCellDataSource;



/**
 禁止估算高度(防止屏幕乱跳动)
 */
- (void)disableEstimated;

- (void)kjwd_setCellModels:(nullable NSArray <CKJCommonCellModel *>*)cellModels atSection:(NSInteger)section;


/**
 取到对应flag的模型

 @param flag 唯一标识
 @return 对应的模型
 */
- (nullable __kindof CKJCommonCellModel *)cellModelOfFlag:(NSInteger)flag;
- (nullable __kindof CKJCommonSectionModel *)sectionModelOfFlag:(NSInteger)flag;



/**
 在某个分区过滤模型
 */
- (nullable __kindof CKJCommonCellModel *)cellModelOfFilter:(BOOL (^)(__kindof CKJCommonCellModel *cellModel))filterBlock inSection:(NSUInteger)section;


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
- (nullable NSIndexPath *)indexPathOf_CKJCommonCellModel_Flag:(int)flag;


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
- (NSArray <CKJCommonCellModel *>*)displayCellModelArrayAtSection:(NSInteger)section;


/**
 拼接分区
 */
- (void)appendCKJCommonSectionModel:(CKJCommonSectionModel *)sectionModel;
- (void)appendCKJCommonSectionModels:(NSArray <CKJCommonSectionModel *>*_Nullable)sectionModels;


/**
 插入模型在某个分区的某一行
 **************这个插入数据之后，需要手动的刷新数据，因为在insertRowsAtIndexPaths会位置出现， insertRowsAtIndexPaths每次只能插入一个数据，同时插入多个数据会造成插入动画数据有问题**************
 */
- (BOOL)kjwd_insertCellModelsInAllCellModel:(nullable NSArray<CKJCommonCellModel *>*)array section:(NSInteger)section row:(NSInteger)row;
/**
 使用动画 插入模型在某个分区的某一行
 **************调用此方法插入数据后，不要使用reloadRowsAtIndexPaths刷新，不然会崩溃，可以刷新当前所在的分区**************
 */
- (void)kjwd_insertCellModelInAllCellModel:(nullable CKJCommonCellModel *)model section:(NSInteger)section row:(NSInteger)row withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nullable)(void(^_Nonnull animationBlock)(void)))animationBlock;


/**
 在指定分区的末尾拼接模型数组 (拼接在某一个分区所有CellModelArray包括隐藏的模型的 最后一行)
 */
- (BOOL)appendCellModelArray:(nullable NSArray <CKJCommonCellModel *>*)array atLastRow_InAllCellModelArrayOfSection:(NSInteger)section;
/**
 使用动画 在指定分区的末尾拼接模型数组 (拼接在某一个分区所有CellModelArray包括隐藏的模型的 最后一行)
 */
- (void)appendCellModelArray:(nullable NSArray <CKJCommonCellModel *>*)array atLastRow_InAllCellModelArrayOfSection:(NSInteger)section withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nullable)(void(^_Nonnull animationBlock)(void)))animationBlock;

/** 拼接在最后一个分区最后一行 */
- (BOOL)appendCellModelArray_atLastRow_InAllCellModelArrayOfLastSection_WithCellModelArray:(nullable NSArray <CKJCommonCellModel *>*)array;
/** 使用动画 拼接在最后一个分区最后一行 */
- (void)appendCellModelArray_atLastRow_InAllCellModelArrayOfLastSection_WithCellModelArray:(nullable NSArray <CKJCommonCellModel *>*)array withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nullable)(void(^_Nonnull animationBlock)(void)))animationBlock;


/** 删除模型在某个分区的某一行 */
- (void)removeCellModelAtSection:(NSInteger)section rows:(NSArray <NSNumber *>*_Nonnull)rows removeHiddenCellModel:(BOOL)removeHiddenCellModel;
/** 使用动画 删除模型在某个分区的某一行 */
- (void)removeCellModelAtSection:(NSInteger)section rows:(NSArray <NSNumber *>*_Nonnull)rows removeHiddenCellModel:(BOOL)removeHiddenCellModel withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nullable)(void(^_Nonnull animationBlock)(void)))animationBlock;


/** 删除模型在某个分区除了指定行的全有行（只保留指定行）*/
- (void)removeAllCellModelAtSection:(NSInteger)section keepDisplayRows:(NSArray <NSNumber *>*)keepDisplayRows removeHiddenCellModel:(BOOL)removeHiddenCellModel;
/** 使用动画  删除模型在某个分区除了指定行的全有行（只保留指定行）*/
- (void)removeAllCellModelAtSection:(NSInteger)section keepDisplayRows:(NSArray <NSNumber *>*)keepDisplayRows removeHiddenCellModel:(BOOL)removeHiddenCellModel withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nonnull)(void(^_Nonnull animationBlock)(void)))animationBlock;


/** 删除某个分区 */
- (void)removeSections:(NSArray <NSNumber *>*_Nonnull)includedSections;
/** 使用动画 删除某个分区 */
- (void)removeSections:(NSArray <NSNumber *>*_Nonnull)includedSections withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nonnull)(void(^_Nonnull animationBlock)(void)))animationBlock;

/** 删除全部分区（只保留指定分区）*/
- (void)removeAllSection_notIncludedSection:(NSArray <NSNumber *>*_Nonnull)notIncludedSections;
/** 使用动画 删除全部分区（只保留指定分区）*/
- (void)removeAllSection_notIncludedSection:(NSArray <NSNumber *>*_Nonnull)notIncludedSections withRowAnimation:(UITableViewRowAnimation)rowAnimation animationBlock:(void(^_Nullable)(void(^_Nonnull animationBlock)(void)))animationBlock;

#pragma mark - Swift命名空间相关
+ (NSString *)kj_nameSpace;
+ (NSString *)return_ModelName:(NSString *)modelName;
+ (Class)returnClass_ClassString:(NSString *)classString;

#pragma mark - 键值对
@property (strong, nonatomic) NSMutableDictionary *cell_Model_keyValues;
@property (strong, nonatomic) NSMutableDictionary *header_Model_keyValues;
@property (strong, nonatomic) NSMutableDictionary *footer_Model_keyValues;

@end
