//
//  CKJPayBottomView.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/17.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJPayBottomView.h"
#import "NSObject+WDYHFCategory.h"

@implementation CKJPayBottomViewConfig

- (instancetype)init {
    if (self = [super init]) {
        self.priceLab_leftMargin = 15;
        self.confimBtn_width = 100;
        self.priceWrapperColor = [UIColor whiteColor];
        self.showTopLine = YES;
    }
    return self;
}

+ (nonnull instancetype)configWithDetailSetting:(void(^_Nullable)(CKJPayBottomViewConfig *_Nonnull m))detailSetting {
    CKJPayBottomViewConfig *config = [[CKJPayBottomViewConfig alloc] init];
    if (detailSetting) {
        detailSetting(config);
    }
    return config;
}

@end


@interface CKJPayBottomView ()


@property (copy, nonatomic) NSString *realValue;

@end


@implementation CKJPayBottomView

+ (nonnull instancetype)bottomViewWithConfirmBtnSetting:(void(^_Nullable)(UIButton *confirmBtn))confirmBtnBlock config:(nonnull CKJPayBottomViewConfig *)config delegate:(__weak id<CKJPayBottomViewDelegate>)delegate {

    CKJPayBottomView *view = [[CKJPayBottomView alloc] init];
    
    
    UIView *wrapper = ({
        UIView *temp = [[UIView alloc] init];
        [view addSubview:temp];
        
        [temp kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
            make.edges.equalTo(superview);
        }];
        temp;
    });
    
    UIView *topLine = ({
        UIView *temp = [[UIView alloc] init];
        temp.backgroundColor = [UIColor groupTableViewBackgroundColor];
        temp.hidden = !config.showTopLine;
        [wrapper addSubview:temp];
        
        [temp kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
            make.left.top.right.equalTo(superview);
            make.height.equalTo(@1);
        }];
        temp;
    });
    
    
    
    UIButton *confirm = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor kjwd_r:25 g:130 b:197 alpha:1];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        
        __weak CKJPayBottomView *weakView = view;
        [btn kjwd_addTouchUpInsideForCallBack:^(UIButton * _Nonnull sender) {
            if ([delegate respondsToSelector:@selector(bottomViewBtnActionWithRealValue:view:)]) {
                [delegate bottomViewBtnActionWithRealValue:weakView.realValue view:weakView];
            }
        }];
        [wrapper addSubview:btn];
        [btn kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
            make.right.equalTo(superview).offset(-(config.confimBtn_rightMargin));
            make.top.equalTo(topLine);
            make.bottom.equalTo(superview);
            make.width.equalTo(@((config.confimBtn_width)));
        }];
        btn;
    });
    
    
    UIView *priceWrapper = ({
        UIView *temp = [[UIView alloc] init];
        temp.backgroundColor = config.priceWrapperColor;
        [wrapper addSubview:temp];
        [temp kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
            make.left.bottom.equalTo(superview);
            make.top.equalTo(topLine.mas_bottom);
            make.right.equalTo(confirm.mas_left);
        }];
        temp;
    });
    
    
    UILabel *priceLab = [UILabel kjwd_labelWithText:nil fontSize:@15 color:[UIColor whiteColor]];
    [priceWrapper addSubview:priceLab];
    [priceLab kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(superview).offset(config.priceLab_leftMargin);
        make.centerY.equalTo(superview);
    }];
    

    
    if (confirmBtnBlock) {
        confirmBtnBlock(confirm);
    }
    view.priceLab = priceLab;
    view.confimBtn = confirm;
    
    
    return view;
}


- (void)changePriceText:(nullable NSAttributedString *)displayText realValue:(nullable NSString *)realValue {
    self.realValue = realValue;
    self.priceLab.attributedText = WDKJ_ConfirmAttString(displayText);
}


@end
