//
//  UIView+Desingable.m
//  RAC空项目
//
//  Created by chenkaijie on 17/4/17.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import "UIView+CKJDesingable.h"
#import <objc/runtime.h>
#import "NSObject+WDYHFCategory.h"

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
    self.clipsToBounds = YES; // 子视图 超出父视图 会被剪切
}



/*
 self.thebgV.backgroundColor = [UIColor whiteColor];
 [self.thebgV kjwd_cornerRadius:8 shadowColor:nil shadowOffset:CGSizeZero shadowOpacity:nil shadowRadius:@5];
 */
- (void)kjwd_cornerRadius:(CGFloat)cornerRadius shadowColor:(nullable UIColor *)shadowColor shadowOffset:(CGSize)shadowOffset shadowOpacity:(nullable NSNumber *)shadowOpacity shadowRadius:(nullable NSNumber *)shadowRadius {
    
    if (self.backgroundColor == nil) {
        NSLog(@"没有背景颜色，可能会没有阴影效果");
    }
    
    
    UIColor *color = WDKJ_IsNullObj(shadowColor, [UIColor class]) ? [UIColor lightGrayColor] : shadowColor;
    
    
    self.layer.cornerRadius  = cornerRadius;
    self.layer.masksToBounds = NO;
    
    self.layer.shadowColor   =  color.CGColor;
    self.layer.shadowOffset  = shadowOffset;
    
    self.layer.shadowOpacity = WDKJ_IsNull_Num(shadowOpacity) ? 0.5 : shadowOpacity.floatValue; // 阴影透明度
    self.layer.shadowRadius  = WDKJ_IsNull_Num(shadowRadius) ? 8 : shadowRadius.floatValue;
    
    
    
//    sv.layer.cornerRadius  = 20;
//    sv.layer.masksToBounds = NO;
//    
//    sv.layer.shadowColor   = [UIColor lightGrayColor].CGColor;
//    sv.layer.shadowOffset  = CGSizeMake(0, 0);
//    sv.layer.shadowOpacity = 0.6; // 阴影透明度
//    sv.layer.shadowRadius  = 10;
    
}


@end

#pragma mark - -------------UIButton-------------
@implementation UIButton (CKJDesingable)

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


#pragma mark - -------------UILabel-------------

@implementation UILabel (CKJDesingable)

- (void)setKLineSpace:(CGFloat)kLineSpace {
    objc_setAssociatedObject(self, @selector(kLineSpace), @(kLineSpace), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:kLineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}
- (CGFloat)kLineSpace {
    id number = objc_getAssociatedObject(self, _cmd);
    if ([number respondsToSelector:@selector(floatValue)]) {
        return [number floatValue];
    }
    return 0;
}

- (void)setKWordSpace:(CGFloat)kWordSpace {
    objc_setAssociatedObject(self, @selector(kWordSpace), @(kWordSpace), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(kWordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}
- (CGFloat)kWordSpace {
    id number = objc_getAssociatedObject(self, _cmd);
    if ([number respondsToSelector:@selector(floatValue)]) {
        return [number floatValue];
    }
    return 0;
}


@end



@implementation CKJBottomLineView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddRect(ctx, CGRectMake(0, rect.size.height - 0.7, rect.size.width, 0.7));
    if (self.bottomColor) {
        [self.bottomColor setFill];
    } else {
        UIColor *color = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1];
        [color setFill];
    }
    CGContextFillPath(ctx);
}



@end
