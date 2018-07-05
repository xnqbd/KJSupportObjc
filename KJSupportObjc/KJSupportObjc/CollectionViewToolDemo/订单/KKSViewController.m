//
//  KKSViewController.m
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/7/5.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "KKSViewController.h"
#import "ChooseVisitPersonView.h"

@interface KKSViewController ()

@end

@implementation KKSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ChooseVisitPersonView *visitView = [ChooseVisitPersonView instanceUsingAutoNib];
    
    visitView.backgroundColor = [UIColor redColor];
    [self.view addSubview:visitView];
    [visitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@500);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
