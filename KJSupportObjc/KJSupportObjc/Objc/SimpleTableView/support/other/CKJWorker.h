//
//  CKJWorker.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/16.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseModel.h"
#import <UIKit/UIKit.h>
#import "KJSupportHeader.h"

NS_ASSUME_NONNULL_BEGIN

@class CKJBtnItemData, CKJBaseBtnModel;

typedef void(^CKJBtnItemBlock)(__kindof CKJBtnItemData *_Nonnull itemData);
typedef void(^CKJBtnClick)(UIButton *btn, __kindof CKJBtnItemData *itemData);

UIKIT_EXTERN NSString *_Nonnull const KJPrefix_cellKEY;
UIKIT_EXTERN NSString *_Nonnull const KJPrefix_isRegisterNibKEY;
UIKIT_EXTERN NSString *_Nonnull const KJPrefix_configDicKEY_ConfigModel;
UIKIT_EXTERN NSString *_Nonnull const KJPrefix_headerFooterKey;


/** 完全自定义block */
UIKIT_EXTERN NSString *_Nonnull const KJPrefix_cCustomBlock;


UIKIT_EXTERN NSString *_Nonnull const KJPrefix_cNormalAttTitle;
UIKIT_EXTERN NSString *_Nonnull const KJPrefix_cSelectedAttTitle;

UIKIT_EXTERN NSString *_Nonnull const KJPrefix_cNormalImage;
UIKIT_EXTERN NSString *_Nonnull const KJPrefix_cSelectedImage;
UIKIT_EXTERN NSString *_Nonnull const KJPrefix_cNormalBgImage;
UIKIT_EXTERN NSString *_Nonnull const KJPrefix_cSelectedBgImage;


UIKIT_EXTERN NSString *_Nonnull const KJPrefix_cHighlightedAttTitle;
/** 高亮时候的image */
UIKIT_EXTERN NSString *_Nonnull const KJPrefix_cHighlightedImage;
/** 高亮时候的bgImage */
UIKIT_EXTERN NSString *_Nonnull const KJPrefix_cHighlightedBgImage;


UIKIT_EXTERN NSString *_Nonnull const KJPrefix_cBorderWidth;
UIKIT_EXTERN NSString *_Nonnull const KJPrefix_cBorderColor;
UIKIT_EXTERN NSString *_Nonnull const KJPrefix_cCornerRadius;



@interface CKJWorker : CKJBaseModel


+ (NSAttributedString *_Nonnull)changeOriginAtt:(nullable NSAttributedString *)origin text:(nullable NSString *)text;

+ (NSBundle *_Nonnull)kjbundle;


+ (void)reloadWithBtnModel:(CKJBaseBtnModel *)btn5Model btn:(UIButton *)btn5 emptyHandle:(void(^)(__kindof CKJBaseBtnModel *btnM))emptyHandle noEmptyHandle:(void(^)(__kindof CKJBaseBtnModel *btnM))noEmptyHandle;


+ (void)reloadBtn:(UIButton *)btn btnData:(CKJBtnItemData *)itemData;

@end


@interface CKJCommonItemData : CKJBaseModel

@end


@interface CKJCommonItemView : UIView

@end



/**
 这个类和 CKJBtnItemData 属性什么的都是一样的， 如果修改，记得把另外一个类也同步修改一下
 */
@interface CKJBtnItemData : CKJCommonItemData


@property(nonatomic, getter=isEnabled) BOOL enabled;
@property(nonatomic, getter=isSelected) BOOL selected;
@property(nonatomic, getter=isHighlighted) BOOL highlighted;


@property (copy, nonatomic, nullable) NSAttributedString *normalAttTitle;
@property (strong, nonatomic, nullable) UIImage *normalImage;
@property (strong, nonatomic, nullable) UIImage *normalBgImage;

@property (copy, nonatomic, nullable) NSAttributedString *selectedAttTitle;
@property (strong, nonatomic, nullable) UIImage *selectedImage;
@property (strong, nonatomic, nullable) UIImage *selectedBgImage;

@property (copy, nonatomic, nullable) NSAttributedString *highlightedAttTitle;
@property (strong, nonatomic, nullable) UIImage *highlightedImage;
@property (strong, nonatomic, nullable) UIImage *highlightedBgImage;


/** 边框宽度 */
@property (assign, nonatomic) CGFloat borderWidth;
/** 边框颜色 */
@property (strong, nonatomic) UIColor *borderColor;
/** 圆角*/
@property (assign, nonatomic) CGFloat cornerRadius;



//@property (copy, nonatomic, nullable) CKJBtnItemBlock callBack;



/// 对UIButton的图片和文字 进行排布回调
@property (copy, nonatomic, nullable) void (^layout_Button)(UIButton *btn);
@property (copy, nonatomic, nullable) CKJBtnClick click_Button;

/**
 创建多个items对象
 */
+ (NSArray <__kindof CKJBtnItemData *>*_Nonnull)returnItemsWithDics:(NSArray <NSDictionary *>*_Nullable)dics detailSetting:(void(^_Nullable)(__kindof CKJBtnItemData *__weak _Nonnull itemData, NSUInteger index))detailSetting;

+ (NSArray <NSArray <CKJBtnItemData *> *>*_Nonnull)returnItemsWithDicsnew:(NSArray <NSArray <NSDictionary *> *>*_Nullable)dics detailSetting:(void(^_Nullable)(CKJBtnItemData *__weak _Nonnull itemData, NSUInteger index))detailSetting;

@end




typedef void(^CKJBaseBtnClick)(CKJBaseBtnModel *btnModel, UIButton *btn);



@interface CKJBaseBtnModel : CKJBaseModel

@property (copy, nonatomic, nullable) NSAttributedString *normalAttributedTitle;
@property (copy, nonatomic, nullable) NSAttributedString *selectedAttributedTitle;

/** 改变Normal状态下的文字 */
- (void)changeNormalText:(nullable NSString *)text;

/** 改变Normal状态下的文字 */
- (void)changeSelectedText:(nullable NSString *)text;

@property (strong, nonatomic, nullable) UIImage *normalBackgroundImage;
@property (strong, nonatomic, nullable) UIImage *selectedBackgroundImage;

@property (strong, nonatomic, nullable) UIImage *normalImage;
@property (strong, nonatomic, nullable) UIImage *selectedImage;

@property (assign, nonatomic) BOOL btnHidden;

/** 是否选中 */
@property (assign, nonatomic) BOOL selected;
/** 是否开启用户交互，默认开启 */
@property (assign, nonatomic) BOOL userInteractionEnabled;

@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGFloat cornerRadius;
@property (strong, nonatomic, nullable) UIColor *borderColor;
@property (assign, nonatomic) CGFloat borderWidth;


@property (weak, nonatomic) UIButton *currentBtn;


/**
 对UIButton的图片和文字 进行排布回调
 sender.layoutButton = ^(UIButton *btn) {
     [btn kjwd_layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleRight imageTitleSpace:0];
 };
 
 */
@property (copy, nonatomic, nullable) void (^layoutButton)(UIButton *_Nonnull btn);


/// 点击事件
@property (copy, nonatomic, nullable) CKJBaseBtnClick click;

@end




typedef void(^CKJMyVCItemClick)(id _Nullable param);

/// 我的、个人界面
@interface CKJMyVCItem : CKJBaseModel

@property (copy, nonatomic, nullable) id image;
@property (copy, nonatomic) id title;
@property (copy, nonatomic) CKJMyVCItemClick click;


+ (instancetype)itemWithImage:(nullable id)image title:(id)title click:(CKJMyVCItemClick)click;

@end







NS_ASSUME_NONNULL_END
