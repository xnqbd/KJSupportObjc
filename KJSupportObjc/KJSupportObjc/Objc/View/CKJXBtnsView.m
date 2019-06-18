//
//  CKJXStackView.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/6/14.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJXBtnsView.h"

@implementation CKJXBtnsViewConfig
@end

@implementation CKJXBtnItemData
@end




@interface CKJXBtnsView ()

@end

@implementation CKJXBtnsView

+ (nonnull instancetype)squareViewWithConfig:(CKJXBtnsViewConfig *_Nonnull)config itemData:(NSArray <__kindof CKJXBtnItemData *>*_Nullable)data {
    CKJXBtnsView *view = [[self alloc] init];
    
    UIStackView *stackV = [[UIStackView alloc] init];
    stackV.spacing = 0;
    stackV.axis = UILayoutConstraintAxisHorizontal;
    stackV.distribution = UIStackViewDistributionFillEqually;
    stackV.alignment = UIStackViewAlignmentFill;
    [view addSubview:stackV];
    view.stackView = stackV;
    [stackV kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.edges.equalTo(superview).insets(config.scrollView_Edge_SuperView);
    }];
    [view updateItemViewsWithItemData:data];
    return view;
}

- (void)updateItemViewsWithItemData:(NSArray <__kindof CKJXBtnItemData *>*_Nullable)data {
    
    NSArray *arrangedSubviews = self.stackView.arrangedSubviews;
    
    for (UIView *view in arrangedSubviews) {
        [self.stackView removeArrangedSubview:view];
    }
    
    for (int i = 0; i < data.count; i++) {
        
        CKJXBtnItemData *item = data[i];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.5];
        [btn setTitleColor:[UIColor kjwd_titleColor333333] forState:UIControlStateNormal];
        
        __weak typeof(self) weakSelf = self;
        [btn kjwd_addTouchUpInsideForCallBack:^(UIButton * _Nonnull sender) {
            
//            NSArray <__kindof CKJStackCellItemData *>*data = cell.cellModel.data;
//            CKJBtnsCellItemData *itemData = [data kjwd_objectAtIndex:i];
//            CKJSquare1ItemBlock block = itemData.callBack_Block;
//            
//            block ? block(itemData, i) : nil;
        }];
        
        [self updateItemView:btn itemData:item];
        
        //WDCKJBGColor_Arc4Color(btn);
        
        [self.stackView addArrangedSubview:btn];
    }
}





- (void)updateItemView:(__kindof UIButton *)btn itemData:(CKJXBtnItemData *)itemData {
    
//    UIImage *image = ({
//        UIImage *result = nil;
//        UIImage *pImage = itemData.pImage;
////        NSString *pImageName = itemData.pImageName;
//
//        if (WDKJ_IsNullObj(pImage, [UIImage class]) == NO) {
//            result = pImage;
//        } else if (WDKJ_IsEmpty_Str(pImageName) == NO) {
//            result = [UIImage kjwd_imageNamed:pImageName];
//        } else {
//            result = [[UIImage alloc] init];
//        }
//        result;
//    });
    
//    NSAttributedString *title = WDKJ_SpaceAttString(itemData.pAttTitle);
//    [btn setAttributedTitle:title forState:UIControlStateNormal];
//    [btn setImage:image forState:UIControlStateNormal];
//    
//    [btn kjwd_layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop imageTitleSpace:10];
}




@end
