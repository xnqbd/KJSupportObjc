//
//  UIView+Desingable.h
//  RAC空项目
//
//  Created by chenkaijie on 17/4/17.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - -------------UIView-------------
IB_DESIGNABLE
@interface UIView (CKJDesingable)

/** 边框宽度 */
@property (assign, nonatomic) IBInspectable CGFloat kBorderWidth;
/** 边框颜色 */
@property (strong, nonatomic) IBInspectable UIColor *kBorderColor;
/** 圆角*/
@property (assign, nonatomic) IBInspectable CGFloat kCornerRadius;

@end

#pragma mark - -------------UIButton-------------
IB_DESIGNABLE
@interface UIButton (CKJDesingable)

/** 背景色(正常) */
@property (strong, nonatomic) IBInspectable UIColor *normalBackgroundColor;

/** 高亮 */
@property (strong, nonatomic) IBInspectable UIColor *hightedBackgroundColor;

/** 背景色(选中) */
@property (strong, nonatomic) IBInspectable UIColor *selectedBackgroundColor;

/** 不可用 */
@property (strong, nonatomic) IBInspectable  UIColor *disableBackgroundColor;

@end


#pragma mark - -------------UILabel-------------

@interface UILabel (CKJDesingable)

/**
 *  行间距
 */
@property (assign, nonatomic) IBInspectable CGFloat kLineSpace;
/**
 *  间距
 */
@property (assign, nonatomic) IBInspectable CGFloat kWordSpace;

@end



