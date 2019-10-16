//
//  CKJEsayCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/26.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseBtnsCell.h"
#import "UIView+CKJDesingable.h"
#import "CKJEmptyCell.h"

@implementation CKJBaseBtnsCellSystemDelegate


+ (nonnull instancetype)esayWithNumberOfItemsInSingleLine:(NSUInteger)number {
    CKJBaseBtnsCellSystemDelegate *model = [[self alloc] init];
    model.numberOfItemsInSingleLine = number;
    return model;
}

#pragma mark - CKJStackCellDelegate

- (NSArray <__kindof UIView *>*)createItemViewForCKJStackCell:(__kindof CKJStackCell *__weak)cell {
    
    NSMutableArray <__kindof UIView *>*result = [NSMutableArray array];

    for (int i = 0; i < self.numberOfItemsInSingleLine; i++) {
        
        UIButton *btn = [[UIButton alloc] init];
        btn.backgroundColor = [UIColor whiteColor];
        
//        WDCKJBGColor_Arc4Color(btn);
        
        btn.titleLabel.font = [UIFont systemFontOfSize:15.5];
        [btn setTitleColor:[UIColor kjwd_titleColor333333] forState:UIControlStateNormal];
        
        [btn kjwd_addTouchUpInsideForCallBack:^(UIButton * _Nonnull sender) {
            
            NSArray <__kindof CKJStackCellItemData *>*data = cell.cellModel.data;
            CKJBaseBtnsCellItemData *itemData = [data kjwd_objectAtIndex:i];
            
            CKJBtnsCellItemBlock block = itemData.callBack_Block;
            block ? block(itemData, cell) : nil;
            
        }];
        
        [result addObject:btn];
    }
    return result;
}

