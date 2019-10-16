//
//  RJRegisterAccountVC.m
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/10/15.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "RegisterDemoVC.h"

@interface RegisterDemoVC ()

@end

@implementation RegisterDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册账户";
    
    void(^block)(CKJInputCellModel *m) = ^(CKJInputCellModel *m){
        m.title3Model = [CKJTitle3Model title3ModelWithAttributedText:WDAtt15_5(nil) left:10];
        m.selectionStyle = UITableViewCellSelectionStyleNone;
    };
    
    CKJCommonSectionModel *section1 = [CKJCommonSectionModel sectionWithFooterHeight:10 detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull sec) {
        sec.rowHeight = 44;
        CKJInputCellModel *model1 = [CKJInputCellModel modelWithCellHeight:0 cellModel_id:@(kInput_Name) detailSettingBlock:^(__kindof CKJInputCellModel * _Nonnull m) {   block(m);
            [m updateTFModel:^(CKJTFModel * _Nonnull tfModel) {
                [tfModel _setPlaceholder:@"请输入真实姓名"];
            }];
        } didSelectRowBlock:nil];
        CKJInputCellModel *model2 = [CKJInputCellModel modelWithCellHeight:0 cellModel_id:@(kInput_Phone) detailSettingBlock:^(__kindof CKJInputCellModel * _Nonnull m) {   block(m);
            [m updateTFModel:^(CKJTFModel * _Nonnull tfModel) {
                [tfModel _setPlaceholder:@"请输入手机号"];
                tfModel.keyboardType = UIKeyboardTypePhonePad;
            }];
        } didSelectRowBlock:nil];
        CKJInputCellModel *model3 = [CKJInputCellModel modelWithCellHeight:0 cellModel_id:@(kInput_VerityCode) detailSettingBlock:^(__kindof CKJInputCellModel * _Nonnull m) {  block(m);
            [m updateTFModel:^(CKJTFModel * _Nonnull tfModel) {
                [tfModel _setPlaceholder:@"请输入短信验证码"];
                tfModel.keyboardType = UIKeyboardTypeNumberPad;
            }];
            
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
        
        sec.modelArray = @[model1, model2, model3];
    }];
    self.simpleTableView.dataArr = @[section1];
    
    [self createFooterView];
}

- (void)createFooterView {
    
    CGFloat swidth = [UIScreen mainScreen].bounds.size.width;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, swidth, 80)];
    bgView.backgroundColor = [UIColor clearColor];
    
    UIButton *save = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor kjwd_blueBtnColor]];
        [btn setTitle:@"注册" forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    
    [bgView addSubview:save];
    
    [save mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(bgView);
        make.width.equalTo(bgView).offset(-40).priority(550);
        make.height.equalTo(@45);
    }];
    self.simpleTableView.tableFooterView = bgView;
}

- (void)scrollViewWillBeginDragging:(nonnull UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
// 点击 注册
- (void)registerAction {
    
    // 姓名
    NSString *_name = [self.simpleTableView inputCellModelOfID:kInput_Name].tfText;
    
    // 手机号
    NSString *_phone = [self.simpleTableView inputCellModelOfID:kInput_Phone].tfText;
    
    // 验证码
    NSString *_verityCode = [self.simpleTableView inputCellModelOfID:kInput_VerityCode].tfText;


    if (WDKJ_IsEmpty_Str(_name)) {
        [MBProgressHUD showError:@"姓名不能为空" toView:self.view];
        return;
    }
    if (![CKJTFModel verityPhone:_phone]) {
        [MBProgressHUD showError:@"手机号为空或有误"];
        return;
    }
    if (WDKJ_IsEmpty_Str(_verityCode)) {
        [MBProgressHUD showError:@"验证码不能为空" toView:self.view];
        return;
    }
    NSLog(@"发送------注册网络请求------");
}

@end
