//
//  RJRegisterAccountVC.m
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/10/15.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "RegisterDemoVC.h"
#import "MBProgressHUD+WJ.h"
#import "RJCustomInputCell.h"

@interface RegisterDemoVC ()

@end

@implementation RegisterDemoVC

- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues:(CKJSimpleTableView *_Nonnull)s {
    return @{
        NSStringFromClass([RJCustomInputCellModel class]) : @{cellKEY : NSStringFromClass([RJCustomInputCell class]), isRegisterNibKEY : @YES}
        
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"CKJInput示例2";
    
    CKJCommonSectionModel *section1 = [CKJCommonSectionModel sectionWithFooterHeight:10 detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull sec) {
        sec.rowHeight = 44;
        CKJInputCellModel *name = [CKJInputCellModel modelWithCellHeight:0 cellModel_id:@(kInput_Name) detailSettingBlock:^(__kindof CKJInputCellModel * _Nonnull m) {   self.input_block1(m, WDKJ_ER(@"姓名"));
            [m updateTFModel:^(CKJTFModel * _Nonnull tfModel) {
                [tfModel _setPlaceholder:@"请输入姓名"];
            }];
        } didSelectRowBlock:nil];
        CKJInputCellModel *phone = [CKJInputCellModel modelWithCellHeight:0 cellModel_id:@(kInput_Phone) detailSettingBlock:^(__kindof CKJInputCellModel * _Nonnull m) {   self.input_block1(m, WDKJ_ER(@"手机号"));
            [m updateTFModel:^(CKJTFModel * _Nonnull tfModel) {
                [tfModel _setPlaceholder:@"请输入手机号"];
                tfModel.keyboardType = UIKeyboardTypePhonePad;
            }];
            [m addRequired:[CKJInputExpressionRequiredModel modelWithRequiredText:@"手机号格式错误" failExpression:^BOOL(NSAttributedString * _Nonnull attText, CKJInputCellModel * _Nonnull cm) {
                return [attText.string kjwd_varityPhoneFail];
            }]];
        } didSelectRowBlock:nil];
        CKJInputCellModel *model3 = [CKJInputCellModel modelWithCellHeight:0 cellModel_id:@(kInput_VerityCode) detailSettingBlock:^(__kindof CKJInputCellModel * _Nonnull m) {  self.input_block1(m, WDKJ_ER(@"验证码"));
            [m updateTFModel:^(CKJTFModel * _Nonnull tfModel) {
                [tfModel _setPlaceholder:@"请输入短信验证码"];
                tfModel.keyboardType = UIKeyboardTypeNumberPad;
            }];
            [m addRequired:[CKJInputExpressionRequiredModel modelWithRequiredText:@"验证码必须是6位" failExpression:^BOOL(NSAttributedString * _Nonnull attText, CKJInputCellModel * _Nonnull cm) {
                return attText.string.length != 6;
            }]];
            // 注意：一定要设置 手机号的cellId 为 kInput_Phone，不然无法发送验证码
            m.getCodeModel = [CKJGetCodeModel modelWithClickCodeBtnBlock:^(CKJTriggerCodeBlock  _Nonnull triggerCodeBlock) {
                
                triggerCodeBlock(15); // 触发定时器，这里可以写 发送验证码网络请求
                NSLog(@"发送------获取验证码网络请求------");
            } detailSettingBlock:^(__kindof CKJGetCodeModel * _Nonnull m) {
                m.codeBtnWidth = 110;
                m.countDownChanging = ^NSString * _Nonnull(CKJCountDownButton * _Nonnull countDownButton, NSUInteger second) {
                    return [NSString stringWithFormat:@"还有%lu秒", second];
                };
                m.countDownFinished = ^NSString * _Nonnull(CKJCountDownButton * _Nonnull countDownButton, NSUInteger second) {
                    countDownButton.enabled = YES; // 一定要设置这个，让按钮可用
                    return @"重新发送";
                };
            }];
        } didSelectRowBlock:nil];
        
        RJCustomInputCellModel *model4 = [RJCustomInputCellModel modelWithCellHeight:50 cellModel_id:nil detailSettingBlock:^(RJCustomInputCellModel * _Nonnull m) {
            [m updateTFModel:^(CKJTFModel * _Nonnull tfModel) {
                [tfModel _setPlaceholder:@"请输入新手机号"];
                tfModel.keyboardType = UIKeyboardTypeNumberPad;
                tfModel.textAlignment = NSTextAlignmentRight;
            }];
            [m addRequired:WDKJ_ER(@"新手机号")];
            [m addRequired:[CKJInputExpressionRequiredModel modelWithRequiredText:@"新手机格式不正确" failExpression:^BOOL(NSAttributedString * _Nonnull attText, __kindof CKJCommonCellModel * _Nonnull cm) {
                return [attText.string kjwd_varityPhoneFail];
            }]];
        } didSelectRowBlock:nil];
        
        
        sec.modelArray = @[name, phone, model3];
    }];
    self.simpleTableView.dataArr = @[section1];
    
    [self createFooterViewWithBtnTitle:@"注册" clickHandle:^(UIButton * _Nonnull sender, RegisterDemoVC *se, CKJSimpleTableView *simpleTableView) {

        if ([se.simpleTableView verityInputFail]) return;
        
        // 姓名
        NSString *_name = [self.simpleTableView inputCellModelOfID:kInput_Name].tfText;
        
        // 手机号
        NSString *_phone = [self.simpleTableView inputCellModelOfID:kInput_Phone].tfText;
        
        // 验证码
        NSString *_verityCode = [self.simpleTableView inputCellModelOfID:kInput_VerityCode].tfText;

        NSLog(@"验证通过------发送------注册网络请求------");
    }];
}

- (void)scrollViewWillBeginDragging:(nonnull UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

@end
