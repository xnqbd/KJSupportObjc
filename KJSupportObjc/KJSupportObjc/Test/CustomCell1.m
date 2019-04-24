//
//  CustomCell1.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/3/22.
//  Copyright © 2019年 Lyc. All rights reserved.
//

#import "CustomCell1.h"
#import "NSObject+WDYHFCategory.h"

@implementation CustomCell1Model

- (instancetype)init {
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end


@implementation CustomCell1


- (void)setupData:(CustomCell1Model *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    
    self.timeLab.textColor = [UIColor kjwd_subTitleColor969696];
    self.projectLab.textColor = self.timeLab.textColor;
    self.countLab.textColor = self.timeLab.textColor;
    self.amountLab.textColor = self.timeLab.textColor;

    self.timeLab.text = model.Date;
    self.projectLab.text = model.ItemName;
    self.countLab.text = [NSString stringWithFormat:@"%@", model.Qty];
    self.amountLab.text = [NSString stringWithFormat:@"￥%@", model.Amount];
}

@end
