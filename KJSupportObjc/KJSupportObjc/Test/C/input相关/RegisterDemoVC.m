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
#import "RJInputData.h"

@interface RegisterDemoVC ()

@end

@implementation RegisterDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"CKJInput示例2";
    KJ_typeweakself   
    
    [self.simpleTableView updateStyle:^(CKJSimpleTableViewStyle * _Nonnull style) {
        style.rowHeight = @44;
        style.haveTitleStyle.titleWidth = @55;
    }];
    
    CKJCommonSectionModel *section1 = [CKJCommonSectionModel sectionWithDetail:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        
         
        CKJInputCellModel *name = [self.simpleTableView _newtitle:@"姓名" tfText:@"" placeholder:@"请输入姓名" emptyRequirdText:@"姓名" cellId:kOInput_Name detail:nil];
        CKJInputCellModel *phone = [self.simpleTableView _newtitle:@"手机号" tfText:@"" placeholder:@"请输入手机号" emptyRequirdText:@"手机号" cellId:kOInput_Phone detail:^(__kindof CKJInputCellModel * _Nonnull m) {
            [m addRequired:[CKJInputExpressionRequiredModel system_phoneRegError]];
        }];
        
        _sec.modelArray = @[name, phone];
    }];
    
     self.simpleTableView.dataArr = @[section1];
    
    
    [self createFooterViewWithBtnTitle:@"注册" clickHandle:^(UIButton * _Nonnull sender, RegisterDemoVC *se, CKJSimpleTableView *simpleTableView) {
        
        if ([se.simpleTableView verityInputFail]) return;
        
        [weakSelf.view endEditing:YES];
        
        RJInputData *data = [[RJInputData alloc] initWithSimpleTableView:simpleTableView];
        
        
        NSLog(@"验证通过------发送------注册网络请求------");
    }];
}

- (void)scrollViewWillBeginDragging:(nonnull UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


@end
