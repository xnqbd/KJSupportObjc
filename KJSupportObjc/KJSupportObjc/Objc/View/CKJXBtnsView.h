//
//  CKJXStackView.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/6/14.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKJWorker.h"


NS_ASSUME_NONNULL_BEGIN




typedef NS_ENUM(NSUInteger, CKJBtnsViewUpdateStyle) {
    /** 仅仅更新视图 */
    CKJBtnsViewUpdateStyle_OnlyUpdateView,
    /** 移除旧View，重新根据数据添加新View，更新视图 */
    CKJBtnsViewUpdateStyle_RemoveViewsAndUpdateView,
};




@interface CKJXBtnsViewConfig :  CKJCommonConfig

@property (assign, nonatomic) UIEdgeInsets scrollView_Edge_SuperView;

@end

@interface CKJXBtnItemData : CKJBtnItemData


@end


/**
 这个一个UIStackView， 子视图全是UIButton
 */
@interface CKJXBtnsView : UIView

@property (strong, nonatomic) UIStackView *stackView;

@property (strong, nonatomic) NSArray <__kindof CKJXBtnItemData *>*data;

+ (nonnull instancetype)squareViewWithConfig:(CKJXBtnsViewConfig *_Nonnull)config itemData:(NSArray <__kindof CKJXBtnItemData *>*_Nullable)data;

- (void)updateItemViewsWithItemData:(NSArray <__kindof CKJXBtnItemData *>*_Nullable)data updateStyle:(CKJBtnsViewUpdateStyle)updateStyle;


@end

NS_ASSUME_NONNULL_END
