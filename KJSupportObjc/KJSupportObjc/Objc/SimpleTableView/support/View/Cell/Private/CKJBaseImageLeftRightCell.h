//
//  CKJBaseImageLeftRightCell.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/7/8.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJCommonTableViewCell.h"
#import "CKJFiveLabelView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CKJImageViewConfig : CKJCommonCellConfig


/**  默认CGSizeZero */
@property (assign, nonatomic) CGSize imageSize;

@property (assign, nonatomic) UIViewContentMode img_contentMode;

/** 边框宽度 */
@property (assign, nonatomic) CGFloat img_borderWidth;
/** 边框颜色 */
@property (strong, nonatomic) UIColor *img_borderColor;
/** 圆角*/
@property (assign, nonatomic) CGFloat img_cornerRadius;


@end



/*
 
 
 
- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues:(CKJSimpleTableView *_Nonnull)s {
    
    CKJImageLeftCellConfig *leftConfig = [CKJImageLeftCellConfig cellConfigWithDetail:^(__kindof CKJImageLeftCellConfig * _Nonnull m) {
        m.superView_margin_imageView = 10;
        m.imageSize = CGSizeMake(60, 60);
        m.fiveConfig = [CKJFiveLabelViewConfig cellConfigWithDetail:^(__kindof CKJFiveLabelViewConfig * _Nonnull m) {
        }];
    }];
    CKJImageRightCellConfig *rightConfig = [CKJImageRightCellConfig cellConfigWithDetail:^(__kindof CKJImageRightCellConfig * _Nonnull m) {
        m.superView_margin_imageView = 10;
        m.imageSize = CGSizeMake(60, 60);
        m.fiveConfig = [CKJFiveLabelViewConfig cellConfigWithDetail:^(__kindof CKJFiveLabelViewConfig * _Nonnull m) {
        }];
    }];
    
    return @{
             NSStringFromClass([CKJImageLeftCellModel class]) : @{KJPrefix_cellKEY : NSStringFromClass([CKJImageLeftCell class]), KJPrefix_isRegisterNibKEY : @NO, KJPrefix_configDicKEY_ConfigModel : leftConfig},
             NSStringFromClass([CKJImageRightCellModel class]) : @{KJPrefix_cellKEY : NSStringFromClass([CKJImageRightCell class]), KJPrefix_isRegisterNibKEY : @NO, KJPrefix_configDicKEY_ConfigModel : rightConfig},
             };
}
 
 
 
*/



@interface CKJBaseImageLeftRightCellConfig : CKJCommonCellConfig


@property (strong, nonatomic, nonnull) CKJImageViewConfig *imgConfig;
@property (strong, nonatomic, nonnull) CKJFiveLabelViewConfig *fiveConfig;

- (void)updateImgConfig:(void(^)(CKJImageViewConfig *_Nonnull c))block;
- (void)updateFiveConfig:(void(^)(CKJFiveLabelViewConfig *_Nonnull c))block;


/** 水平方向上 imageV的距离的父视图距离，默认12 */
@property (assign, nonatomic) CGFloat superView_margin_imageView;


@property (assign, nonatomic) UIEdgeInsets fiveLabelViewEdge;

@end


// 请使用 子类 CKJImageLeftCellModel  CKJImageRightCellModel
// 因为 这个类 子视图，没有布局
@interface CKJBaseImageLeftRightCellModel : CKJCommonCellModel


@property (strong, nonatomic, nullable) UIImage *b_ImageName;


/**
 默认使用SDWebImage进行加载
 */
@property (copy, nonatomic, nullable) NSString *b_Image_URL;
@property (strong, nonatomic, nullable) UIImage *b_placeholderImage;

- (void)updateFiveData:(void(^)(CKJFiveLabelModel *_Nonnull fm))block;


@property (strong, nonatomic, nonnull) CKJFiveLabelModel *fiveModel;


@end


@interface CKJBaseImageLeftRightCell : CKJCommonTableViewCell

@property (weak, nonatomic) UIImageView *imageV;

@property (strong, nonatomic) CKJFiveLabelView *fiveLabelView;

@end

NS_ASSUME_NONNULL_END
