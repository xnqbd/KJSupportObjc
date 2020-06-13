//
//  CKJLikeQRCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/7/17.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJCommonTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CKJLikeQRCellConfig : CKJCommonCellConfig

@property (copy, nonatomic) NSNumber *width_multipliedBySuperView;
@property (copy, nonatomic) NSNumber *height_multipliedBySuperView;
@property (assign, nonatomic) CGSize imageViewSize;

+ (nonnull instancetype)likeQRCellConfigWithImageViewSize:(CGSize)size;

@end


@interface CKJLikeQRCellModel : CKJCommonCellModel

@property (strong, nonatomic, nonnull) UIImage *likeQrImage;

@end


@interface CKJLikeQRCell : CKJCommonTableViewCell //<CKJLikeQRCellModel *>


/**
 类似二维码的ImageView
 */
@property (weak, nonatomic) UIImageView *likeQrImageView;

@end

NS_ASSUME_NONNULL_END
