//
//  CKJInputCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/13.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJCell.h"

typedef void(^CKJTriggerCodeBlock)(NSUInteger seconds);

NS_ASSUME_NONNULL_BEGIN


#define kInput_Name         3673620
#define kInput_Sex          4021728
#define kInput_Phone        5025618
#define kInput_VerityCode   6032293

@class CKJInputCellModel, CKJTFModel;


typedef void(^CKJInputCellModelRowBlock)(__kindof CKJInputCellModel *_Nonnull m);



@interface CKJTFModel : CKJBaseModel

/**
 右边的距离, 默认值15
 */
@property (assign, nonatomic) CGFloat rightMargin;

@property (assign, nonatomic) BOOL userInteractionEnabled;

@property(nonatomic)        UITextBorderStyle       borderStyle;
@property(nonatomic)        UIKeyboardType keyboardType;

@property(nullable, copy, nonatomic) NSString *text;
@property(nullable, nonatomic,copy) NSAttributedString *attributedText;

@property(nullable, copy, nonatomic) NSString *placeholder;
@property(nullable, nonatomic,copy) NSAttributedString *attributedPlaceholder;
@property(nonatomic) NSTextAlignment textAlignment;

+ (nonnull instancetype)modelWithDetailSettingBlock:(void(^)(__kindof CKJTFModel *_Nonnull m))detailSettingBlock;

@end



@interface CKJGetCodeModel : CKJBaseModel


/**
 右边的距离, 默认值15
 */
@property (assign, nonatomic) CGFloat rightMargin;

/**
 获取验证码Btn的宽度, 有默认值
 */
@property (assign, nonatomic) CGFloat codeBtnWidth;


/**
 秒数正在减少的 文字, 有默认值
 */
@property (copy, nonatomic) NSString *(^countDownChanging)(CKJCountDownButton *countDownButton, NSUInteger second);

/**
 秒数正在减少的 文字, 有默认值
 */
@property (copy, nonatomic) NSString *(^countDownFinished)(CKJCountDownButton *countDownButton, NSUInteger second);

/**
 点击了验证码Block
 */
@property (copy, nonatomic, nonnull) void (^clickCodeBlock)(_Nonnull CKJTriggerCodeBlock triggerCodeBlock);


+ (nonnull instancetype)modelWithClickCodeBtnBlock:(void (^)(_Nonnull CKJTriggerCodeBlock triggerCodeBlock))clickCodeBlock detailSettingBlock:(void(^)(__kindof CKJGetCodeModel *_Nonnull m))detailSettingBlock;


@end



@interface CKJInputCellModel : CKJCellModel



/**
 推荐设置外面自定义的枚举
 */
@property (assign, nonatomic) NSInteger kj_enumValue;


@property (strong, nonatomic) CKJTFModel *tfModel;

@property (strong, nonatomic, nullable) CKJGetCodeModel *getCodeModel;

+ (nonnull instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJInputCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJInputCellModelRowBlock)didSelectRowBlock;

@end


@interface CKJInputCell : CKJCell



@end

NS_ASSUME_NONNULL_END
