//
//  CKJLeftRightCell.h
//  Masonry
//
//  Created by chenkaijie on 2019/1/7.
//

#import "CKJCommonTableViewCell.h"



/*
 例子
 
 NSMutableArray <CKJCommonSectionModel *>*sections = [NSMutableArray array];
 
 {
 CGFloat margin = 20;
 
 CKJLeftRightCellModelRowBlock block = ^(CKJLeftRightCellModel *model) {
 model.showLine = YES;
 model.rightLab_textAlignment = NSTextAlignmentRight;
 model.leftLab_MarginTo_SuperView = margin;
 model.rightLab_MarginTo_SuperView = margin;
 };
 
 CKJCommonSectionModel *section = [CKJCommonSectionModel new];
 section.rowHeight = 40;
 
 CKJLeftRightCellModel *model1 = [CKJLeftRightCellModel modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(__kindof CKJLeftRightCellModel * _Nonnull m) {
 m.leftStr = @"患者姓名：";
 m.rightStr = [RJOrderSingle shareOrderSingle].getUserInfoModel.Name;
 block(m);
 } didSelectRowBlock:nil];
 
 CKJLeftRightCellModel *model2 = [CKJLeftRightCellModel modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(__kindof CKJLeftRightCellModel * _Nonnull m) {
 m.leftStr = @"身份证号：";
 m.rightStr = [RJOrderSingle shareOrderSingle].getUserInfoModel.IdentificationCard;
 block(m);
 } didSelectRowBlock:nil];
 
 CKJLeftRightCellModel *model3 = [CKJLeftRightCellModel modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(__kindof CKJLeftRightCellModel * _Nonnull m) {
 m.leftStr = @"联系方式：";
 m.rightStr = [RJOrderSingle shareOrderSingle].getUserInfoModel.PhoneNumber;
 block(m);
 } didSelectRowBlock:nil];
 
 CKJLeftRightCellModel *model4 = [CKJLeftRightCellModel modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(__kindof CKJLeftRightCellModel * _Nonnull m) {
 m.leftStr = @"饮食医嘱：";
 m.rightStr = [RJOrderSingle shareOrderSingle].homeUserModel.OrdersName;
 block(m);
 } didSelectRowBlock:nil];
 
 section.modelArray = @[model1, model2, model3, model4];
 
 [sections addObject:section];
 }
 self.simpleTableView.dataArr = sections;
 [self.simpleTableView kjwd_reloadData];
 
 
*/


typedef NS_ENUM(NSInteger, CKJEnum_LeftRightAlignment) {
    /** Left和Right 是中心线对齐  */
    CKJEnum_LeftRightAlignment_CenterY,
    /** Left和Right 是顶部对齐， 如果设置了此值，那么LeftLabel距离顶部的距离最好也要设置一下  */
    CKJEnum_LeftRightAlignment_Top
};


/** leftLab 的宽度，如果设置为0，或者不设置，那么会自适应左边宽度 */
#define configDicKEY_leftLab_width @"leftLab_width"

/** leftLab 的宽度相对于父视图的倍数 */
#define configDicKEY_leftLab_width_MultipliedBySuperView @"configDicKEY_leftLab_width_MultipliedBySuperView"

/** leftLabel 距离顶部的距离，如果设置了此值，那么LeftLabel就不再Y轴方向居中了  */
#define configDicKEY_leftLabel_TopMarginToSuperView @"configDicKEY_leftLabel_TopMarginToSuperView"


/** leftLab 和 rightLab的对齐方式 */
#define configDicKEY_leftRightAlignment @"configDicKEY_leftRightAlignment"



/** rightLab 距离底部的距离，如果不设置此值，默认是5  */
#define configDicKEY_rightLabel_BottomMarginToSuperView @"configDicKEY_rightLabel_BottomMarginToSuperView"


@class CKJLeftRightCellModel;

typedef void(^CKJLeftRightCellModelRowBlock)(__kindof CKJLeftRightCellModel *_Nonnull m);

@interface CKJLeftRightCellModel : CKJCommonCellModel

/** Left和Right 的对齐方式  */
@property (assign, nonatomic) CKJEnum_LeftRightAlignment leftRightAlignment;

@property(assign, nonatomic) NSTextAlignment leftLab_textAlignment;
@property(assign, nonatomic) NSTextAlignment rightLab_textAlignment;

@property (copy, nonatomic) NSString *leftStr;
@property (copy, nonatomic) NSString *rightStr;

@property (copy, nonatomic) NSAttributedString *leftAttStr;
@property (copy, nonatomic) NSAttributedString *rightAttStr;


/** leftLab 和 父视图 之间的距离 (默认是0) */
@property (assign, nonatomic) CGFloat leftLab_MarginTo_SuperView;

/** leftLab 和 rightLab之间的距离 (默认是0) */
@property (assign, nonatomic) CGFloat centerMargin;

/** rightLab 和 父视图 之间的距离 (默认是0) */
@property (assign, nonatomic) CGFloat rightLab_MarginTo_SuperView;


/** 是否显示分割线， 默认显示 */
@property (assign, nonatomic) BOOL showLine;


/**
 构造方法 设置左中右的margin
 
 @param leftMargin leftLab 和 父视图 之间的距离
 @param centerMargin leftLab 和 rightLab之间的距离
 @param rightMargin rightLab 和 父视图 之间的距离
 @return 创建出的对象
 */
+ (instancetype)modelWithLeftMargin:(CGFloat)leftMargin centerMargin:(CGFloat)centerMargin rightMargin:(CGFloat)rightMargin;

+ (instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJLeftRightCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJLeftRightCellModelRowBlock)didSelectRowBlock;


@end




@interface CKJLeftRightCell : CKJCommonTableViewCell <CKJLeftRightCellModel *>

@property (strong, nonatomic) UILabel *leftLab;
@property (strong, nonatomic) UILabel *rightLab;

@end


