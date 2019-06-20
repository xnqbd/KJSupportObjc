//
//  CKJBtnsCell2.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/6/19.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBtnsCell2.h"

@implementation CKJBtnsCell2Config


@end


@implementation CKJBtnsCell2Model


+ (nonnull NSMutableArray <CKJCommonCellModel *>*)modelWithItems:(NSArray <__kindof CKJBaseBtnsCellItemData *>*_Nullable)items numberOfItemsInSingleLine:(NSUInteger)number cellHeight:(CGFloat)cellHeight topMargin:(CGFloat)topMargin centerMargin:(CGFloat)centerMargin bottomMargin:(CGFloat)bottomMargin groupId:(NSString *_Nullable)groupId detailSetting:(void(^_Nullable)(__kindof CKJBtnsCell2Model *_Nonnull m, NSUInteger cellModel_index))detailSetting {
    return [super modelWithItems:items numberOfItemsInSingleLine:number cellHeight:cellHeight topMargin:topMargin centerMargin:centerMargin bottomMargin:bottomMargin groupId:groupId detailSetting:detailSetting];
}

@end

@implementation CKJBtnsCell2


@end
