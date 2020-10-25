//
//  CKJUIMaker.m
//  MobileManage
//
//  Created by admin2 on 2020/6/17.
//  Copyright © 2020 admin2. All rights reserved.
//

#import "CKJUIMaker.h"

@implementation CKJUIMaker

+ (UIImageView *)imageViewWithImage:(UIImage *)image superView:(UIView *)superView makeConstraints:(void(NS_NOESCAPE ^_Nullable)(MASConstraintMaker *make, UIView *superview))consmake  detail:(void(^_Nullable)(UIImageView *i))detail {
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = image;
    [imageV kjwd_masWithSuperView:superView makeConstraints:consmake];
    if (detail) {
        detail(imageV);
    }
    return imageV;
}


+ (UIButton *)customButtonWithNormalTitle:(nullable id)title superView:(UIView *)superView makeConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))consmake click:(void(^_Nullable)(UIButton *sender))click detail:(void(^)(UIButton *b))detail {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    if ([title isKindOfClass:[NSString class]]) {
        [btn setTitle:title forState:UIControlStateNormal];
    } else if ([title isKindOfClass:[NSAttributedString class]]) {
        [btn setAttributedTitle:title forState:UIControlStateNormal];
    }
    
    [btn kjwd_addTouchUpInsideForCallBack:click];
    [btn kjwd_masWithSuperView:superView makeConstraints:consmake];
    if (detail) {
        detail(btn);
    }
    return btn;
}

+ (UILabel *)labelWithTitle:(nullable id)title superView:(UIView *)superView makeConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))consmake  detail:(void(^)(UILabel *l))detail {
    UILabel *lab = [[UILabel alloc] init];
    if ([lab isKindOfClass:[NSString class]]) {
        lab.text = title;
    } else if ([title isKindOfClass:[NSAttributedString class]]) {
        lab.attributedText = title;
    }
    [lab kjwd_masWithSuperView:superView makeConstraints:consmake];
    if (detail) {
        detail(lab);
    }
    return lab;
}


@end
