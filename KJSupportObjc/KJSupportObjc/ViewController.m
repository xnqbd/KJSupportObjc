//
//  ViewController.m
//  KJSupportObjc
//
//  Created by uback on 2018/5/3.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "ViewController.h"
#import "RJTestListVC.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [IQKeyboardManager sharedManager].enable = YES;

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}

- (IBAction)enterSettingAction:(UIButton *)sender {
    [self.navigationController pushViewController:[RJTestListVC new] animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end
