//
//  CKJTableViewCell2.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/17.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJCommonTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN


@class CKJTableViewCell2Model;

typedef void(^CKJTableViewCell2ModelRowBlock)(__kindof CKJTableViewCell2Model *_Nonnull m);


@interface CKJTableViewCell2Model : CKJCommonCellModel

@property (copy, nonatomic, nullable) NSAttributedString *textLabelAttStr;
@property (copy, nonatomic, nullable) NSAttributedString *detailTextAttStr;

/**
 设置textLabel 使用 [UIColor kjwd_titleColor333333], 15.5字号
 */
- (void)_setText:(nullable NSString *)text;

+ (instancetype _Nonnull)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJTableViewCell2ModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJTableViewCell2ModelRowBlock)didSelectRowBlock;


@end


@interface CKJTableViewCell2 : CKJCommonTableViewCell

@end

NS_ASSUME_NONNULL_END
