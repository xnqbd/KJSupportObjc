//
//  CustomOrderListCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/3/24.
//  Copyright © 2019年 Lyc. All rights reserved.
//

#import "CustomCell2.h"
#import "NSObject+WDYHFCategory.h"


@implementation CustomCell2Model

@end


@implementation CustomCell2

- (void)installData:(CKJFiveCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    self.imageV.image = [UIImage kjwd_imageNamed:model.image_Name];
}


@end
