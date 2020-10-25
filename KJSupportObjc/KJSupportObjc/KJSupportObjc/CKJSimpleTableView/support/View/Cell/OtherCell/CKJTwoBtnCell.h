//
//  CKJTwoBtnCell.h
//  Demo
//
//  Created by admin2 on 2020/3/10.
//  Copyright © 2020 admin2. All rights reserved.
//

#import "CKJCommonTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class CKJTwoBtnCellModel;

//typedef void(^CKJTwoBtnCellClickBtn)(__kindof CKJTwoBtnCellModel *cm, UIButton *btn);

typedef void(^CKJTwoBtnCellBlock)(__kindof CKJTwoBtnCellModel *_Nonnull m);



/*
 

 let leftRight = CKJTwoBtnCellModel.twoBtn(withCellHeight: NSNumber(value: 50), leftTitle: "忘记密码", leftHandle: { [weak self] (btn, data) in
     self?.navigationController?.pushViewController(DMForgetPwdVC())
     }, rightTitle: "注册", rightHandle: { [weak self] (btn, data) in
         self?.navigationController?.pushViewController(DMRegisterVC())
     }, fontSize: nil, textColor: nil, detailSettingBlock: nil)
 
 */
@interface CKJTwoBtnCellModel : CKJCommonCellModel

@property (assign, nonatomic) CGFloat leftMargin;
@property (assign, nonatomic) CGFloat rightMargin;

@property (strong, nonatomic, nullable) CKJBtnItemData *leftBtnData;
@property (strong, nonatomic, nullable) CKJBtnItemData *rightBtnData;

+ (instancetype)twoBtnWithCellHeight:(nullable NSNumber *)cellHeight leftTitle:(nullable NSString *)leftTitle leftHandle:(nullable CKJBtnClick)leftHandle rightTitle:(nullable NSString *)rightTitle rightHandle:(nullable CKJBtnClick)rightHandle fontSize:(nullable NSNumber *)fontSize textColor:(nullable UIColor *)textColor detail:(nullable CKJTwoBtnCellBlock)detail;

@end

@interface CKJTwoBtnCell : CKJCommonTableViewCell //  <CKJTwoBtnCellModel *>

@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) UIButton *rightBtn;

@end

NS_ASSUME_NONNULL_END
