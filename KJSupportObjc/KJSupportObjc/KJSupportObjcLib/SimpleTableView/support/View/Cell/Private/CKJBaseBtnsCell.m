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
#import "CKJButton.h"

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
        
        CKJButton *btn = [[CKJButton alloc] init];
        
        CKJBaseBtnsCellConfig *config = cell.configModel;
        btn.fixWidth = config.fixWidth;
        btn.fixHeight = config.fixHeight;
        
        btn.backgroundColor = [UIColor whiteColor];
        
//        WDCKJBGColor_Arc4Color(btn);
        
        btn.titleLabel.font = [UIFont systemFontOfSize:15.5];
        [btn setTitleColor:[UIColor kjwd_title] forState:UIControlStateNormal];
        
        [btn kjwd_addTouchUpInsideForCallBack:^(UIButton * _Nonnull sender) {
            CKJStackCellModel *cellModel = cell.cellModel;
            NSArray *data = cellModel.stackItems;
            CKJBtnItemData *itemData = [data kjwd_objectAtIndex:i];
            if (itemData.click_Button) {
                itemData.click_Button(sender, itemData);
            }
        }];
        
        [result addObject:btn];
    }
    return result;
}
- (void)updateStackItemView:(__kindof UIView *)view itemData:(id)itemData index:(NSInteger)index {
    [CKJWorker reloadBtn:(UIButton *)view btnData:itemData];
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


@implementation CKJBaseBtnsCellConfig


- (__kindof CKJBaseBtnsCellSystemDelegate *)squareWithNumberOfItemsInSingleLine:(NSUInteger)number {
    self.esaySystemModel = [CKJBaseBtnsCellSystemDelegate esayWithNumberOfItemsInSingleLine:number];
    return self.esaySystemModel;
}

+ (instancetype)btnsConfigWithH_itemSpacing:(CGFloat)h_itemSpacing detail:(void (^_Nullable)(CKJBaseBtnsCellConfig * m))detail {
    return [self cellConfigWithDetail:^(__kindof CKJBaseBtnsCellConfig * _Nonnull m) {
        m.h_itemSpacing = h_itemSpacing;
        if (detail) {
            detail(m);
        }
    }];
}

@end


@implementation CKJBaseBtnsCellModel


+ (instancetype)baseBtnsCellWithCellHeight:(nullable NSNumber *)cellHeight cellModel_id:(nullable NSString *)cellModel_id detailSettingBlock:(nullable CKJBaseBtnsCellRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJBaseBtnsCellRowBlock)didSelectRowBlock {
    return [self commonWithCellHeight:cellHeight cellModel_id:cellModel_id detailSettingBlock:detailSettingBlock didSelectRowBlock:didSelectRowBlock];
}

+ (NSArray <__kindof CKJBaseBtnsCellModel *>*)btnsCellModelWithItemsnew:(NSArray <NSArray <__kindof CKJBtnItemData *>*>*_Nullable)items cellHeight:(nullable NSNumber *)cellHeight leftMargin:(NSNumber *_Nullable)leftMargin rightMargin:(NSNumber *_Nullable)rightMargin detailSetting:(void(^_Nullable)(__kindof CKJBaseBtnsCellModel *__weak _Nonnull m, NSUInteger cellModel_index))detailSetting {
    NSMutableArray *result = [NSMutableArray array];
    
    for (int i = 0; i < items.count; i++) {
        NSArray <CKJBtnItemData *>*temp = items[i];
        CKJBaseBtnsCellModel *cellModel = [self baseBtnsCellWithCellHeight:cellHeight cellModel_id:nil detailSettingBlock:^(__kindof CKJBaseBtnsCellModel * _Nonnull m) {
            [m _showLine:NO];
            m.stackItems = temp;
            m.stackView_leftMargin = leftMargin;
            m.stackView_rightMargin = rightMargin;
        } didSelectRowBlock:nil];
        [result addObject:cellModel];
        if (detailSetting) {
            detailSetting(cellModel, i);
        }
    }
    return result;
}



@end


@implementation CKJBaseBtnsCell

@end
