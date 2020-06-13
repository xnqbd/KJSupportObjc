//
//  CKJBaseTableViewCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/27.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJCommonTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class CKJBaseTableViewCellModel;

typedef void(^CKJBaseTableViewCellRowBlock)(__kindof CKJBaseTableViewCellModel *_Nonnull m);


@interface CKJBaseTableViewCellModel : CKJCommonCellModel


/**
 默认 上下：10  左右15
 */
@property (assign, nonatomic) UIEdgeInsets edge;

/**
 默认显示一行
 */
@property (assign, nonatomic) NSInteger numberOfLines;

/**
 默认左边对齐
 */
@property (assign, nonatomic) NSTextAlignment textAlignment;


@property (copy, nonatomic, nullable) NSAttributedString *attText;

/**
 设置textLabel 使用 [UIColor kjwd_title], 15.5字号
 */
- (void)_setText:(nullable NSString *)text;

+ (instancetype _Nonnull)baseTableViewCellWithCellHeight:(nullable NSNumber *)cellHeight cellModel_id:(nullable NSString *)cellModel_id detailSettingBlock:(nullable CKJBaseTableViewCellRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJBaseTableViewCellRowBlock)didSelectRowBlock;

+ (NSMutableArray <__kindof CKJBaseTableViewCellModel *>*_Nonnull)tableViewCellWithExtensionObjs:(NSArray *)extensionObjs detailSetting:(void(^)(__kindof CKJBaseTableViewCellModel *_Nonnull m, id extensionObj))detailSetting;


@end


@interface CKJBaseTableViewCell : CKJCommonTableViewCell



@end

NS_ASSUME_NONNULL_END
