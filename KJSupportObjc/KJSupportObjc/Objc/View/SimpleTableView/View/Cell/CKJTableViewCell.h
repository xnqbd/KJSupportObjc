//
//  CKJTableViewCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/12.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJCommonTableViewCell.h"
#import "CKJCombineCellProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@class CKJTableViewCellModel;

typedef void(^CKJTableViewCellModelRowBlock)(__kindof CKJTableViewCellModel *_Nonnull m);


@interface CKJTableViewCellModel : CKJCommonCellModel

@property (copy, nonatomic, nullable) NSAttributedString *textLabelAttStr;
@property (copy, nonatomic, nullable) NSAttributedString *detailTextAttStr;

/**
 设置textLabel 使用 [UIColor kjwd_titleColor333333], 15.5字号
 */
- (void)_setText:(nullable NSString *)text;

+ (instancetype _Nonnull)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJTableViewCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJTableViewCellModelRowBlock)didSelectRowBlock;


@end


@interface CKJTableViewCell : CKJCommonTableViewCell

@end

NS_ASSUME_NONNULL_END
