//
//  CKJLeftRightCell.h
//  Masonry
//
//  Created by chenkaijie on 2019/1/7.
//

#import "CKJCommonTableViewCell.h"
#import "CKJTableViewCell.h"
#import "CKJEmptyCell.h"

/*
 
 #pragma mark - CKJSimpleTableView 数据源 和 代理
 - (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues {
 return @{
 NSStringFromClass([CKJLeftRightCellModel class]) : @{cellKEY : NSStringFromClass([CKJLeftRightCell class]), isRegisterNibKEY : @NO}
 };
 }
 
 
 例子1
 
 NSMutableArray <CKJCommonSectionModel *>*sections = [NSMutableArray array];
 
 {
 
 NSArray <NSDictionary <NSString *, NSString *>*> *leftRightData = @[
 @{@"药品名称" : WDKJ_ConfirmString(@"1")},
 @{@"药品通用名" : WDKJ_ConfirmString(@"2")},
 @{@"药品剂型" : WDKJ_ConfirmString(@"3")},
 @{@"药品类别" : WDKJ_ConfirmString(@"4")}
 ];
 
 CGFloat margin = 20;
 CKJCommonSectionModel *section = [CKJCommonSectionModel new];
 section.rowHeight = 40;
 NSMutableArray <__kindof CKJCommonCellModel *>*modelArray = [NSMutableArray array];
 
 for (int i = 0; i < leftRightData.count; i++) {
 NSDictionary *item = leftRightData[i];
 NSString *key = item.allKeys.firstObject;
 CKJLeftRightCellModel *model1 = [CKJLeftRightCellModel modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(__kindof CKJLeftRightCellModel * _Nonnull m) {
 m.leftAttStr = key;
 m.rightAttStr = item[key];
 m.leftLab_MarginTo_SuperViewLeft = margin;
 m.rightLab_MarginTo_SuperViewRight = margin;
 m.rightLab_textAlignment = NSTextAlignmentRight;
 //                m.showLine = YES;
 } didSelectRowBlock:nil];
 [modelArray addObject:model1];
 }
 section.modelArray = modelArray;
 
 [sections addObject:section];
 }
 self.simpleTableView.dataArr = sections;
 [self.simpleTableView kjwd_reloadData];
 
 
 // ------------------------------------
 
 例子2
 
 NSMutableArray <CKJCommonSectionModel *>*sections = [NSMutableArray array];
 
 {
 
 CGFloat margin = 20;
 CKJLeftRightCellModelRowBlock block = ^(CKJLeftRightCellModel *model) {
 // model.showLine = YES;
 // model.rightLab_textAlignment = NSTextAlignmentRight;
 model.leftLab_MarginTo_SuperViewLeft = margin;
 model.rightLab_MarginTo_SuperViewRight = margin;
 };
 
 CKJCommonSectionModel *section = [CKJCommonSectionModel new];
 section.rowHeight = 40;
 
 CKJLeftRightCellModel *model1 = [CKJLeftRightCellModel modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(__kindof CKJLeftRightCellModel * _Nonnull m) {
 m.leftAttStr = @"患者姓名：";
 m.rightAttStr = [RJOrderSingle shareOrderSingle].getUserInfoModel.Name;
 block(m);
 } didSelectRowBlock:nil];
 
 CKJLeftRightCellModel *model2 = [CKJLeftRightCellModel modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(__kindof CKJLeftRightCellModel * _Nonnull m) {
 m.leftAttStr = @"身份证号：";
 m.rightAttStr = [RJOrderSingle shareOrderSingle].getUserInfoModel.IdentificationCard;
 block(m);
 } didSelectRowBlock:nil];
 
 CKJLeftRightCellModel *model3 = [CKJLeftRightCellModel modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(__kindof CKJLeftRightCellModel * _Nonnull m) {
 m.leftAttStr = @"联系方式：";
 m.rightAttStr = [RJOrderSingle shareOrderSingle].getUserInfoModel.PhoneNumber;
 block(m);
 } didSelectRowBlock:nil];
 
 CKJLeftRightCellModel *model4 = [CKJLeftRightCellModel modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(__kindof CKJLeftRightCellModel * _Nonnull m) {
 m.leftAttStr = @"饮食医嘱：";
 m.rightAttStr = [RJOrderSingle shareOrderSingle].homeUserModel.OrdersName;
 block(m);
 } didSelectRowBlock:nil];
 
 section.modelArray = @[model1, model2, model3, model4];
 
 [sections addObject:section];
 }
 self.simpleTableView.dataArr = sections;
 [self.simpleTableView kjwd_reloadData];
 
 
*/


