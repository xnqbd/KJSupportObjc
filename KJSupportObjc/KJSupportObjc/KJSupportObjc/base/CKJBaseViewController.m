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
    self.view.backgroundColor = [UIColor whiteColor];
    

    if (self.navigationController.viewControllers.count > 1) {
        
        NSBundle *resourcesBundle = [CKJWorker kjbundle];
        UIImage *arrow = [UIImage imageNamed:@"kj_return_white" inBundle:resourcesBundle compatibleWithTraitCollection:nil];
        arrow = [arrow kjwd_scaleToSize:CGSizeMake(30, 30)];
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:arrow style:(UIBarButtonItemStyleDone) target:self action:@selector(popAction:)];
        [backItem setTintColor:[UIColor whiteColor]];
        self.navigationItem.leftBarButtonItem = backItem;
    }
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


- (UIView *)footerViewWithBtnTitle:(NSString *)title clickHandle:(void(^_Nullable)(UIButton * _Nonnull sender))clickHandle {
    
    CGFloat swidth = [UIScreen mainScreen].bounds.size.width;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, swidth, 80)];
    bgView.backgroundColor = [UIColor clearColor];
    
    UIButton *save = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor kjwd_blueBtnColor]];
        [btn setTitle:title forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        [btn kjwd_addTouchUpInsideForCallBack:^(UIButton * _Nonnull sender) {
            if (clickHandle) {
                clickHandle(sender);
            }
        }];
        btn;
    });
    
    [save kjwd_addToSuperView:bgView constraints:^(MASConstraintMaker *make, UIView *superview) {
        make.center.mas_equalTo(superview);
        make.width.equalTo(superview).offset(-40).priority(550);
        make.height.equalTo(@45);
    }];
    return bgView;
}

/// 镂空的
- (UIView *)strokeFooterViewWithBtnTitle:(NSString *)title clickHandle:(void(^_Nullable)(UIButton * _Nonnull sender))clickHandle {
    
    CGFloat swidth = [UIScreen mainScreen].bounds.size.width;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, swidth, 80)];
    bgView.backgroundColor = [UIColor clearColor];
    
    UIButton *save = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor kjwd_blueBtnColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitle:title forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = [UIColor kjwd_blueBtnColor].CGColor;
        btn.layer.borderWidth = 1;
        [btn kjwd_addTouchUpInsideForCallBack:^(UIButton * _Nonnull sender) {
            if (clickHandle) {
                clickHandle(sender);
            }
        }];
        btn;
    });
    
    [save kjwd_addToSuperView:bgView constraints:^(MASConstraintMaker *make, UIView *superview) {
        make.center.mas_equalTo(superview);
        make.width.equalTo(superview).offset(-40).priority(550);
        make.height.equalTo(@45);
    }];
    return bgView;
}


- (void)_set_subViews {
    
}



@end
