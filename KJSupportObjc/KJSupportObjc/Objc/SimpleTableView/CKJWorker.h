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

@class CKJBtnItemData;

typedef void(^CKJBtnItemBlock)(__kindof CKJBtnItemData *_Nonnull itemData);


UIKIT_EXTERN NSString *_Nonnull const cellKEY;
UIKIT_EXTERN NSString *_Nonnull const isRegisterNibKEY;
UIKIT_EXTERN NSString *_Nonnull const configDicKEY_ConfigModel;
UIKIT_EXTERN NSString *_Nonnull const headerFooterKey;


/** 完全自定义block */
UIKIT_EXTERN NSString *_Nonnull const cCustomBlock;


UIKIT_EXTERN NSString *_Nonnull const cNormalAttTitle;
UIKIT_EXTERN NSString *_Nonnull const cSelectedAttTitle;

UIKIT_EXTERN NSString *_Nonnull const cNormalImage;
UIKIT_EXTERN NSString *_Nonnull const cSelectedImage;
UIKIT_EXTERN NSString *_Nonnull const cNormalBgImage;
UIKIT_EXTERN NSString *_Nonnull const cSelectedBgImage;


UIKIT_EXTERN NSString *_Nonnull const cHighlightedAttTitle;
/** 高亮时候的image */
UIKIT_EXTERN NSString *_Nonnull const cHighlightedImage;
/** 高亮时候的bgImage */
UIKIT_EXTERN NSString *_Nonnull const cHighlightedBgImage;


UIKIT_EXTERN NSString *_Nonnull const cBorderWidth;
UIKIT_EXTERN NSString *_Nonnull const cBorderColor;
UIKIT_EXTERN NSString *_Nonnull const cCornerRadius;


NS_ASSUME_NONNULL_BEGIN

@interface CKJWorker : CKJBaseModel


+ (NSAttributedString *_Nonnull)changeOriginAtt:(nullable NSAttributedString *)origin text:(nullable NSString *)text;

+ (NSBundle *_Nonnull)kjbundle;

@end


@interface CKJCommonItemData : CKJBaseModel

@end


@interface CKJCommonItemView : UIView

@end



/**
 这个类和 CKJBaseBtnsCellItemData 属性什么的都是一样的， 如果修改，记得把另外一个类也同步修改一下
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



@property (copy, nonatomic, nullable) CKJBtnItemBlock callBack;
/**
 对UIButton的图片和文字 进行排布回调
 */
@property (copy, nonatomic, nullable) void (^layout_Button)(UIButton *btn);

/**
 创建多个items对象
 */
+ (NSArray <__kindof CKJBtnItemData *>*_Nonnull)returnItemsWithDics:(NSArray <NSDictionary *>*_Nullable)dics detailSetting:(void(^_Nullable)(__kindof CKJBtnItemData *__weak _Nonnull itemData, NSUInteger index))detailSetting;

@end






@interface NSArray <__covariant ObjectType> (CKJSimpleTableView)


/**
 网络获取Models模型数组 转成 CellModels数组
 
 @param ResponseDataModels 网络模型数组
 @param CellModelClass CellModelClass类（必须是CKJCommonCellModel子类）
 @param callBack 可以详细设置CellModel数据， 比如高度或者其他
 */
+ (instancetype _Nonnull)kjwd_arrayWithResponseDataModels:(NSArray * _Nullable)ResponseDataModels CellModelClass:(Class _Nonnull)CellModelClass callBack:(void(^_Nullable )(id _Nonnull currentModel))callBack;

@end



NS_ASSUME_NONNULL_END
