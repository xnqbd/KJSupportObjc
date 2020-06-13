//
//  CKJInputData.h
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/12/12.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseModel.h"
#import "CKJChooseHelper.h"

@class CKJSimpleTableView;

NS_ASSUME_NONNULL_BEGIN


UIKIT_EXTERN NSString *_Nonnull const kOInput_Name;
UIKIT_EXTERN NSString *_Nonnull const kOInput_Sex;
UIKIT_EXTERN NSString *_Nonnull const kOInput_Phone;
UIKIT_EXTERN NSString *_Nonnull const kOInput_VerityCode;
UIKIT_EXTERN NSString *_Nonnull const kOInput_idCardType;
UIKIT_EXTERN NSString *_Nonnull const kOInput_idCardNumber;
UIKIT_EXTERN NSString *_Nonnull const kOInput_Birthday;
UIKIT_EXTERN NSString *_Nonnull const kOInput_Relationship;
UIKIT_EXTERN NSString *_Nonnull const kOInput_Address;
UIKIT_EXTERN NSString *_Nonnull const kOInput_Email;
UIKIT_EXTERN NSString *_Nonnull const kOInput_Pwd;
UIKIT_EXTERN NSString *_Nonnull const kOInput_ConfirmPwd;


///// 国家
//UIKIT_EXTERN NSString *_Nonnull const kOInput_Country;
//UIKIT_EXTERN NSString *_Nonnull const kOInput_Province;
//UIKIT_EXTERN NSString *_Nonnull const kOInput_City;
///// 民族
//UIKIT_EXTERN NSString *_Nonnull const kOInput_Nation;

/// 特别人 名字
UIKIT_EXTERN NSString *_Nonnull const kOInput_SpecialName;
/// 特别人 手机号
UIKIT_EXTERN NSString *_Nonnull const kOInput_SpecialPhone;
/// 特别人 证件类型
UIKIT_EXTERN NSString *_Nonnull const kOInput_SpecialIdCardType;
/// 特别人 证件号
UIKIT_EXTERN NSString *_Nonnull const kOInput_SpecialIdCardNumber;



@interface CKJInputData : CKJBaseModel


@property (copy, nonatomic, nullable) NSString *name;
@property (copy, nonatomic, nullable) NSString *phone;
@property (copy, nonatomic, nullable) NSString *verityCode;
@property (copy, nonatomic, nullable) NSString *idCardNumber;
@property (copy, nonatomic, nullable) NSString *address;
@property (copy, nonatomic, nullable) NSString *email;
@property (copy, nonatomic, nullable) NSString *pwd;
@property (copy, nonatomic, nullable) NSString *confirmPwd;

//@property (copy, nonatomic, nullable) NSString *country;
//@property (copy, nonatomic, nullable) NSString *province;
//@property (copy, nonatomic, nullable) NSString *city;
//@property (copy, nonatomic, nullable) NSString *nation;

@property (copy, nonatomic, nullable) NSString *specialName;
@property (copy, nonatomic, nullable) NSString *specialPhone;
@property (copy, nonatomic, nullable) CKJStringChooseItem *specialIdCardType;
@property (copy, nonatomic, nullable) NSString *specialIdCardNumber;


@property (strong, nonatomic, nullable) CKJStringChooseItem *sex;
@property (strong, nonatomic, nullable) CKJStringChooseItem *idCardType;
@property (strong, nonatomic, nullable) CKJStringChooseItem *relationship;

@property (strong, nonatomic, nullable) NSDate *birthday;


- (instancetype)initWithSimpleTableView:(CKJSimpleTableView *)simpleTableView;

@end

NS_ASSUME_NONNULL_END
