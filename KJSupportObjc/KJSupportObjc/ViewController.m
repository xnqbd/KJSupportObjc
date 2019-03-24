//
//  ViewController.m
//  KJSupportObjc
//
//  Created by uback on 2018/5/3.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "ViewController.h"
#import "RJSettingViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}

- (IBAction)enterSettingAction:(UIButton *)sender {
    [self.navigationController pushViewController:[RJSettingViewController new] animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end
