//
//  CKJEsayCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/26.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJSquareCell1.h"

@implementation CKJSquare1SystemModel


+ (nonnull instancetype)esayWithNumberOfItemsInSingleLine:(NSUInteger)number {
    CKJSquare1SystemModel *model = [[self alloc] init];
    model.numberOfItemsInSingleLine = number;
    return model;
}

- (void)updateBtnWithStyle:(CKJSquare1FuncModel *)model btn:(UIButton *)btn {
    
    CKJSquare1StyleModel *style = model.style1;
    
    // 重新得到styleEnable数据
    if (model.style1.styleEnable) {
        
    } else if (model.style2.styleEnable) {
        style = model.style2;
    }
    
    NSAttributedString *title = WDKJ_ConfirmAttString(style.title);
    UIImage *image = style.image;
    [btn setAttributedTitle:title forState:UIControlStateNormal];
    
    if (WDKJ_IsNullObj(image, [UIImage class]) == NO) {
        [btn setImage:image forState:UIControlStateNormal];
    } else { // 重置图片
        [btn setImage:nil forState:UIControlStateNormal];
    }
    [btn kjwd_layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop imageTitleSpace:10];
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
            NSArray <__kindof CKJSquare1FuncModel *>*data = cell.cellModel.data;
            CKJSquare1FuncModel *target = [data kjwd_objectAtIndex:i];
            CKJSquare1FuncBlock block = nil;

            if (target.style1.styleEnable) {
                block = target.style1.func;
            } else if (target.style2.styleEnable) {
                block = target.style2.func;
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




@end


@implementation CKJSquare1StyleModel


@end


@implementation CKJSquare1FuncModel


+ (instancetype)modelWithTitle:(NSAttributedString *)title image:(UIImage *)image func:(CKJSquare1FuncBlock)func {
    CKJSquare1FuncModel *model = [[self alloc] init];
    CKJSquare1StyleModel *style1 = [[CKJSquare1StyleModel alloc] init];
    style1.styleEnable = YES;
    style1.title = title;
    style1.image = image;
    style1.func = func;
    model.style1 = style1;
    return model;
}

+ (instancetype)modelWithStyle:(void (^)(CKJSquare1StyleModel * _Nonnull __weak, CKJSquare1StyleModel * _Nonnull __weak))style {
    CKJSquare1FuncModel *model = [[self alloc] init];
    CKJSquare1StyleModel *style1Model = [[CKJSquare1StyleModel alloc] init];
    style1Model.styleEnable = YES;
    CKJSquare1StyleModel *style2Model = [[CKJSquare1StyleModel alloc] init];
    model.style1 = style1Model;
    model.style2 = style2Model;
    style ? style(style1Model, style2Model) : nil;
    return model;
}



@end

@implementation CKJSquareCell1Config


- (__kindof CKJSquare1SystemModel *)squareWithNumberOfItemsInSingleLine:(NSUInteger)number {
    self.esaySystemModel = [CKJSquare1SystemModel esayWithNumberOfItemsInSingleLine:number];
    return self.esaySystemModel;
}

@end


@implementation CKJSquareCell1Model

+ (nonnull instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJSquareCell1RowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJSquareCell1RowBlock)didSelectRowBlock {
    return [super modelWithCellHeight:cellHeight cellModel_id:cellModel_id detailSettingBlock:detailSettingBlock didSelectRowBlock:didSelectRowBlock];
}


@end


@implementation CKJSquareCell1


@end
