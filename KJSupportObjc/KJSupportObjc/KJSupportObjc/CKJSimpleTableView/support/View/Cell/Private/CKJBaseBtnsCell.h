//
//  CKJEsayCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/26.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJStackCell.h"

NS_ASSUME_NONNULL_BEGIN

@class CKJBaseBtnsCellModel, CKJBtnItemData, CKJBaseBtnsCell;

typedef void(^CKJBaseBtnsCellRowBlock)(CKJBaseBtnsCellModel *m);
typedef void(^CKJBtnsCellItemBlock)(CKJBtnItemData *itemData, __kindof CKJBaseBtnsCell *__weak cell);



// CKJ系统提供的Item为UIButton的类，并且自动实现了CKJStackCellDelegate
@interface CKJBaseBtnsCellSystemDelegate : CKJBaseModel <CKJStackCellDelegate>

/**
 一行显示多少个Item
 */
@property (assign, nonatomic) NSUInteger numberOfItemsInSingleLine;


+ (instancetype)esayWithNumberOfItemsInSingleLine:(NSUInteger)number;

@end

/*

 // MARK: - CKJSimpleTableView 数据源 和 代理
 override func returnCell_Model_keyValues(_ s: CKJSimpleTableView) -> [String : [String : Any]] {

     let btnsCellConfig1 = CKJBaseBtnsCellConfig.btnsConfig { (m) in
         m.delegate = m.squareWithNumberOfItems(inSingleLine: 4)
     }
     return [
         NSStringFromClass(CKJBtnsCell1Model.self) : [KJPrefix_cellKEY : NSStringFromClass(CKJBtnsCell1.self), KJPrefix_isRegisterNibKEY : false, KJPrefix_configDicKEY_ConfigModel : btnsCellConfig1]
     ]
 }
 
 */
@interface CKJBaseBtnsCellConfig : CKJStackCellConfig


/// CKJButton 这些按钮的自有宽度的增量，默认为0
@property (assign, nonatomic) CGFloat fixWidth;

/// CKJButton 这些按钮的自有高度的增量，默认为0，一般用弥补高度fixHeight，一般为了解决调整为图片在上，文字在下，是为了弥补自适应高度的时候CKJButton的高度不足
@property (assign, nonatomic) CGFloat fixHeight;


/// 强指针 和 id <CKJStackCellDelegate>delegate;
@property (strong, nonatomic) CKJBaseBtnsCellSystemDelegate *esaySystemModel;

- (__kindof CKJBaseBtnsCellSystemDelegate *)squareWithNumberOfItemsInSingleLine:(NSUInteger)number;

/// 初始化
/// @param h_itemSpacing 水平item之间距离
+ (instancetype)btnsConfigWithH_itemSpacing:(CGFloat)h_itemSpacing detail:(void (^_Nullable)(CKJBaseBtnsCellConfig * m))detail;

@end


@interface CKJBaseBtnsCellModel : CKJStackCellModel

+ (instancetype)baseBtnsCellWithCellHeight:(nullable NSNumber *)cellHeight cellModel_id:(nullable NSString *)cellModel_id detailSettingBlock:(nullable CKJBaseBtnsCellRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJBaseBtnsCellRowBlock)didSelectRowBlock;

+ (NSArray <__kindof CKJBaseBtnsCellModel *>*)btnsCellModelWithItemsnew:(NSArray <NSArray <__kindof CKJBtnItemData *>*>*_Nullable)items cellHeight:(nullable NSNumber *)cellHeight leftMargin:(NSNumber *_Nullable)leftMargin rightMargin:(NSNumber *_Nullable)rightMargin detailSetting:(void(^_Nullable)(__kindof CKJBaseBtnsCellModel *__weak m, NSUInteger cellModel_index))detailSetting;


@end


/**
 请使用 这个类 的两个子类 CKJBtnsCell1、CKJBtnsCell2
 */
@interface CKJBaseBtnsCell : CKJStackCell

@end

NS_ASSUME_NONNULL_END
