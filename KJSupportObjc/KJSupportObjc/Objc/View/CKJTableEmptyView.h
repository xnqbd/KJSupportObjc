//
//  CKJTableEmptyView.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/26.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKJBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class CKJTableEmptyViewConfig, CKJTableEmptyView;

@interface CKJTableEmptyViewConfig : CKJCommonConfig

@property (assign, nonatomic) CGFloat avatar_TopMargin;
@property (assign, nonatomic) CGFloat avatar_MarginToMessage;

/**
 注意： 这个是message的顶部距离btn的顶部的距离
 */
@property (assign, nonatomic) CGFloat message_MarginToBtn;

@property (assign, nonatomic) CGSize avatarSize;


@property (copy, nonatomic, nonnull) void(^uisettingblock)(CKJTableEmptyView *emptyV, UIImageView *avatarImageView, UILabel *messageLabel, UIButton *btn);



+ (nonnull instancetype)cellConfigWithDetail:(nullable void(^)(__kindof CKJTableEmptyViewConfig *m))detailSettingBlock;

@end


@interface CKJTableEmptyView : UIView


@property (strong, nonatomic, nonnull) CKJTableEmptyViewConfig *config;


@property (strong, nonatomic, nonnull) UIImageView *avatarImageView;
@property (strong, nonatomic, nonnull) UILabel *messageLabel;

/**
 如果点击btn没有响应，可能是CKJTableEmptyView的高度为0
 */
@property (strong, nonatomic, nonnull) UIButton *btn;

/**
 更新文字

 @param message 可以是NSAttributedString类型、或者NSString类型
 */
- (void)updateMessage:(nullable id)message;

/**
 更新图片
 */
- (void)updateImage:(nullable UIImage *)image;


+ (nonnull instancetype)emptyViewWithConfig:(nonnull CKJTableEmptyViewConfig *)config;




@end

NS_ASSUME_NONNULL_END
