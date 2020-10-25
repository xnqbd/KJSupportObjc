//
//  CKJUIMaker.h
//  MobileManage
//
//  Created by admin2 on 2020/6/17.
//  Copyright © 2020 admin2. All rights reserved.
//

#import "CKJBaseModel.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CKJUIMaker : CKJBaseModel

+ (UIImageView *)imageViewWithImage:(UIImage *)image superView:(UIView *)superView makeConstraints:(void(NS_NOESCAPE ^_Nullable)(MASConstraintMaker *make, UIView *superview))consmake  detail:(void(^_Nullable)(UIImageView *i))detail;

+ (UIButton *)customButtonWithNormalTitle:(nullable id)title superView:(UIView *)superView makeConstraints:(void(NS_NOESCAPE ^_Nullable)(MASConstraintMaker *make, UIView *superview))consmake click:(void(^_Nullable)(UIButton *sender))click detail:(void(^_Nullable)(UIButton *b))detail;

+ (UILabel *)labelWithTitle:(nullable id)title superView:(UIView *)superView makeConstraints:(void(NS_NOESCAPE ^_Nullable)(MASConstraintMaker *make, UIView *superview))consmake  detail:(void(^_Nullable)(UILabel *l))detail;


@end

NS_ASSUME_NONNULL_END
