//
//  CKJTableEmptyView.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/26.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJTableEmptyView.h"
#import "NSObject+WDYHFCategory.h"

@implementation CKJTableEmptyViewConfig

+ (nonnull instancetype)configWithDetailSettingBlock:(nullable void(^)(__kindof CKJTableEmptyViewConfig *m))detailSettingBlock {
    return [super configWithDetailSettingBlock:detailSettingBlock];
}


@end



@implementation CKJTableEmptyView

+ (nonnull instancetype)emptyViewWithConfig:(nonnull CKJTableEmptyViewConfig *)config {
    CKJTableEmptyView *view = [[CKJTableEmptyView alloc] init];
    view.config = config;
    [view setupUI];
    return view;
}

- (void)setupUI {
    self.backgroundColor = [UIColor kjwd_r:238 g:238 b:238 alpha:1];

    
    CKJTableEmptyViewConfig *config = self.config;
    
    UIImageView *imageV = [[UIImageView alloc] init];
//    imageV.image = [UIImage imageNamed:@"renji_icon"];
    [self addSubview:imageV];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:15.5];
    label.textColor = [UIColor kjwd_titleColor333333];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
//    label.text = @"请点击下方取号按钮,\n凭号码到入院登记处办理入院手续。";
    [self addSubview:label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
//    [btn setTitle:@"去新品区逛逛" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:btn];
    
    
    [imageV kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.centerX.equalTo(superview);
        make.top.equalTo(@(config.avatar_TopMargin));
        make.size.mas_equalTo(config.avatarSize);
    }];
    
    [label kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.centerX.equalTo(imageV);
        make.top.equalTo(imageV.mas_bottom).offset(config.avatar_MarginToMessage);
        make.width.equalTo(superview).offset(-20);
    }];
    
    [btn kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.centerX.equalTo(imageV);
        make.top.equalTo(label).offset(config.message_MarginToBtn);
    }];
    
    
    self.avatarImageView = imageV;
    self.messageLabel = label;
    self.btn = btn;
    
    
    if (config.uisettingblock) {
        config.uisettingblock(self, imageV, label, btn);
    }
    
    
    BOOL debug = NO;
    if (debug) {
        self.backgroundColor = [UIColor darkGrayColor];
        self.avatarImageView.backgroundColor = [UIColor redColor];
        self.messageLabel.backgroundColor = [UIColor blueColor];
        self.btn.backgroundColor = [UIColor orangeColor];
    }
}

- (void)updateMessage:(nullable id)message {
    if (WDKJ_IsEmpty_AttributedStr(message) == NO) {
        self.messageLabel.attributedText = message;
    } else if (WDKJ_IsEmpty_Str(message) == NO) {
        self.messageLabel.text = message;
    } else {
        self.messageLabel.attributedText = [[NSAttributedString alloc] initWithString:@" "];
        self.messageLabel.text = @" ";
    }
}
- (void)updateImage:(nullable UIImage *)image {
    if (WDKJ_IsNullObj(image, [UIImage class])) {
        self.avatarImageView.image = nil;
    } else {
        self.avatarImageView.image = image;
    }
}



@end
