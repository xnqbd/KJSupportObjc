//
//  CKJFunctionCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/14.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJFunctionCell.h"

@implementation CKJFunctionCellModel


@end

@implementation CKJFunctionCell

- (void)setupData:(__kindof CKJCommonCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    if ([model isKindOfClass:[CKJFunctionCellModel class]]) return;
    
    CKJFunctionCellModel *_model = model;
    
}

- (void)setupSubViews {
    
    
    UIScrollView *scrollV = [[UIScrollView alloc] init];
    WDCKJBGColor_Arc4Color(scrollV);
    [self.bgV addSubview:scrollV];
    [scrollV kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.edges.equalTo(superview);
    }];
    
    
    NSMutableArray *viewArrs = [[NSMutableArray alloc]init];
    for (int i = 0; i < 8; i ++) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        WDCKJBGColor_Arc4Color(btn);
        [btn setTitle:[NSString stringWithFormat:@"横向 %d",i] forState:UIControlStateNormal];
        [scrollV addSubview:btn];
        [viewArrs addObject:btn];
    }
    
    [viewArrs mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:2.0 leadSpacing:10.0 tailSpacing:10.0];
    [viewArrs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollV).offset(10);
        make.height.equalTo(@50);
    }];
    
}

@end
