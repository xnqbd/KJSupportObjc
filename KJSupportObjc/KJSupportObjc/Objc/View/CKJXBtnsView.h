//
//  CKJXStackView.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/6/14.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN




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

- (void)updateItemViewsWithItemData:(NSArray <__kindof CKJXBtnItemData *>*_Nullable)data;


@end

NS_ASSUME_NONNULL_END
