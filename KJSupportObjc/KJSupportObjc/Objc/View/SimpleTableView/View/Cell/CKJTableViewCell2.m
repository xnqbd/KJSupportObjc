//
//  CKJTableViewCell2.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/17.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJTableViewCell2.h"

@implementation CKJTableViewCell2Model

+ (instancetype _Nonnull)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJTableViewCell2ModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJTableViewCell2ModelRowBlock)didSelectRowBlock {
    return [super modelWithCellHeight:cellHeight cellModel_id:cellModel_id detailSettingBlock:detailSettingBlock didSelectRowBlock:didSelectRowBlock];
}

- (void)_setText:(nullable NSString *)text {
    self.textLabelAttStr = WDCKJAttributed2(text, [UIColor kjwd_colorWithHexString:@"333333"], @16);
}

@end


@implementation CKJTableViewCell2

- (void)setupData:(CKJCommonCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    if ([model isKindOfClass:[CKJTableViewCell2Model class]] == NO) return;
    
    CKJTableViewCell2Model *_model = (CKJTableViewCell2Model *)model;
    
    NSAttributedString *textLabelAttStr = _model.textLabelAttStr;
    NSAttributedString *detailTextAttStr = _model.detailTextAttStr;
    
    self.textLabel.attributedText = WDKJ_ConfirmAttString(textLabelAttStr);
    self.detailTextLabel.attributedText = WDKJ_ConfirmAttString(detailTextAttStr);
    
}


@end
