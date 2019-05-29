//
//  CKJLeftRightCell.h
//  Masonry
//
//  Created by chenkaijie on 2019/1/7.
//

#import "CKJCommonTableViewCell.h"
#import "CKJTableViewCell1.h"
#import "CKJEmptyCell.h"


/*
 
 
 #pragma mark - CKJSimpleTableView 数据源 和 代理
 - (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues {
 CKJLeftRightCellCenterEqualConfig *centerEqual = [CKJLeftRightCellCenterEqualConfig configWithDetailSettingBlock:^(CKJLeftRightCellCenterEqualConfig * _Nonnull m) {
 }];
 return @{
 NSStringFromClass([CKJLeftRightCellModel class]) : @{cellKEY : NSStringFromClass([CKJLeftRightCell class]), isRegisterNibKEY : @NO, configDicKEY_ConfigModel : centerEqual}
 };
 }

 
 
 例子1
 
 - (void)initSimpleTableViewData {
 
 NSMutableArray <CKJCommonSectionModel *>*sections = [NSMutableArray array];
 
 {
 RJOrderUser *user = [RJOrderSingle shareOrderSingle].user;
 
 NSArray <NSDictionary <NSString *, NSString *>*> *leftRightData = @[
 @{@"患者姓名：" : WDKJ_ConfirmString(user.PatientName)},
 @{@"身份证号：" : WDKJ_ConfirmString(user.PatientId)},
 @{@"联系方式：" : WDKJ_ConfirmString(user.PhoneNumber)},
 @{@"联系方式：" : WDKJ_ConfirmString(user.PhoneNumber)},
 @{@"饮食医嘱：" : WDKJ_ConfirmString(user.OrdersName)}];
 
 CGFloat margin = 20;
 CKJCommonSectionModel *section = [CKJCommonSectionModel new];
 section.rowHeight = 40;
 NSMutableArray <__kindof CKJCommonCellModel *>*modelArray = [NSMutableArray array];
 
 for (int i = 0; i < leftRightData.count; i++) {
 NSDictionary *item = leftRightData[i];
 NSString *key = item.allKeys.firstObject;
 NSString *value = item[key];
 CKJLeftRightCellModel *model1 = [CKJLeftRightCellModel modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(__kindof CKJLeftRightCellModel * _Nonnull m) {
 m.leftAttStr = WDCKJAttributed2(key, [UIColor kjwd_titleColor333333], nil);
 m.rightAttStr = WDCKJAttributed2(value, [UIColor kjwd_subTitleColor969696], nil);
 m.leftLab_MarginTo_SuperViewLeft = margin;
 m.rightLab_MarginTo_SuperViewRight = margin;
 } didSelectRowBlock:nil];
 [modelArray addObject:model1];
 }
 section.modelArray = modelArray;
 
 [sections addObject:section];
 }
 self.simpleTableView.dataArr = sections;
 [self.simpleTableView kjwd_reloadData];
 }

 
 // ------------------------------------
 
 例子2
 
 NSMutableArray <CKJCommonSectionModel *>*sections = [NSMutableArray array];
 
 
 CKJLeftRightCellModel *(^createModel)(NSString *left, NSString *right) = ^CKJLeftRightCellModel *(NSString *left, NSString *right) {
 CGFloat margin = 20;
 CKJLeftRightCellModel *model1 = [CKJLeftRightCellModel modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(__kindof CKJLeftRightCellModel * _Nonnull m) {
 m.leftAttStr = WDCKJAttributed2(left, [UIColor kjwd_titleColor333333], nil);
 m.rightAttStr = WDCKJAttributed2(right, [UIColor kjwd_subTitleColor969696], nil);
 m.showLine = NO;
 m.leftLab_MarginTo_SuperViewLeft = margin;
 m.rightLab_MarginTo_SuperViewRight = margin;
 } didSelectRowBlock:nil];
 return model1;
 };
 
 CKJLeftRightCellModel *model1 = createModel(@"就诊人：", [WDYHFCommonCode getUser].name);
 CKJLeftRightCellModel *model2 = createModel(@"社保卡号：", [WDYHFCommonCode getUser].card_no);
 CKJLeftRightCellModel *model3 = createModel(@"就诊医院：", self.hospitalItem.org_name;);
 CKJLeftRightCellModel *model4 = createModel(@"订单时间：", self.lockOrderModel.lock_start_time);
 CKJLeftRightCellModel *model5 = createModel(@"订单编号：", self.lockOrderModel.payplat_tradno);
 
 
 
 
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


+ (nonnull instancetype)configWithDetailSettingBlock:(nullable CKJLeftRightCellCenterEqualConfigBlock)detailSettingBlock;

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





