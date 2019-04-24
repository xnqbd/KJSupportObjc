//
//  CKJPayCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/3/24.
//  Copyright © 2019年 Lyc. All rights reserved.
//

#import "CKJFiveCell.h"

@class CKJRadioCellConfig;


typedef void(^CKJRadioCellConfigBlock)(CKJRadioCellConfig *_Nonnull m);


/*
 实例
 
 NSStringFromClass([CKJRadioCellModel class]) : @{cellKEY : NSStringFromClass([CKJRadioCell class]), isRegisterNibKEY : @NO, configDicKEY_ConfigModel : radioConfig},

 
 CKJRadioCellConfig *radioConfig = [CKJRadioCellConfig configWithDetailSettingBlock:^(CKJRadioCellConfig * _Nonnull m) {
 // 下面这注释的设置了默认值， 修改修改的话可以自己设置
 //        m.leftImageView_MarginToSuperViewLeft = 15;
 //        m.leftImageSize = CGSizeMake(30, 30);
 //        m.image_margin_title = 12;
 //        m.title_margin_subTitle = 7;
 
 //        m.radioBtn_leftMargin = 5;
 //        m.radioBtn_rightMargin = 15;
 
 CGSize size = CGSizeMake(22, 22);
 
 m.normal_Image = [[UIImage kjwd_imageNamed:@"wdyhfsdk勾选空"] kjwd_scaleToSize:size];
 m.selected_Image = [[UIImage kjwd_imageNamed:@"wdyhfsdk勾选"] kjwd_scaleToSize:size];
 m.radioBtnSize = CGSizeMake(50, 44);
 
 // m.triggerStyle = CKJRadioCellTriggerStyle_SelectRadioBtn;
 }];
 
 
 */



typedef NS_ENUM(NSUInteger, CKJRadioCellTriggerStyle) {
    /** 点击整个Cell触发 单选事件 */
    CKJRadioCellTriggerStyle_SelectRow,
    /** 点击单选按钮触发 单选事件 */
    CKJRadioCellTriggerStyle_SelectRadioBtn
};



@interface CKJRadioCellConfig : CKJFiveCellConfig

@property (strong, nonatomic, nonnull) UIImage *normal_Image;
@property (strong, nonatomic, nonnull) UIImage *selected_Image;

/**
 单选事件触发的方式
 */
@property (assign, nonatomic) CKJRadioCellTriggerStyle triggerStyle;

/**
 选择按钮 右边的距离，默认15
 */
@property (assign, nonatomic) CGFloat radioBtn_rightMargin;
/**
 选择按钮 左边的距离，默认5
 */
@property (assign, nonatomic) CGFloat radioBtn_leftMargin;

/**
 默认 CGSizeZero
 */
@property (assign, nonatomic) CGSize radioBtnSize;

+ (nonnull instancetype)configWithDetailSettingBlock:(nullable CKJRadioCellConfigBlock)detailSettingBlock;


@end



@interface CKJRadioCellModel : CKJFiveCellModel

/**
 推荐设置外面自定义的枚举，默认是一个216372值，这个是我随便写的，反正不是0，1，2这样的常见值
 */
@property (assign, nonatomic) NSInteger kj_enumValue;

@end


@interface CKJRadioCell : CKJFiveCell


@end


