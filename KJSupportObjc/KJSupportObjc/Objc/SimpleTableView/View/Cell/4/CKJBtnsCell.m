//
//  CKJEsayCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/26.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBtnsCell.h"
#import "UIView+CKJDesingable.h"

@implementation CKJBtnsCellSystemDelegate


+ (nonnull instancetype)esayWithNumberOfItemsInSingleLine:(NSUInteger)number {
    CKJBtnsCellSystemDelegate *model = [[self alloc] init];
    model.numberOfItemsInSingleLine = number;
    return model;
}

#pragma mark - CKJStackCellDelegate

- (NSArray <__kindof UIView *>*)createItemViewForCKJStackCell:(__kindof CKJStackCell *__weak)cell {
    
    NSMutableArray <__kindof UIView *>*result = [NSMutableArray array];

    for (int i = 0; i < self.numberOfItemsInSingleLine; i++) {
        
        UIButton *btn = [[UIButton alloc] init];
//        WDCKJBGColor_Arc4Color(btn);
        
        btn.titleLabel.font = [UIFont systemFontOfSize:15.5];
        [btn setTitleColor:[UIColor kjwd_titleColor333333] forState:UIControlStateNormal];
        
        [btn kjwd_addTouchUpInsideForCallBack:^(UIButton * _Nonnull sender) {
            
            NSArray <__kindof CKJStackCellItemData *>*data = cell.cellModel.data;
            CKJBtnsCellItemData *itemData = [data kjwd_objectAtIndex:i];
            CKJBtnsCellItemBlock block = itemData.callBack_Block;

            block ? block(itemData, cell) : nil;
        }];
        
        [result addObject:btn];
    }
    return result;
}

- (void)updateItemView:(__kindof UIButton *)btn itemData:(__kindof CKJBtnsCellItemData *)itemData index:(NSInteger)index {
    
    btn.selected = itemData.selected;
    btn.highlighted = itemData.highlighted;
    btn.enabled = itemData.enabled;
    
    NSAttributedString *normalAttTitle = itemData.normalAttTitle;
    NSAttributedString *selectedAttTitle = itemData.selectedAttTitle;
    
    UIImage *normalImage = itemData.normalImage;
    UIImage *selectedImage = itemData.selectedImage;
    
    UIImage *normalBgImage = itemData.normalBgImage;
    UIImage *selectedBgImage = itemData.selectedBgImage;
    
    [btn setAttributedTitle:normalAttTitle forState:UIControlStateNormal];
    [btn setAttributedTitle:selectedAttTitle forState:UIControlStateSelected];
    
    [self btn:btn image:normalImage forState:UIControlStateNormal];
    [self btn:btn image:selectedImage forState:UIControlStateSelected];
    
    [self btn:btn bgImage:normalBgImage forState:UIControlStateNormal];
    [self btn:btn bgImage:selectedBgImage forState:UIControlStateSelected];
    
    if (btn.kBorderWidth != itemData.borderWidth) {
        btn.kBorderWidth = itemData.borderWidth;
    }
    if (btn.kBorderColor != itemData.borderColor) {
        btn.kBorderColor = itemData.borderColor;
    }
    if (btn.kCornerRadius != itemData.cornerRadius) {
        btn.kCornerRadius = itemData.cornerRadius;
    }
    if (itemData.layoutButton) {
        itemData.layoutButton(btn);
    }
//    [btn kjwd_layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop imageTitleSpace:10];
}


- (void)btn:(UIButton *)btn image:(UIImage *)image forState:(UIControlState)state {
    if (WDKJ_IsNullObj(image, [UIImage class])) {
        // 重置图片
        [btn setImage:nil forState:state];
    } else {
        [btn setImage:image forState:state];
    }
}
- (void)btn:(UIButton *)btn bgImage:(UIImage *)bgImage forState:(UIControlState)state {
    if (WDKJ_IsNullObj(bgImage, [UIImage class])) {
        // 重置图片
        [btn setBackgroundImage:nil forState:state];
    } else {
        [btn setBackgroundImage:bgImage forState:state];
    }
}

@end


@implementation CKJBtnsCellItemData

- (instancetype)init {
    if (self = [super init]) {
        self.enabled = YES;
    }
    return self;
}

