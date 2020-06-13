//
//  CKJInputData.m
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/12/12.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJInputData.h"
#import "CKJSimpleTableView.h"


NSString *_Nonnull const kOInput_Name = @"kOInput_Name";
NSString *_Nonnull const kOInput_Sex = @"kOInput_Sex";
NSString *_Nonnull const kOInput_Phone = @"kOInput_Phone";
NSString *_Nonnull const kOInput_VerityCode = @"kOInput_VerityCode";
NSString *_Nonnull const kOInput_idCardType = @"kOInput_idCardType";
NSString *_Nonnull const kOInput_idCardNumber = @"kOInput_idCardNumber";
NSString *_Nonnull const kOInput_Birthday = @"kOInput_Birthday";
NSString *_Nonnull const kOInput_Relationship = @"kOInput_Relationship";
NSString *_Nonnull const kOInput_Address = @"kOInput_Address";
NSString *_Nonnull const kOInput_Email = @"kOInput_Email";
NSString *_Nonnull const kOInput_Pwd = @"kOInput_Pwd";
NSString *_Nonnull const kOInput_ConfirmPwd = @"kOInput_ConfirmPwd";

///// 国家
//NSString *_Nonnull const kOInput_Country  = @"kOInput_Country";
//NSString *_Nonnull const kOInput_Province = @"kOInput_Province";
//NSString *_Nonnull const kOInput_City     = @"kOInput_City";
///// 民族
//NSString *_Nonnull const kOInput_Nation   = @"kOInput_Nation";


/// 特别人 名字
NSString *_Nonnull const kOInput_SpecialName = @"kOInput_SpecialName";
/// 特别人 手机号
NSString *_Nonnull const kOInput_SpecialPhone = @"kOInput_SpecialPhone";
/// 特别人 证件类型
NSString *_Nonnull const kOInput_SpecialIdCardType = @"kOInput_SpecialIdCardType";
/// 特别人 证件号
NSString *_Nonnull const kOInput_SpecialIdCardNumber = @"kOInput_SpecialIdCardNumber";




@implementation CKJInputData

- (instancetype)initWithSimpleTableView:(CKJSimpleTableView *)simpleTableView {
    
    // 姓名
    NSString *_name = [simpleTableView inputCellModelOfID:kOInput_Name].getTfText;
    
    // 性别
    CKJStringChooseItem *_sex = [simpleTableView inputCellModelOfID:kOInput_Sex].stringChoose.currentSelectedItem;
    
    // 手机号
    NSString *_phone = [simpleTableView inputCellModelOfID:kOInput_Phone].getTfText;
    
    // 验证码
    NSString *_verityCode = [simpleTableView inputCellModelOfID:kOInput_VerityCode].getTfText;
    
    // 证件类型
    CKJStringChooseItem *_idCardType = [simpleTableView inputCellModelOfID:kOInput_idCardType].stringChoose.currentSelectedItem;
    
    // 证件号
    NSString *_idCardNumber = [simpleTableView inputCellModelOfID:kOInput_idCardNumber].getTfText;
    
    // 出生日期
    NSDate *_birthday = [simpleTableView inputCellModelOfID:kOInput_Birthday].dateChoose.currentSelectedDate;
    
    // 关系
    CKJStringChooseItem *_relationShip = [simpleTableView inputCellModelOfID:kOInput_Relationship].stringChoose.currentSelectedItem;
    
    // 地址
    NSString *_address = [simpleTableView inputCellModelOfID:kOInput_Address].getTfText;
    
    // 邮箱
    NSString *_email = [simpleTableView inputCellModelOfID:kOInput_Email].getTfText;
    
    // 密码
    NSString *_pwd = [simpleTableView inputCellModelOfID:kOInput_Pwd].getTfText;
    
    // 确认密码
    NSString *_confirmPwd = [simpleTableView inputCellModelOfID:kOInput_ConfirmPwd].getTfText;
    
    

    NSString *_specialName = [simpleTableView inputCellModelOfID:kOInput_SpecialName].getTfText;
    
    NSString *_specialPhone = [simpleTableView inputCellModelOfID:kOInput_SpecialPhone].getTfText;

    CKJStringChooseItem *_specialIdCardType = [simpleTableView inputCellModelOfID:kOInput_SpecialIdCardType].stringChoose.currentSelectedItem;
    
    NSString *_specialIdCardNumber = [simpleTableView inputCellModelOfID:kOInput_SpecialIdCardNumber].getTfText;

    
    self.name = _name;
    self.phone = _phone;
    self.verityCode = _verityCode;
    self.idCardNumber = _idCardNumber;
    self.birthday = _birthday;
    self.address = _address;
    self.email = _email;
    self.pwd = _pwd;
    self.confirmPwd = _confirmPwd;
    
    self.sex = _sex;
    self.idCardType = _idCardType;
    self.relationship = _relationShip;
    
    self.specialName = _specialName;
    self.specialPhone = _specialPhone;
    self.specialIdCardType = _specialIdCardType;
    self.specialIdCardNumber = _specialIdCardNumber;
    
    return self;
}

@end
