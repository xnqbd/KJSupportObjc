//
//  CKJBtnsCell1.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/6/19.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseBtnsCell.h"

NS_ASSUME_NONNULL_BEGIN



@interface CKJBtnsCell1Config : CKJBaseBtnsCellConfig

@end


@interface CKJBtnsCell1Model : CKJBaseBtnsCellModel
//
//+ (nonnull NSMutableArray <CKJCommonCellModel *>*)btnsCellModelWithItems:(NSArray <__kindof CKJBaseBtnsCellItemData *>*_Nullable)items numberOfItemsInSingleLine:(NSUInteger)number cellHeight:(CGFloat)cellHeight topMargin:(CGFloat)topMargin centerMargin:(CGFloat)centerMargin bottomMargin:(CGFloat)bottomMargin groupId:(NSString *_Nullable)groupId detailSetting:(void(^_Nullable)(CKJBtnsCell1Model *__weak _Nonnull m, NSUInteger cellModel_index))detailSetting;

@end

@interface CKJBtnsCell1 : CKJBaseBtnsCell

@end

NS_ASSUME_NONNULL_END