+ (NSArray <__kindof CKJBtnsCellItemData *>*_Nonnull)returnItemsWithDics:(NSArray <NSDictionary *>*_Nullable)dics detailSetting:(void(^_Nullable)(__kindof CKJBtnsCellItemData *__weak _Nonnull itemData, NSUInteger index))detailSetting {
    
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 0; i < dics.count; i++) {
        NSDictionary *dic = dics[i];
        CKJBtnsCellItemData *m = [[self alloc] init];
        m.normalAttTitle = dic[cNormalAttTitle];
        m.selectedAttTitle = dic[cSelectedAttTitle];
        m.normalImage = dic[cNormalImage];
        m.selectedImage = dic[cSelectedImage];
        m.normalBgImage = dic[cNormalBgImage];
        m.selectedBgImage = dic[cSelectedBgImage];
        
        m.borderWidth = WDKJ_ConfirmNumber(dic[cBorderWidth]).floatValue;
        m.borderColor = dic[cBorderColor];
        m.cornerRadius = WDKJ_ConfirmNumber(dic[cCornerRadius]).floatValue;
        
        if (detailSetting) {
            detailSetting(m, i);
        }
        [result addObject:m];
    }
    return result;
}


@end

@implementation CKJBtnsCellConfig


- (__kindof CKJBtnsCellSystemDelegate *)squareWithNumberOfItemsInSingleLine:(NSUInteger)number {
    self.esaySystemModel = [CKJBtnsCellSystemDelegate esayWithNumberOfItemsInSingleLine:number];
    return self.esaySystemModel;
}

@end


@implementation CKJBtnsCellModel


+ (nonnull instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJBtnsCellRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJBtnsCellRowBlock)didSelectRowBlock {
    return [super modelWithCellHeight:cellHeight cellModel_id:cellModel_id detailSettingBlock:detailSettingBlock didSelectRowBlock:didSelectRowBlock];
}

+ (nonnull NSMutableArray <CKJCommonCellModel *>*)modelWithItems:(NSArray <__kindof CKJBtnsCellItemData *>*_Nullable)items numberOfItemsInSingleLine:(NSUInteger)number cellHeight:(CGFloat)cellHeight topMargin:(CGFloat)topMargin centerMargin:(CGFloat)centerMargin bottomMargin:(CGFloat)bottomMargin groupId:(NSString *_Nullable)groupId detailSetting:(void(^_Nullable)(CKJBtnsCellModel *_Nonnull m, NSUInteger cellModel_index))detailSetting {
    NSMutableArray *cellModels = [NSMutableArray array];
    
    CKJBtnsCellModel *model = nil;
    
    NSUInteger cellModel_index = 0;
    
    NSUInteger count = items.count;
    
    
    NSMutableArray <CKJBtnsCellModel *>*btnsCellModel = [NSMutableArray array];
    
    for (int i = 0; i < count; i++) {
        
        CKJBtnsCellItemData *item = [items kjwd_objectAtIndex:i];
        
        if ([item isKindOfClass:[CKJBtnsCellItemData class]] == NO) {
            NSLog(@"当前的item是%@  其实应该是CKJBtnsCellItemData类型的", item.class);
        }
        
        
        if (i % number == 0) {
            model = [CKJBtnsCellModel modelWithCellHeight:cellHeight cellModel_id:nil detailSettingBlock:^(__kindof CKJBtnsCellModel * _Nonnull m) {
                m.showLine = NO;
                [m addGroupId:groupId];
            } didSelectRowBlock:nil];
            [model addItem:item];
            if (detailSetting) {
                detailSetting(model, cellModel_index);
            }
            [cellModels addObject:model];
            [btnsCellModel addObject:model];
            
            if ((i + number) < count) { // 最后创建CellModel的时候
                CKJEmptyCellModel *squareCellSpaceEmpty = [CKJEmptyCellModel emptyCellModelWithHeight:centerMargin showLine:NO];
                [squareCellSpaceEmpty addGroupId:groupId];
                
                [cellModels addObject:squareCellSpaceEmpty];
            }
            
            cellModel_index++;
            
        } else {
            [model addItem:item];
        }
    }
    
    if (count) {
        if (topMargin > 0) {
            CKJEmptyCellModel *empty = [CKJEmptyCellModel emptyCellModelWithHeight:topMargin showLine:NO];
            [empty addGroupId:groupId];
            
            [cellModels kjwd_insertObject:empty atIndex:0];
        }
        if (bottomMargin > 0) {
            CKJEmptyCellModel *empty = [CKJEmptyCellModel emptyCellModelWithHeight:bottomMargin showLine:NO];
            [empty addGroupId:groupId];
            [cellModels kjwd_addObject:empty];
        }
    }
    return cellModels;
}

@end


@implementation CKJBtnsCell


@end
