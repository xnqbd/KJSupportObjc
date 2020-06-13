//
//  CKJPayCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/7/8.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJImageLeftCell.h"



typedef NS_ENUM(NSUInteger, CKJRadioCellTriggerStyle) {
    /** 点击整个Cell触发 单选事件 */
    CKJRadioCellTriggerStyle_SelectRow,
    /** 点击单选按钮触发 单选事件 */
    CKJRadioCellTriggerStyle_SelectRadioBtn
};




NS_ASSUME_NONNULL_BEGIN

@class CKJPayCellModel;

typedef void(^CKJPayCellRowBlock)(CKJPayCellModel * __weak m);


@interface CKJPayCellConfig : CKJImageLeftCellConfig

@property (strong, nonatomic, nonnull) UIImage *normal_Image;
@property (strong, nonatomic, nonnull) UIImage *selected_Image;

/**
 单选事件触发的方式
 */
@property (assign, nonatomic) CKJRadioCellTriggerStyle triggerStyle;

/**
 选择按钮 右边的距离，默认12
 */
@property (assign, nonatomic) CGFloat radioBtn_rightMargin;

/**
 默认 CGSizeZero
 */
@property (assign, nonatomic) CGSize radioBtnSize;

/**
 本项目 全局样式
 */
+ (nonnull instancetype)appearanceForProject;


@end

@interface CKJPayCellModel : CKJImageLeftCellModel


+ (nonnull instancetype)payWithCellHeight:(nullable NSNumber *)cellHeight cellModel_id:(nullable NSString *)cellModel_id detailSettingBlock:(nullable CKJPayCellRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJPayCellRowBlock)didSelectRowBlock;


@end


@interface CKJPayCell : CKJImageLeftCell


/** 右边选择的按钮 */
@property (weak, nonatomic) UIButton *radioBtn;

@end

NS_ASSUME_NONNULL_END
