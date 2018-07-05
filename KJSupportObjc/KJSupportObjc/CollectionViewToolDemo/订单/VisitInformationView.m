//
//  VisitInformationView.m
//  HealthTaiZhou
//
//  Created by chenkaijie on 2018/7/2.
//  Copyright © 2018年 kingtang. All rights reserved.
//

#import "VisitInformationView.h"



@implementation VisitInformationModel

@end

@implementation VisitInformationView


- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIView *shadow = self;
    
    shadow.layer.cornerRadius = 10;
    shadow.layer.shadowColor = [UIColor blackColor].CGColor;
    shadow.layer.shadowOffset = CGSizeMake(-1, -1);
    shadow.layer.shadowOpacity = 0.2;
    shadow.layer.shadowRadius = 1;
}


/**
 重新选择
 */
- (IBAction)reChoose:(UIButton *)sender {
    
    
}

/**
 确认
 */
- (IBAction)confirmAction:(UIButton *)sender {
}
- (void)setModel:(VisitInformationModel *)model {
    _model = model;
    self.nameTF.text = model.name;
    self.cardTF.text = model.idNumber;
    self.addressTF.text = model.address;
}

@end
