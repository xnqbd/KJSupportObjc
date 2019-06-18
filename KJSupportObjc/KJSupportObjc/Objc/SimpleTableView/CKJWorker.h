//
//  CKJWorker.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/16.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseModel.h"
#import <UIKit/UIKit.h>


@class CKJBtnItemData;

typedef void(^CKJBtnItemBlock)(__kindof CKJBtnItemData *_Nonnull itemData);




UIKIT_EXTERN NSString *_Nonnull const cellKEY;
UIKIT_EXTERN NSString *_Nonnull const isRegisterNibKEY;
UIKIT_EXTERN NSString *_Nonnull const registerNibNameKEY;
UIKIT_EXTERN NSString *_Nonnull const configDicKEY_ConfigModel;
UIKIT_EXTERN NSString *_Nonnull const headerFooterKey;


UIKIT_EXTERN NSString *_Nonnull const cNormalAttTitle;
UIKIT_EXTERN NSString *_Nonnull const cSelectedAttTitle;

UIKIT_EXTERN NSString *_Nonnull const cNormalImage;
UIKIT_EXTERN NSString *_Nonnull const cSelectedImage;
UIKIT_EXTERN NSString *_Nonnull const cNormalBgImage;
UIKIT_EXTERN NSString *_Nonnull const cSelectedBgImage;

UIKIT_EXTERN NSString *_Nonnull const cBorderWidth;
UIKIT_EXTERN NSString *_Nonnull const cBorderColor;
UIKIT_EXTERN NSString *_Nonnull const cCornerRadius;


NS_ASSUME_NONNULL_BEGIN

@interface CKJWorker : CKJBaseModel


+ (NSAttributedString *_Nonnull)changeOriginAtt:(nullable NSAttributedString *)origin text:(nullable NSString *)text;

@end


@interface CKJCommonItemData : CKJBaseModel

@end


@interface CKJCommonItemView : UIView

@end



/**
 这个类和 CKJBtnsCellItemData 属性什么的都是一样的， 如果修改，记得把另外一个类也同步修改一下
 */
@interface CKJBtnItemData : CKJCommonItemData


@property(nonatomic,getter=isEnabled) BOOL enabled;
@property(nonatomic,getter=isSelected) BOOL selected;
@property(nonatomic,getter=isHighlighted) BOOL highlighted;

@property (copy, nonatomic, nullable) NSAttributedString *normalAttTitle;
@property (copy, nonatomic, nullable) NSAttributedString *selectedAttTitle;
@property (strong, nonatomic, nullable) UIImage *normalImage;
@property (strong, nonatomic, nullable) UIImage *selectedImage;
@property (strong, nonatomic, nullable) UIImage *normalBgImage;
@property (strong, nonatomic, nullable) UIImage *selectedBgImage;

/** 边框宽度 */
@property (assign, nonatomic) CGFloat borderWidth;
/** 边框颜色 */
@property (strong, nonatomic) UIColor *borderColor;
/** 圆角*/
@property (assign, nonatomic) CGFloat cornerRadius;



@property (copy, nonatomic, nullable) CKJBtnItemBlock callBack_Block;

/**
 创建多个items对象
 */
+ (NSArray <__kindof CKJBtnItemData *>*_Nonnull)returnItemsWithDics:(NSArray <NSDictionary *>*_Nullable)dics detailSetting:(void(^_Nullable)(__kindof CKJBtnItemData *__weak _Nonnull itemData, NSUInteger index))detailSetting;

@end



NS_ASSUME_NONNULL_END
