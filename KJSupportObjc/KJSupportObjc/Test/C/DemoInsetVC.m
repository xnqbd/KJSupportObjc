//
//  DemoInsetVC.m
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/12/16.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "DemoInsetVC.h"

@interface DemoInsetVC ()

@end

@implementation DemoInsetVC


- (UITableViewStyle)simpleTableViewStyle {
    return UITableViewStylePlain;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"注册";
    
    self.simpleTableView.scrollEnabled = NO;
    [self.simpleTableView updateStyle:^(CKJSimpleTableViewStyle * _Nonnull style) {
        style.rowHeight = @44;
        style.haveTitleStyle.titleWidth = @65;
        style.sectionCornerStyle = [[CKJSectionCornerStyle alloc] init];
    }];
    
    KJ_typeweakself
    
    CKJCommonSectionModel *section1 = [CKJCommonSectionModel sectionWithDetail:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        
        CKJInputCellModel *name = [self.simpleTableView _newtitle:@"姓名" tfText:@"" placeholder:@"请输入家长真实姓名" emptyRequirdText:@"姓名" cellId:kOInput_Name detail:nil];
        
        CKJInputCellModel *phone = [self.simpleTableView _newtitle:@"手机号" tfText:@"" placeholder:@"请输入手机号" emptyRequirdText:@"手机号" cellId:kOInput_Phone detail:^(__kindof CKJInputCellModel * _Nonnull m) {
            [m addRequired:[CKJInputExpressionRequiredModel system_phoneRegError]];
        }];
        
        CKJInputCellModel *code = [self.simpleTableView _newtitle:@"验证码" tfText:@"" placeholder:@"请输入验证码" emptyRequirdText:@"验证码" cellId:kOInput_VerityCode detail:^(__kindof CKJInputCellModel * _Nonnull m) {
            [m addRequired:[CKJInputExpressionRequiredModel system_verityCodeLengthError]];
            // 注意：一定要设置 手机号的cellId 为 kOInput_Phone，不然无法发送验证码
            m.getCodeModel = [CKJGetCodeModel modelWithClickCodeBtnBlock:^(CKJTriggerCodeBlock  _Nonnull triggerCodeBlock) {
                
                //                // 手机号
                //                NSString *_phone = [weakSelf.simpleTableView inputCellModelOfID:kOInput_Phone].getTfText;
                //
                //
                //                [RJCombineHttpRequest getPhoneSmsCodeWithPhoneNum:_phone BusinessId:@"EditAccountMobile" animated:YES SuccessBlock:^(id responseObject) {
                //                    triggerCodeBlock(60); // 触发定时器
                //                    [[weakSelf.simpleTableView inputCellModelOfID:kOInput_VerityCode].tfModel.readOnly_currentTF becomeFirstResponder];
                //
                //                } failureBlock:^(NSError *error) {
                //                    if (error.localizedDescription) {
                //                        [MBProgressHUD showError:error.localizedDescription];
                //                    }
                //                }];
            } detailSettingBlock:nil];
        }];
        
        

        CKJInputCellModel *pwd = [self.simpleTableView _newtitle:@"密码" tfText:@"" placeholder:@"请输入密码" emptyRequirdText:@"密码" cellId:kOInput_Pwd detail:nil];
        
        
        CKJInputCellModel *confirmPwd = [self.simpleTableView _newtitle:@"确认密码" tfText:@"" placeholder:@"请再次输入密码" emptyRequirdText:@"确认密码" cellId:kOInput_ConfirmPwd detail:^(__kindof CKJInputCellModel * _Nonnull m) {
            [m addRequired:[CKJInputExpressionRequiredModel system_confirmPwdNotEqualPwdWithTableView:self.simpleTableView]];
        }];
        
        
        _sec.modelArray = @[name, phone, code, pwd, confirmPwd];
    }];
    
    self.simpleTableView.dataArr = @[section1];
    
    
    [self createFooterViewWithBtnTitle:@"注册" clickHandle:^(UIButton * _Nonnull sender, DemoInsetVC *se, CKJSimpleTableView *simpleTableView) {
        
        if ([se.simpleTableView verityInputFail]) return;
        
        [weakSelf.view endEditing:YES];
        
        // 手机号
        NSString *_phone = [weakSelf.simpleTableView inputCellModelOfID:kOInput_Phone].getTfText;
        
        
        
        NSLog(@"验证通过------发送------注册网络请求------");
    }];
}

- (void)scrollViewWillBeginDragging:(nonnull UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (void)layoutTableViewFrame:(CKJSimpleTableView *)tableV {
    [tableV kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(superview).offset(30);
        make.centerX.equalTo(superview);
        make.top.equalTo(superview.kjwdMas_safeAreaTop).offset(20);
        make.height.equalTo(@400);
    }];
}

@end
