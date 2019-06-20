//
//  CKJBtnsCell2.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/6/19.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseBtnsCell.h"

NS_ASSUME_NONNULL_BEGIN



@interface CKJBtnsCell2Config : CKJBaseBtnsCellConfig

@end


@interface CKJBtnsCell2Model : CKJBaseBtnsCellModel


+ (nonnull NSMutableArray <CKJCommonCellModel *>*)modelWithItems:(NSArray <__kindof CKJBaseBtnsCellItemData *>*_Nullable)items numberOfItemsInSingleLine:(NSUInteger)number cellHeight:(CGFloat)cellHeight topMargin:(CGFloat)topMargin centerMargin:(CGFloat)centerMargin bottomMargin:(CGFloat)bottomMargin groupId:(NSString *_Nullable)groupId detailSetting:(void(^_Nullable)(__kindof CKJBtnsCell2Model *_Nonnull m, NSUInteger cellModel_index))detailSetting;

@end


@interface CKJBtnsCell2 : CKJBaseBtnsCell

@end

NS_ASSUME_NONNULL_END
