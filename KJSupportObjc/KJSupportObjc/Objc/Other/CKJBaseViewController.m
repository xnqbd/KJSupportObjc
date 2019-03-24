//
//  CKJBaseViewController.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/2/28.
//  Copyright © 2019年 Lyc. All rights reserved.
//

#import "CKJBaseViewController.h"
#import <Masonry/Masonry.h>
#import "NSObject+WDYHFCategory.h"

@interface CKJWrapperBackgroundView : UIView

@end

@implementation CKJWrapperBackgroundView

@end

@interface CKJBaseViewController ()

@end

@implementation CKJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.alert) {
        [self.alert dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)popAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)firstNetwork {
}
- (void)reloadUI {
}
- (void)clearCache {
}
- (void)kj_addNotification {
    
}
- (void)kj_removeNotification {
    
}
- (void)installComplementData {
    
}

@end
