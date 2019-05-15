//
//  CKJStackCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/14.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJStackCell.h"


@implementation CKJStackCellConfig

@end

@implementation CKJStackCellModel

- (instancetype)init {
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end

@implementation CKJStackCell


- (void)setupSubViews {
    
    CKJStackCellConfig *config = self.configDic[configDicKEY_ConfigModel];
    
    CGFloat v_stackViewSpacing = config.v_stackViewSpacing;
    
    NSArray <NSArray <CKJFuncModel *>*>*data = config.data;
    
    UIStackView *onlyStackV = [[UIStackView alloc] init];
    onlyStackV.spacing = v_stackViewSpacing;
    onlyStackV.axis = UILayoutConstraintAxisVertical;
    onlyStackV.distribution = UIStackViewDistributionFillEqually;
    onlyStackV.alignment = UIStackViewAlignmentFill;
    [self.bgV addSubview:onlyStackV];
    [onlyStackV kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.edges.equalTo(superview).insets(config.edge);
    }];
    
    
    for (int i = 0; i < data.count; i++) {
        NSArray <CKJFuncModel *>*arr = data[i];
    
        CGFloat h_itemSpacing = config.h_itemSpacing;
        
        UIStackView *stackV = [[UIStackView alloc] init];
        stackV.spacing = h_itemSpacing;
        stackV.axis = UILayoutConstraintAxisHorizontal;
        stackV.distribution = UIStackViewDistributionFillEqually;
        stackV.alignment = UIStackViewAlignmentFill;
        [onlyStackV addArrangedSubview:stackV];
        
        for (int j = 0; j < arr.count; j++) {
            CKJFuncModel *model = arr[j];
            
            
            UIButton *btn = [[UIButton alloc]init];
//            WDCKJBGColor_Arc4Color(btn);
            
            btn.titleLabel.font = [UIFont systemFontOfSize:15.5];
            [btn setTitleColor:[UIColor kjwd_titleColor333333] forState:UIControlStateNormal];
            
            [btn kjwd_addTouchUpInsideForCallBack:model.func];
            
            NSString *title = WDKJ_ConfirmString(model.title);
            UIImage *image = model.image;
            
            [btn setTitle:title forState:UIControlStateNormal];
            
            if (WDKJ_IsNullObj(image, [UIImage class]) == NO) {
                [btn setImage:image forState:UIControlStateNormal];
            }
            [btn kjwd_layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop imageTitleSpace:15];
            [stackV addArrangedSubview:btn];
        }
    }
}

@end
