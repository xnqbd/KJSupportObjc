//
//  UIView+Desingable.m
//  RAC空项目
//
//  Created by chenkaijie on 17/4/17.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import "UIView+Desingable.h"
#import <objc/runtime.h>


#pragma mark - -------------UIView-------------

@implementation UIView (Desingable)

- (UIColor *)borderColor {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setBorderColor:(UIColor *)borderColor {
    objc_setAssociatedObject(self, @selector(borderColor), borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.borderColor = borderColor.CGColor;
}

- (CGFloat)borderWidth {
    id number = objc_getAssociatedObject(self, _cmd);
    if ([number respondsToSelector:@selector(floatValue)]) {
        return [number floatValue];
    }
    return 0;
}
- (void)setBorderWidth:(CGFloat)borderWidth {
    objc_setAssociatedObject(self, @selector(borderWidth), @(borderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)cornerRadius {
    id number = objc_getAssociatedObject(self, _cmd);
    if ([number respondsToSelector:@selector(floatValue)]) {
        return [number floatValue];
    }
    return 0;
}
- (void)setCornerRadius:(CGFloat)cornerRadius {
    objc_setAssociatedObject(self, @selector(cornerRadius), @(cornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = YES;
}

- (UIColor *)originalBackgroundColor {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setOriginalBackgroundColor:(UIColor *)originalBackgroundColor {
    objc_setAssociatedObject(self, @selector(originalBackgroundColor), originalBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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






