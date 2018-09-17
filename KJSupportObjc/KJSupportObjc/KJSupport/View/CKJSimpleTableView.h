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
#define KJ_typeweakself __weak typeof(self) weakSelf = self;


@protocol CKJSimpleTableViewDataSource <NSObject>

@required;
/**
 一定要匹配匹配正确
 键值对 return @{NSStringFromClass([CKJCommonCellModel class]) : @{cellKEY : NSStringFromClass([CKJCommonTableViewCell class]), isRegisterNibKEY : @YES}};
 
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

- (void)kj_tableView:(CKJSimpleTableView *)tableView didSelectRowAtSection:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath model:(__kindof CKJCommonCellModel *)model cell:(__kindof CKJCommonTableViewCell *)cell;

@end




@interface CKJSimpleTableView : UITableView <UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) NSArray <CKJCommonSectionModel *>* _Nullable dataArr;

@property (weak, nonatomic, nullable) IBOutlet id  <CKJSimpleTableViewDataSource> simpleTableViewDataSource;
@property (weak, nonatomic, nullable) IBOutlet id  <CKJSimpleTableViewDelegate> simpleTableViewDelegate;
@property (weak, nonatomic, nullable) IBOutlet id  <TitleStyleHeaderFooterViewDelegate> titleStyleHeaderFooterViewDelegate;
@property (weak, nonatomic, nullable) IBOutlet id  <CKJCellDataSource> ckjCellDataSource;



/**
 取到对应flag的模型

 @param flag 唯一标识
 @return 对应的模型
 */
- (nullable __kindof CKJCommonCellModel *)cellModelOfFlag:(int)flag;

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
 拼接在最后一个分区的 最后一行
 */
- (void)appendCellModelAtLastSectionLastRow:(CKJCommonCellModel *)model;
/**
 拼接分区
 */
- (void)appendCKJCommonSectionModel:(CKJCommonSectionModel *)sectionModel;

/**
 插入模型在某个分区的某一行
 */
- (void)insertCellModel:(CKJCommonCellModel *)model atSection:(NSInteger)section row:(NSInteger)row;
/**
 在指定分区的末尾拼接模型数组
 */
- (void)appendCellModelArray:(NSArray <CKJCommonCellModel *>*)array atLastRowOfSection:(NSInteger)section;
/**
 删除模型在某个分区的某一行
 */
- (void)removeCellModelAtSection:(NSInteger)section row:(NSInteger)row;
/**
 删除模型在某个分区除了指定行的全有行（只保留指定行）
 */
- (void)removeAllCellModelAtSection:(NSInteger)section notIncludedRow:(NSInteger)notIncludedRow;
/**
 删除模型在某个分区除了指定行的全有行（只保留指定行数组）
 */
- (void)removeAllCellModelAtSection:(NSInteger)section notIncludedRows:(NSArray <NSNumber *>*)notIncludedRows;

/**
 删除某个分区
 */
- (void)removeSection:(NSInteger)section;
/**
 删除全部分区（只保留指定分区）
 */
- (void)removeAllSection_notIncludedSection:(NSInteger)notIncludedSection;


#pragma mark - Swift命名空间相关
+ (NSString *)kj_nameSpace;
+ (NSString *)return_ModelName:(NSString *)modelName;
+ (Class)returnClass_ClassString:(NSString *)classString;

#pragma mark - 键值对
@property (strong, nonatomic) NSMutableDictionary *cell_Model_keyValues;
@property (strong, nonatomic) NSMutableDictionary *header_Model_keyValues;
@property (strong, nonatomic) NSMutableDictionary *footer_Model_keyValues;



@end
