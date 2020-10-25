//
//  NSObject+CKJMasonry.m
//  MobileHospital_Renji
//
//  Created by admin2 on 2020/6/19.
//  Copyright © 2020 Lyc. All rights reserved.
//

#import "NSObject+CKJMasonry.h"
#import "UIView+CKJDesingable.h"
#import "NSObject+WDYHFCategory.h"

@interface UIView (CKJMasonryProperty)


@property (weak, nonatomic) UIView *animateFromScreenButtomWithBackGroundView;
@property (assign, nonatomic) CGFloat animateFromScreenButtomWithHeight;
@property (assign, nonatomic) NSTimeInterval animateFromScreenButtomWithDuration;
@property (copy, nonatomic) void (^triggerTapGestureRecognizerBlock)(void(^disappearBlock)(void));
@property (copy, nonatomic) void (^gestureRecognizerBlock)(UIGestureRecognizer *sender, UIView *currentView);

@end

@implementation UIView (CKJMasonry)


- (MASViewAttribute *)kjwdMas_safeAreaTop {
    if (@available(iOS 11.0, *)) {
        return self.mas_safeAreaLayoutGuideTop;
    } else {
        return self.mas_top;
    }
}
- (MASViewAttribute *)kjwdMas_safeAreaBottom {
    if (@available(iOS 11.0, *)) {
        return self.mas_safeAreaLayoutGuideBottom;
    } else {
        return self.mas_bottom;
    }
}
- (MASViewAttribute *)kjwdMas_safeAreaLeft {
    if (@available(iOS 11.0, *)) {
        return self.mas_safeAreaLayoutGuideLeft;
    } else {
        return self.mas_left;
    }
}
- (MASViewAttribute *)kjwdMas_safeAreaRight {
    if (@available(iOS 11.0, *)) {
        return self.mas_safeAreaLayoutGuideRight;
    } else {
        return self.mas_right;
    }
}

/*
 
 make.left.equalTo(superview.kjwdMas_safeAreaLeft);
 make.right.equalTo(superview.kjwdMas_safeAreaRight);
 make.top.equalTo(superview.kjwdMas_safeAreaTop);
 make.bottom.equalTo(superview.kjwdMas_safeAreaBottom);
 
 make.height.equalTo(@60);
 
 */

- (NSArray *)kjwd_masWithSuperView:(UIView *)superView makeConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))block {
    [superView addSubview:self];
    return [self kjwd_mas_makeConstraints:block];
}

- (NSArray *)kjwd_mas_makeConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))block {
    if (self.superview == nil) {
        NSLog(@"%@的父视图为空", self);
        return nil;
    }
    if (block == nil) {
        return nil;
    }
    UIView *superV = self.superview;
    return [self mas_makeConstraints:^(MASConstraintMaker *make) {
        block(make, superV);
    }];
}

- (NSArray *)kjwd_mas_updateConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))block {
    if (self.superview == nil) {
        NSLog(@"%@的父视图为空", self);
        return nil;
    }
    if (block == nil) {
        return nil;
    }
    UIView *superV = self.superview;
    return [self mas_updateConstraints:^(MASConstraintMaker *make) {
        block(make, superV);
    }];
}
- (NSArray *)kjwd_mas_remakeConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))block {
    if (self.superview == nil) {
        NSLog(@"%@的父视图为空", self);
        return nil;
    }
    if (block == nil) {
        return nil;
    }
    UIView *superV = self.superview;
    return [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        block(make, superV);
    }];
}

- (void)kjwd_addToSuperView:(nullable UIView *)superview constraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))block {
    if (superview == nil) return;
    if ([superview isKindOfClass:[UIView class]] == NO) return;
    
    [superview addSubview:self];
    [self kjwd_mas_makeConstraints:block];
}



