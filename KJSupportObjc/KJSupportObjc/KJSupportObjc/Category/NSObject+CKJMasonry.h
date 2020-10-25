//
//  NSObject+CKJMasonry.h
//  MobileHospital_Renji
//
//  Created by admin2 on 2020/6/19.
//  Copyright © 2020 Lyc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Masonry/Masonry.h>
#import "NSObject+WDYHFCategory.h"

NS_ASSUME_NONNULL_BEGIN

@class MASViewAttribute, MASConstraintMaker;

@interface UIView (CKJMasonry)


/**
 这几个属性是 Masonry的封装
 */
@property (nonatomic, strong, nullable, readonly) MASViewAttribute * kjwdMas_safeAreaTop;
@property (nonatomic, strong, nullable, readonly) MASViewAttribute * kjwdMas_safeAreaBottom;
@property (nonatomic, strong, nullable, readonly) MASViewAttribute * kjwdMas_safeAreaLeft;
@property (nonatomic, strong, nullable, readonly) MASViewAttribute * kjwdMas_safeAreaRight;

- (NSArray *_Nullable)kjwd_masWithSuperView:(UIView *)superView makeConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))block;


- (NSArray *_Nullable)kjwd_mas_makeConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))block;
- (NSArray *_Nullable)kjwd_mas_updateConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))block;
- (NSArray *_Nullable)kjwd_mas_remakeConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))block;
- (void)kjwd_addToSuperView:(nullable UIView *)superview constraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))block;



#pragma mark - View从底部向上出现的动画效果

/**
 想要从底部向上钻处理的视图, 只需要创建对象，不需要设置frame和约束
 */
- (void)masonryWithAnimateFromScreenButtomWithDuration:(NSTimeInterval)duration superView:(UIView *_Nullable)superView selfMasonryHeight:(CGFloat)height coverViewColor:(UIColor *_Nullable)coverViewColor animationCompletion:(void (^_Nullable)(BOOL))completionBlock triggerTapGestureRecognizerBlock:(void(^)(void(^_disappearBlock)(void)))triggerTapGestureRecognizerBlock;
/** 点击灰色蒙版消失，需要开发者主动调用（View从底部向上出现的动画效果是配合使用） */
- (void)masonryWithAnimateFromScreenButtom_hiddenBackGroundView;



@end




@interface UIScrollView (CKJMasonry)

/**
 垂直方向添加Views
 
 @param views views数组
 @param viewHeight 每一个View的高度
 @param itemSpacing 每一个View之间的间距
 @param topSpacing 顶部间距
 @param bottomSpacing 底部间距
 @param horizontalConstraints 水平方向的约束
 
 比如
 make.left.equalTo(@10);
 make.width.equalTo(@100);
 
 */
- (void)kjwd_viewsOfVertical:(NSArray <UIView *>*)views viewHeight:(CGFloat)viewHeight itemSpacing:(CGFloat)itemSpacing topSpacing:(CGFloat)topSpacing bottomSpacing:(CGFloat)bottomSpacing horizontalConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))horizontalConstraints;


/**
 水平方向添加Views

 @param views views数组
 @param width 每一个View的宽度
 @param itemSpacing 每一个View之间的间距
 @param leftSpacing 左边距离
 @param rightSpacing 右边距离
 @param verticalConstraints 垂直方向的约束
 */
- (void)kjwd_viewsOfHorizontal:(NSArray <UIView *>*)views viewWidth:(CGFloat)width itemSpacing:(CGFloat)itemSpacing leftSpacing:(CGFloat)leftSpacing rightSpacing:(CGFloat)rightSpacing vorizontalConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))verticalConstraints;

@end


NS_ASSUME_NONNULL_END
