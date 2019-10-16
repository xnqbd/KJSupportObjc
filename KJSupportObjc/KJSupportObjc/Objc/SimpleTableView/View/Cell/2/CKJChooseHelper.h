//
//  CKJStringChooseHelper.h
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/9/27.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class CKJStringChooseHelper, CKJStringChooseItem, CKJDateChooseHelper;


typedef void(^CKJChooseBlock)(__weak CKJStringChooseHelper *helper, __kindof CKJStringChooseItem *_Nonnull item, NSInteger selectedIndex);

typedef void(^CKJDateChooseBlock)(__weak CKJDateChooseHelper *helper);


@interface CKJStringChooseItem : CKJBaseModel

@property (strong, nonatomic)   id        takeValue;
@property (copy, nonatomic)     NSString *takeStringValue;


@property (copy, nonatomic)   NSString *content;


+ (nonnull instancetype)itemWithContent:(NSString *_Nonnull)content takeStr:(NSString *_Nonnull)takeStr;

@end



@interface CKJStringChooseHelper : CKJBaseModel

@property (copy, nonatomic) NSString *header;

@property (strong, nonatomic) NSArray <__kindof CKJStringChooseItem *>*chooseItems;


@property (weak, nonatomic) __kindof CKJStringChooseItem *currentSelectedItem;

- (void)showWithSelectedStr:(NSString *_Nonnull)selectedStr origin:(UIView *_Nullable)origin callBack:(CKJChooseBlock _Nonnull)callBack;


+ (nonnull instancetype)helperWithHeader:(NSString *_Nonnull)header items:(NSArray <__kindof CKJStringChooseItem *>*)items detailSetting:(void(^_Nullable)(__kindof CKJStringChooseHelper *_Nonnull helper))detailSetting;

@end




@interface CKJDateChooseHelper : CKJBaseModel

@property (copy, nonatomic) NSString *header;

@property (strong, nonatomic, nullable) NSDate *maxDate;
@property (strong, nonatomic, nullable) NSDate *minDate;
@property (strong, nonatomic, nonnull) NSDate *currentSelectedDate;



- (void)systemConfig;

- (void)showWithOrigin:(UIView *_Nullable)origin callBack:(CKJDateChooseBlock _Nonnull)callBack;

+ (nonnull instancetype)dateHelperWithHeader:(NSString *_Nonnull)header detailSetting:(void(^_Nullable)(__kindof CKJDateChooseHelper *_Nonnull helper))detailSetting;



@end



NS_ASSUME_NONNULL_END
