//
//  OrderVisitPersonLastCell.m
//  HealthTaiZhou
//
//  Created by chenkaijie on 2018/7/5.
//  Copyright © 2018年 kingtang. All rights reserved.
//

#import "OrderVisitPersonLastCell.h"



@implementation OrderVisitPersonLastCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIView *shadow = self.shadow;
    
    shadow.layer.cornerRadius = 10;
    shadow.layer.shadowColor = [UIColor blackColor].CGColor;
    shadow.layer.shadowOffset = CGSizeMake(0, 1);
    shadow.layer.shadowOpacity = 0.2;
    shadow.layer.shadowRadius = 1;
}


@end
