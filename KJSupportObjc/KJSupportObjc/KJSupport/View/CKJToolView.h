//
//  CKJToolView.h
//  WDYHFSDK
//
//  Created by chenkaijie on 2018/9/15.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CKJToolView;

@interface CKJToolView  <E : UIView *> : UIView


@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) void (^cancelBlock)(__kindof CKJToolView *currentView);
@property (copy, nonatomic) void (^confirmBlock)(id data, __kindof CKJToolView *currentView);


/**
 下面的目标View
 */
@property (strong, nonatomic) E targetView;


/**
 背景View
 */
@property (strong, nonatomic) UIView *bgV;
@property (strong, nonatomic) UIToolbar *toolBar;
@property (strong, nonatomic) UIView *bottomContentView;



- (void)cancelAction:(UIBarButtonItem *)sender;
/**
 等着子类重写
 */
- (void)doneAction:(UIBarButtonItem *)sender;


@end
