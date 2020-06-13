//
//  RJClinicTollBillCellTableViewCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/17.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "RJBillCell.h"
#import "NSObject+WDYHFCategory.h"

@implementation RJBillCellModel

- (instancetype)init {
    if (self = [super init]) {
        self.cellHeight = @44;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end


@implementation RJBillCell

- (void)setupData:(RJBillCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    
    self.timeLab.text = [[NSDate kjwd_returnDate:model.BillDate withDateFormat:CKJDateFormat4] kjwd_YearMonthDayString];
    
    self.amountLab.attributedText = WDCKJAttAppend(@"收费：", [UIColor kjwd_title], nil, [NSString stringWithFormat:@"￥%@", model.Total], [UIColor redColor], nil);
}

@end
