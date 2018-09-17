//
//  UIView+Desingable.m
//  RAC空项目
//
//  Created by chenkaijie on 17/4/17.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import "UIView+CKJDesingable.h"
#import <objc/runtime.h>


#pragma mark - -------------UIView-------------

@implementation UIView (CKJDesingable)



- (UIColor *)kBorderColor {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setKBorderColor:(UIColor *)kBorderColor {
    objc_setAssociatedObject(self, @selector(kBorderColor), kBorderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.borderColor = kBorderColor.CGColor;
}

- (CGFloat)kBorderWidth {
    id number = objc_getAssociatedObject(self, _cmd);
    if ([number respondsToSelector:@selector(floatValue)]) {
        return [number floatValue];
    }
    return 0;
}
- (void)setKBorderWidth:(CGFloat)kBorderWidth {
    objc_setAssociatedObject(self, @selector(kBorderWidth), @(kBorderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.borderWidth = kBorderWidth;
}

- (CGFloat)kCornerRadius {
    id number = objc_getAssociatedObject(self, _cmd);
    if ([number respondsToSelector:@selector(floatValue)]) {
        return [number floatValue];
    }
    return 0;
}
- (void)setKCornerRadius:(CGFloat)kCornerRadius {
    objc_setAssociatedObject(self, @selector(kCornerRadius), @(kCornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.cornerRadius = kCornerRadius;
    self.clipsToBounds = YES;
}

@end

#pragma mark - -------------UIButton-------------
@implementation UIButton (Helper)

- (UIColor *)normalBackgroundColor {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNormalBackgroundColor:(UIColor *)normalBackgroundColor {
    [self setBackgroundImage:[self kj_imageWithColor:normalBackgroundColor size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    objc_setAssociatedObject(self, @selector(normalBackgroundColor), normalBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)hightedBackgroundColor {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setHightedBackgroundColor:(UIColor *)hightedBackgroundColor {
    [self setBackgroundImage:[self kj_imageWithColor:hightedBackgroundColor size:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
    objc_setAssociatedObject(self, @selector(hightedBackgroundColor), hightedBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)selectedBackgroundColor {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setSelectedBackgroundColor:(UIColor *)selectBackgroundColor {
    [self setBackgroundImage:[self kj_imageWithColor:selectBackgroundColor size:CGSizeMake(1, 1)] forState:UIControlStateSelected];
    objc_setAssociatedObject(self, @selector(selectedBackgroundColor), selectBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)disableBackgroundColor {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setDisableBackgroundColor:(UIColor *)disableBackgroundColor {
    [self setBackgroundImage:[self kj_imageWithColor:disableBackgroundColor size:CGSizeMake(1, 1)] forState:UIControlStateDisabled];
    objc_setAssociatedObject(self, @selector(disableBackgroundColor), disableBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)kj_imageWithColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, CGRectMake(0, 0, size.width, size.height));
    //填充颜色为蓝色
    CGContextSetFillColorWithColor(context, color.CGColor);
    //在context上绘制
    CGContextFillPath(context);
    //把当前context的内容输出成一个UIImage图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //上下文栈pop出创建的context
    UIGraphicsEndImageContext();
    return image;
}


@end