@interface CKJLeftRightCellBaseConfig : CKJCommonCellConfig


/** leftLab 的宽度，如果设置为0，可以不设置，那么会自适应左边宽度 */
@property (assign, nonatomic) CGFloat leftLab_width;

/** leftLab 的宽度相对于父视图的倍数 */
@property (assign, nonatomic) CGFloat leftLab_width_MultipliedBySuperView;

/** rightLab 距离底部的距离，如果不设置此值，默认是5  */
@property (assign, nonatomic) CGFloat rightLabel_BottomMarginToSuperView;


@end


@class  CKJLeftRightCellTopEqualConfig, CKJLeftRightCellCenterEqualConfig, CKJLeftRightCellModel;


typedef void(^CKJLeftRightCellTopEqualConfigBlock)(CKJLeftRightCellTopEqualConfig *_Nonnull m);
typedef void(^CKJLeftRightCellCenterEqualConfigBlock)(CKJLeftRightCellCenterEqualConfig *_Nonnull m);
typedef void(^CKJLeftRightCellModelRowBlock)(__kindof CKJLeftRightCellModel *_Nonnull m);




@interface CKJLeftRightCellTopEqualConfig : CKJLeftRightCellBaseConfig

@property (assign, nonatomic) CGFloat leftLabel_TopMarginToSuperView;

+ (nonnull instancetype)configWithLeftLabelTopMargin:(CGFloat)LeftLabelTopMargin detailSettingBlock:(nullable CKJLeftRightCellTopEqualConfigBlock)detailSettingBlock;

@end



@interface CKJLeftRightCellCenterEqualConfig : CKJLeftRightCellBaseConfig


+ (nonnull instancetype)configWithSettingBlock:(nullable CKJLeftRightCellCenterEqualConfigBlock)detailSettingBlock;

@end


@interface CKJLeftRightCellModel : CKJCommonCellModel


@property(assign, nonatomic) NSTextAlignment leftLab_textAlignment;
@property(assign, nonatomic) NSTextAlignment rightLab_textAlignment;

/**
 如果发现异常或空字符串，会自动设置为 @" " 以撑开Label的高度
 */
@property (copy, nonatomic, nullable) NSAttributedString *leftAttStr;
/**
 如果发现异常或空字符串，会自动设置为 @" " 以撑开Label的高度
 */
@property (copy, nonatomic, nullable) NSAttributedString *rightAttStr;


/** leftLab 和 父视图左边 之间的距离 (默认是0) */
@property (assign, nonatomic) CGFloat leftLab_MarginTo_SuperViewLeft;

/** leftLab 和 rightLab之间的距离 (默认是0) */
@property (assign, nonatomic) CGFloat centerMargin;

/** rightLab 和 父视图右边 之间的距离 (默认是0) */
@property (assign, nonatomic) CGFloat rightLab_MarginTo_SuperViewRight;

/**
 构造方法 设置左中右的margin
 
 @param leftMargin leftLab 和 父视图 之间的距离
 @param centerMargin leftLab 和 rightLab之间的距离
 @param rightMargin rightLab 和 父视图 之间的距离
 @return 创建出的对象
 */
+ (instancetype _Nonnull)modelWithLeftMargin:(CGFloat)leftMargin centerMargin:(CGFloat)centerMargin rightMargin:(CGFloat)rightMargin;

+ (instancetype _Nonnull)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJLeftRightCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJLeftRightCellModelRowBlock)didSelectRowBlock;


@end




@interface CKJLeftRightCell : CKJCommonTableViewCell <CKJLeftRightCellModel *>

@property (strong, nonatomic, nonnull) UILabel *leftLab;
@property (strong, nonatomic, nonnull) UILabel *rightLab;

@end





