//
//  CKJXStackView.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/6/14.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJXBtnsView.h"
#import "UIView+CKJDesingable.h"
#import "CKJEmptyCell.h"

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
    [view updateItemViewsWithItemData:data updateStyle:CKJBtnsViewUpdateStyle_RemoveViewsAndUpdateView];
    return view;
}

- (void)updateItemViewsWithItemData:(NSArray <__kindof CKJXBtnItemData *>*_Nullable)data updateStyle:(CKJBtnsViewUpdateStyle)updateStyle {

    
    if (updateStyle == CKJBtnsViewUpdateStyle_OnlyUpdateView) {
        NSArray *arrangedSubviews = self.stackView.arrangedSubviews;
        for (int i = 0; i < arrangedSubviews.count; i++) {
            UIButton *btn = self.stackView.arrangedSubviews[i];
            CKJXBtnItemData *itemData = [data kjwd_objectAtIndex:i];
            [self updateItemView:btn itemData:itemData];
        }
    } else {
        
        for (UIView *view in self.stackView.arrangedSubviews) {
            [self.stackView removeArrangedSubview:view];
        }
        
        for (int i = 0; i < data.count; i++) {
            
            CKJXBtnItemData *item = data[i];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            //WDCKJBGColor_Arc4Color(btn);
            //__weak typeof(self) weakSelf = self;
            btn.titleLabel.font = [UIFont systemFontOfSize:15.5];
            [btn setTitleColor:[UIColor kjwd_titleColor333333] forState:UIControlStateNormal];
            
            __weak CKJXBtnItemData *weakItemData = item;
            
            [btn kjwd_addTouchUpInsideForCallBack:^(UIButton * _Nonnull sender) {
                CKJBtnItemBlock block = weakItemData.callBack;
                block ? block(weakItemData) : nil;
            }];
            
            [self updateItemView:btn itemData:item];
            if (item.layout_Button) {
                item.layout_Button(btn);
            }
            
            [self.stackView addArrangedSubview:btn];
        }
    }
}





- (void)updateItemView:(__kindof UIButton *)btn itemData:(CKJXBtnItemData *)itemData {
    
    
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
//    if (itemData.layoutButton) {
//        itemData.layoutButton(btn);
//    }
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
