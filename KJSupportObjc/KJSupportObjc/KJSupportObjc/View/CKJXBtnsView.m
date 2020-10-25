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
            [btn setTitleColor:[UIColor kjwd_title] forState:UIControlStateNormal];
            
            __weak CKJXBtnItemData *weakItemData = item;
            
            [btn kjwd_addTouchUpInsideForCallBack:^(UIButton * _Nonnull sender) {
                if (weakItemData.click_Button) {
                    weakItemData.click_Button(sender, weakItemData);
                }
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
    [CKJWorker reloadBtn:btn btnData:itemData];
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
