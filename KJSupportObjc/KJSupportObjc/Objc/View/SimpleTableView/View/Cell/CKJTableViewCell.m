//
//  CKJTableViewCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/12.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJTableViewCell.h"


@implementation CKJTableViewCellModel

+ (instancetype _Nonnull)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJTableViewCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJTableViewCellModelRowBlock)didSelectRowBlock {
    return [super modelWithCellHeight:cellHeight cellModel_id:cellModel_id detailSettingBlock:detailSettingBlock didSelectRowBlock:didSelectRowBlock];
}

- (void)_setText:(nullable NSString *)text {
    self.textLabelAttStr = WDCKJAttributed2(text, [UIColor kjwd_colorWithHexString:@"333333"], @16);
}

@end


@implementation CKJTableViewCell

- (void)setupData:(CKJCommonCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    if ([model isKindOfClass:[CKJTableViewCellModel class]] == NO) return;
    
    CKJTableViewCellModel *_model = (CKJTableViewCellModel *)model;
    
    NSAttributedString *textLabelAttStr = _model.textLabelAttStr;
    NSAttributedString *detailTextAttStr = _model.detailTextAttStr;
    
    self.textLabel.attributedText = WDKJ_ConfirmAttString(textLabelAttStr);
    self.detailTextLabel.attributedText = WDKJ_ConfirmAttString(detailTextAttStr);
    
    self.textLabel.numberOfLines = 0;
}


@end
