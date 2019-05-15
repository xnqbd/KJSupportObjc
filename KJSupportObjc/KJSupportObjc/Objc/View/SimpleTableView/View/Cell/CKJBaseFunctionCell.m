//
//  CKJBaseFunctionCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/14.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseFunctionCell.h"


@implementation CKJFuncModel

+ (nonnull instancetype)modelWithTitle:(NSString *)title image:(UIImage *)image func:(void (^)(UIButton *sender))func {
    CKJFuncModel *model = [[self alloc] init];
    model.title = title;
    model.image = image;
    model.func = func;
    return model;
}

@end

@implementation CKJBaseFunctionCellConfig


@end


@implementation CKJBaseFunctionCellModel


@end


@implementation CKJBaseFunctionCell

- (void)setupSubViews {
    
    CKJBaseFunctionCellConfig *config = self.configDic[configDicKEY_ConfigModel];
    
    WDCKJ_ifDEBUG(^{
        if (config == nil || ([config isKindOfClass:[CKJBaseFunctionCellConfig class]] == NO)) {
            NSException *exception = [NSException exceptionWithName:@"未配置Config对象" reason:[NSString stringWithFormat:@"%@必须配置一个继承于CKJBaseFunctionCellConfig的对象", self] userInfo:nil];
            [exception raise];
        }
    }, nil);
    
    UIScrollView *scrollV = [[UIScrollView alloc] init];
//    WDCKJBGColor_Arc4Color(scrollV);
    [self.bgV addSubview:scrollV];
    [scrollV kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.edges.equalTo(superview);
    }];
    
    NSArray *data = config.data;
    
    NSMutableArray *viewArrs = [[NSMutableArray alloc]init];
    for (int i = 0; i < data.count; i++) {
        CKJFuncModel *model = data[i];
        
        UIButton *btn = [[UIButton alloc]init];
//        WDCKJBGColor_Arc4Color(btn);

        btn.titleLabel.font = [UIFont systemFontOfSize:15.5];
        [btn setTitleColor:[UIColor kjwd_titleColor333333] forState:UIControlStateNormal];
        
        [btn kjwd_addTouchUpInsideForCallBack:model.func];
        
        NSString *title = WDKJ_ConfirmString(model.title);
        UIImage *image = model.image;
        
        [btn setTitle:title forState:UIControlStateNormal];
        
        if (WDKJ_IsNullObj(image, [UIImage class]) == NO) {
            [btn setImage:image forState:UIControlStateNormal];
        }
        [btn kjwd_layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop imageTitleSpace:10];
        
        [viewArrs addObject:btn];
    }
    
    UIEdgeInsets edge = config.edge;
    
    CGFloat top = edge.top > 0 ? edge.top : 0;
    CGFloat left = edge.left > 0 ? edge.left : 0;
    CGFloat bottom = edge.bottom > 0 ? edge.bottom : 0;
    CGFloat right = edge.right > 0 ? edge.right : 0;
    
    
    CGFloat itemSpace = config.itemSpace ? config.itemSpace : 0;
    CGFloat itemWidth = config.itemWidth ? config.itemWidth : 0;
 
    [scrollV kjwd_viewsOfHorizontal:viewArrs viewWidth:itemWidth itemSpacing:itemSpace leftSpacing:left rightSpacing:right vorizontalConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.top.equalTo(superview).offset(top);
        make.bottom.equalTo(superview).offset(-(bottom));
    }];
}





@end