- (void)updateItemView:(__kindof UIButton *)btn itemData:(__kindof CKJBaseBtnsCellItemData *)itemData index:(NSInteger)index {
    
    btn.selected = itemData.selected;
    btn.highlighted = itemData.highlighted;
    btn.enabled = itemData.enabled;
    
    NSAttributedString *normalAttTitle = itemData.normalAttTitle;
    UIImage *normalImage = itemData.normalImage;
    UIImage *normalBgImage = itemData.normalBgImage;
    
    NSAttributedString *selectedAttTitle = itemData.selectedAttTitle;
    UIImage *selectedImage = itemData.selectedImage;
    UIImage *selectedBgImage = itemData.selectedBgImage;
    
    NSAttributedString *highlightedAttTitle = itemData.highlightedAttTitle;
    UIImage *highlightedImage = itemData.highlightedImage;
    UIImage *highlightedBgImage = itemData.highlightedBgImage;
    
    // 请确保 title 是 NSAttributedString 类型的，不然会崩溃
    
    // normal
    [btn setAttributedTitle:normalAttTitle forState:UIControlStateNormal];
    [self btn:btn image:normalImage forState:UIControlStateNormal];
    [self btn:btn bgImage:normalBgImage forState:UIControlStateNormal];

    // select
    [btn setAttributedTitle:selectedAttTitle forState:UIControlStateSelected];
    [self btn:btn image:selectedImage forState:UIControlStateSelected];
    [self btn:btn bgImage:selectedBgImage forState:UIControlStateSelected];
    
    // highlighted
    [btn setAttributedTitle:highlightedAttTitle forState:UIControlStateHighlighted];
    [self btn:btn image:highlightedImage forState:UIControlStateHighlighted];
    [self btn:btn bgImage:highlightedBgImage forState:UIControlStateHighlighted];
    
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


@implementation CKJBaseBtnsCellItemData

- (instancetype)init {
    if (self = [super init]) {
        self.enabled = YES;
    }
    return self;
}

+ (NSArray <CKJBaseBtnsCellItemData *>*_Nonnull)returnItemsWithDics:(NSArray <NSDictionary *>*_Nullable)dics detailSetting:(void(^_Nullable)(CKJBaseBtnsCellItemData *__weak _Nonnull itemData, NSUInteger index))detailSetting {

    NSMutableArray *result = [NSMutableArray array];
    for (int i = 0; i < dics.count; i++) {
        NSDictionary *dic = dics[i];
        CKJBaseBtnsCellItemData *m = [[CKJBaseBtnsCellItemData alloc] init];
        
        m.normalAttTitle = dic[cNormalAttTitle];
        m.normalImage = dic[cNormalImage];
        m.normalBgImage = dic[cNormalBgImage];
        
        m.selectedAttTitle = dic[cSelectedAttTitle];
        m.selectedImage = dic[cSelectedImage];
        m.selectedBgImage = dic[cSelectedBgImage];
        
        m.highlightedAttTitle = dic[cHighlightedAttTitle];
        m.highlightedImage = dic[cHighlightedImage];
        m.highlightedBgImage = dic[cHighlightedBgImage];
        
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


- (void)setNormalAttTitle:(NSAttributedString *)normalAttTitle {
    if (WDKJ_IsEmpty_AttributedStr(normalAttTitle)) {
        _normalAttTitle = nil;
    } else {
        _normalAttTitle = normalAttTitle;
    }
}
- (void)setSelectedAttTitle:(NSAttributedString *)selectedAttTitle {
    if (WDKJ_IsEmpty_AttributedStr(selectedAttTitle)) {
        _selectedAttTitle = nil;
    } else {
        _selectedAttTitle = selectedAttTitle;
    }
}
- (void)setHighlightedAttTitle:(NSAttributedString *)highlightedAttTitle {
    if (WDKJ_IsEmpty_AttributedStr(highlightedAttTitle)) {
        _highlightedAttTitle = nil;
    } else {
        _highlightedAttTitle = highlightedAttTitle;
    }
}


@end

@implementation CKJBaseBtnsCellConfig


- (__kindof CKJBaseBtnsCellSystemDelegate *)squareWithNumberOfItemsInSingleLine:(NSUInteger)number {
    self.esaySystemModel = [CKJBaseBtnsCellSystemDelegate esayWithNumberOfItemsInSingleLine:number];
    return self.esaySystemModel;
}

@end


@implementation CKJBaseBtnsCellModel


+ (nonnull instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJBaseBtnsCellRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJBaseBtnsCellRowBlock)didSelectRowBlock {
    return [super modelWithCellHeight:cellHeight cellModel_id:cellModel_id detailSettingBlock:detailSettingBlock didSelectRowBlock:didSelectRowBlock];
}

+ (nonnull NSMutableArray <CKJCommonCellModel *>*)btnsCellModelWithItems:(NSArray <__kindof CKJBaseBtnsCellItemData *>*_Nullable)items numberOfItemsInSingleLine:(NSUInteger)number cellHeight:(CGFloat)cellHeight topMargin:(CGFloat)topMargin centerMargin:(CGFloat)centerMargin bottomMargin:(CGFloat)bottomMargin groupId:(NSString *_Nullable)groupId detailSetting:(void(^_Nullable)(__kindof CKJBaseBtnsCellModel *__weak _Nonnull m, NSUInteger cellModel_index))detailSetting {
    NSMutableArray *cellModels = [NSMutableArray array];
    
    CKJBaseBtnsCellModel *model = nil;
    
    NSUInteger cellModel_index = 0;
    
    NSUInteger count = items.count;
    
    
    NSMutableArray <CKJBaseBtnsCellModel *>*btnsCellModel = [NSMutableArray array];
    
    for (int i = 0; i < count; i++) {
        
        CKJBaseBtnsCellItemData *item = [items kjwd_objectAtIndex:i];
        
        if ([item isKindOfClass:[CKJBaseBtnsCellItemData class]] == NO) {
            NSLog(@"当前的item是%@  其实应该是CKJBaseBtnsCellItemData类型的", item.class);
        }
        
        
        if (i % number == 0) {
            model = [self modelWithCellHeight:cellHeight cellModel_id:nil detailSettingBlock:^(__kindof CKJBaseBtnsCellModel * _Nonnull m) {
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
                if (centerMargin > 0) {
                    CKJEmptyCellModel *squareCellSpaceEmpty = [CKJEmptyCellModel emptyCellModelWithHeight:centerMargin showLine:NO];
                    [squareCellSpaceEmpty addGroupId:groupId];
                    
                    [cellModels addObject:squareCellSpaceEmpty];
                }
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


@implementation CKJBaseBtnsCell


@end
