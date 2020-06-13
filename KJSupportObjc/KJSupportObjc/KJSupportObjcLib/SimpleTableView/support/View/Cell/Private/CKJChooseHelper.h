//
//  CKJStringChooseHelper.h
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/9/27.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseModel.h"
#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSInteger, CKJChooseGeneralEnum) {
//    CKJENUM_Sex = 0,
//    CKJENUM_RelationShip,
//    CKJENUM_IDCardType,
//};


NS_ASSUME_NONNULL_BEGIN


/// 这个id : CKJChooseContent对象
@interface CKJChooseContent : CKJBaseModel

@property (copy, nonatomic) NSString *text;
@property (copy, nonatomic) NSString *imageName;

+ (instancetype)contentWithText:(NSString *)text detail:(void(^_Nullable)(__kindof CKJChooseContent *cc))detail;

@end




@class CKJStringChooseHelper, CKJStringChooseItem, CKJDateChooseHelper;


typedef void(^CKJChooseBlock)(__weak CKJStringChooseHelper *helper, __kindof CKJStringChooseItem *_Nonnull item, NSInteger selectedIndex);

typedef void(^CKJDateChooseBlock)(__weak CKJDateChooseHelper *helper);


@interface CKJStringChooseItem : CKJBaseModel


@property (copy, nonatomic)     NSString *_id;

@property (strong, nonatomic) CKJChooseContent *content;


/// _id和text都必须是唯一的
+ (instancetype)itemWithID:(NSString *)_id text:(NSString *)text;

+ (instancetype)itemWithID:(NSString *)_id contentModel:(CKJChooseContent *)contentModel;


@end



@interface CKJStringChooseHelper : CKJBaseModel

@property (copy, nonatomic) NSString *header;

@property (strong, nonatomic) NSArray <__kindof CKJStringChooseItem *>*chooseItems;



/// 建议最后读取的时候使用这个值
- (__kindof CKJStringChooseItem *)currentSelectedItem;

@property (copy, nonatomic) NSString *currentSelectedStr;

- (void)showWithSelectedStr:(NSString *_Nullable)selectedStr origin:(UIView *_Nullable)origin callBack:(CKJChooseBlock)callBack;


+ (nonnull instancetype)helperWithHeader:(NSString *_Nonnull)header items:(NSArray <__kindof CKJStringChooseItem *>*)items detailSetting:(void(^_Nullable)(__kindof CKJStringChooseHelper *_Nonnull helper))detailSetting;

@end




@interface CKJDateChooseHelper : CKJBaseModel

@property (copy, nonatomic) NSString *header;
@property (copy, nonatomic) NSString *format;

@property (strong, nonatomic, nullable) NSDate *maxDate;
@property (strong, nonatomic, nullable) NSDate *minDate;
@property (strong, nonatomic, nonnull) NSDate *currentSelectedDate;



- (void)systemConfig;

- (void)showWithOrigin:(UIView *_Nullable)origin callBack:(CKJDateChooseBlock _Nonnull)callBack;

+ (nonnull instancetype)dateHelperWithHeader:(NSString *_Nonnull)header format:(NSString *_Nullable)format detailSetting:(void(^_Nullable)(__kindof CKJDateChooseHelper *_Nonnull helper))detailSetting;

/// 更新当前日期
/// @param str 可以传入2020-09-22这样的字符串
- (void)updateCurrentSelectedDateWithDateStr:(NSString *)str;


@end



NS_ASSUME_NONNULL_END
