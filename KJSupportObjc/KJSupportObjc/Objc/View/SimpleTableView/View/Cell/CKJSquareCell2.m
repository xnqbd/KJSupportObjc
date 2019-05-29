//
//  CKJSquareCell2.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/27.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJSquareCell2.h"
#import "CKJSimpleTableView.h"

@implementation CKJSquare2SystemModel

+ (__kindof CKJSquare2SystemModel *)square2WithNumberOfItemsInSingleLine:(NSUInteger)number {
    CKJSquare2SystemModel *model = [[self alloc] init];
    model.numberOfItemsInSingleLine = number;
    return model;
}

#pragma mark - CKJStackCellDataSource

- (NSArray <__kindof UIView *>*)createItemViewForCKJStackCell:(__kindof CKJStackCell *__weak)cell {
    
    NSMutableArray <__kindof UIView *>*result = [NSMutableArray array];
    
        __weak typeof(self) weakSelf = self;
    
    for (int i = 0; i < self.numberOfItemsInSingleLine; i++) {
        
        UIButton *btn = [[UIButton alloc] init];
        //WDCKJBGColor_Arc4Color(btn);
        
        btn.titleLabel.font = [UIFont systemFontOfSize:15.5];
        [btn setTitleColor:[UIColor kjwd_titleColor333333] forState:UIControlStateNormal];
        
        [btn kjwd_addTouchUpInsideForCallBack:^(UIButton * _Nonnull sender) {
            NSArray <__kindof CKJSquare2FuncModel *>*data = cell.cellModel.data;
            CKJSquare2FuncModel *target = [data kjwd_objectAtIndex:i];
            CKJSquare2FuncBlock block = nil;
            
            if (target.normalStyle.styleEnable) {
                block = target.normalStyle.func;
            } else if (target.selectStyle.styleEnable) {
                block = target.selectStyle.func;
            }
            block ? block() : nil;
            // 重新刷新数据
            [weakSelf updateBtnWithStyle:target btn:sender];
        }];
        
        [result addObject:btn];
    }
    return result;
}

- (void)updateUIWithItemHandle:(__kindof CKJStackItemHandleModel *)handle index:(NSInteger)index view:(__kindof UIButton * _Nonnull)view {
    [self updateBtnWithStyle:handle btn:view];
}

#pragma mark - 其他
- (void)updateBtnWithStyle:(CKJSquare2FuncModel *)model btn:(UIButton *)btn {
    
    CKJSquare2StyleModel *style = model.normalStyle;
    
    // 重新得到styleEnable数据
    if (model.normalStyle.styleEnable) {
    } else if (model.selectStyle.styleEnable) {
        style = model.selectStyle;
    }
    
    NSAttributedString *title = WDKJ_ConfirmAttString(style.title);
    UIImage *bgImage = style.bgImage;
    [btn setAttributedTitle:title forState:UIControlStateNormal];
    
    if (WDKJ_IsNullObj(bgImage, [UIImage class]) == NO) {
        [btn setBackgroundImage:bgImage forState:UIControlStateNormal];
    } else { // 重置图片
        [btn setBackgroundImage:nil forState:UIControlStateNormal];
    }
}


@end


@implementation CKJSquare2StyleModel


@end


@implementation CKJSquare2FuncModel



+ (nonnull instancetype)modelWithTitle:(NSAttributedString *)title bgImage:(UIImage *)bgImage func:(CKJSquare2FuncBlock)func {
    CKJSquare2FuncModel *model = [[self alloc] init];
    CKJSquare2StyleModel *style1 = [[CKJSquare2StyleModel alloc] init];
    style1.styleEnable = YES;
    style1.title = title;
    style1.bgImage = bgImage;
    style1.func = func;
    model.normalStyle = style1;
    return model;
}


+ (nonnull instancetype)modelWithStyle:(void(^)(__weak CKJSquare2StyleModel *normalStyle, __weak CKJSquare2StyleModel *selectStyle))style {
    CKJSquare2FuncModel *model = [[self alloc] init];
    CKJSquare2StyleModel *normalModel = [[CKJSquare2StyleModel alloc] init];
    normalModel.styleEnable = YES;
    CKJSquare2StyleModel *selectModel = [[CKJSquare2StyleModel alloc] init];
    model.normalStyle = normalModel;
    model.selectStyle = selectModel;
    style ? style(normalModel, selectModel) : nil;
    return model;
}



@end

@implementation CKJSquareCell2Config


- (__kindof CKJSquare2SystemModel *)squareWithNumberOfItemsInSingleLine:(NSUInteger)number {
    self.esaySystemModel = [CKJSquare2SystemModel square2WithNumberOfItemsInSingleLine:number];
    return self.esaySystemModel;
}


@end


@implementation CKJSquareCell2Model


+ (nonnull instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJSquareCell2RowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJSquareCell2RowBlock)didSelectRowBlock {
    return [super modelWithCellHeight:cellHeight cellModel_id:cellModel_id detailSettingBlock:detailSettingBlock didSelectRowBlock:didSelectRowBlock];
}


@end


@implementation CKJSquareCell2


@end