#pragma mark - 从底部向上钻动画效果
- (void)masonryWithAnimateFromScreenButtomWithDuration:(NSTimeInterval)duration superView:(UIView *_Nullable)superView selfMasonryHeight:(CGFloat)height coverViewColor:(UIColor *_Nullable)coverViewColor animationCompletion:(void (^_Nullable)(BOOL))completionBlock triggerTapGestureRecognizerBlock:(void(^)(void(^ disappearBlock)(void)))triggerTapGestureRecognizerBlock {
    
    self.triggerTapGestureRecognizerBlock = triggerTapGestureRecognizerBlock;
    
    if (superView == nil) {
        superView = [UIWindow kjwd_appdelegateWindow];
    }
    if (coverViewColor == nil) {
        coverViewColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    
    UIView *backGroundView = ({
        UIView *tmp = [[UIView alloc] init];
        tmp.backgroundColor = [UIColor clearColor];
        [superView addSubview:tmp];
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(kjwd_tapBackGroundView)];
        [tmp addGestureRecognizer:tap];
        self.animateFromScreenButtomWithBackGroundView = tmp;
        tmp;
    });
    [superView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.height.equalTo(@(height));
        make.bottom.equalTo(superView.mas_bottom).offset(height);
    }];
    [backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(superView);
        make.bottom.equalTo(self.mas_top);
    }];
    
    [superView layoutIfNeeded];
    
    self.animateFromScreenButtomWithDuration = duration;
    self.animateFromScreenButtomWithHeight = height;
    
    
    [UIView animateWithDuration:duration animations:^{
        backGroundView.backgroundColor = coverViewColor ? coverViewColor : [UIColor blackColor];
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(superView.mas_bottom);
        }];
        [superView layoutIfNeeded];
    } completion:^(BOOL finished) {
        completionBlock ? completionBlock(finished) : nil;
    }];
}

// 这个是从底部向上点击事件
- (void)kjwd_tapBackGroundView {
    void (^disappearBlock)(void) = ^ {
        [self masonryWithAnimateFromScreenButtom_hiddenBackGroundView];
    };
    self.triggerTapGestureRecognizerBlock ? self.triggerTapGestureRecognizerBlock(disappearBlock) : nil;
}

/** 这个和上面的向上钻的效果是配合使用 */
- (void)masonryWithAnimateFromScreenButtom_hiddenBackGroundView {
    UIView *superView = self.superview;
    [UIView animateWithDuration:self.animateFromScreenButtomWithDuration animations:^{
        self.animateFromScreenButtomWithBackGroundView.backgroundColor = [UIColor clearColor];
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(superView.mas_bottom).offset(self.animateFromScreenButtomWithHeight);
        }];
        [superView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.animateFromScreenButtomWithBackGroundView removeFromSuperview];
        [self removeFromSuperview];
    }];
}


@end

@implementation UIScrollView (CKJMasonry)

/**
 垂直方向添加Views
 
 @param views views数组
 @param itemSpacing 每一个View之间的间距
 @param topSpacing 顶部间距
 @param bottomSpacing 底部间距
 @param horizontalConstraints 水平方向的约束
 
 比如
 make.left.equalTo(@10);
 make.width.equalTo(@100);
 
 */
- (void)kjwd_viewsOfVertical:(NSArray <UIView *>*)views viewHeight:(CGFloat)height itemSpacing:(CGFloat)itemSpacing topSpacing:(CGFloat)topSpacing bottomSpacing:(CGFloat)bottomSpacing horizontalConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))horizontalConstraints {
    
    if (horizontalConstraints == nil) {
        return;
    }
    
    UIView *contentView = [[UIView alloc] init];
    [self addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.width.equalTo(self);
    }];
    
    UIView *lastView = nil;
    
    
    for (int i = 0; i < views.count; i++) {
        UIView *view = views[i];
//        WDCKJBGColor_Arc4Color(view);
        [contentView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.top.equalTo(@(topSpacing));
            } else {
                make.top.equalTo(lastView.mas_bottom).offset(itemSpacing);
            }
            make.height.equalTo(@(height));
            
            horizontalConstraints(make, view.superview);
        }];
        
        lastView = view;
    }
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom).offset(bottomSpacing);
    }];
}

- (void)kjwd_viewsOfHorizontal:(NSArray <UIView *>*)views viewWidth:(CGFloat)width itemSpacing:(CGFloat)itemSpacing leftSpacing:(CGFloat)leftSpacing rightSpacing:(CGFloat)rightSpacing vorizontalConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))verticalConstraints {
    if (verticalConstraints == nil) return;
    
    UIView *contentView = [[UIView alloc] init];
    [self addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.height.equalTo(self);
    }];
    
    UIView *lastView = nil;

    for (int i = 0; i < views.count; i++) {
        UIView *view = views[i];
//        WDCKJBGColor_Arc4Color(view);
        [contentView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.equalTo(@(leftSpacing));
            } else {
                make.left.equalTo(lastView.mas_right).offset(itemSpacing);
            }
            make.width.equalTo(@(width));
            verticalConstraints(make, view.superview);
        }];
        
        lastView = view;
    }
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastView.mas_right).offset(rightSpacing);
    }];
}

@end


