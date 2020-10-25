//
//  CKJImageViewCell.h
//  MobileHospital_Renji
//
//  Created by admin2 on 2020/1/11.
//  Copyright © 2020 Lyc. All rights reserved.
//

#import "CKJCommonTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN


@class CKJImageViewCellModel;

typedef void(^CKJImageViewCellRowBlock)(__kindof CKJImageViewCellModel *_Nonnull m);

/*
 let logo = CKJImageViewCellModel.imageView(withCellHeight: NSNumber(value: 132), detailSettingBlock: { (m) in
     m.localImage = UIImage.kjwd_imageNamed("logo")
     m.showLine = false;
 }) { (make, superView) in
     make.center.equalTo()(superView)
     make.size.equalTo()(CGSize(width: 120, height: 120))
 }
 
 CKJImageViewCellModel *model1 = [CKJImageViewCellModel imageViewWithCellHeight:@230 detailSettingBlock:^(__kindof CKJImageViewCellModel * _Nonnull m) {
     [m updateBGConfig:^(CKJCommonCellBGImageViewConfig * _Nonnull bg) {
         bg.edge = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsZero];
     }];
     [m _showLine:NO];
     m.localImage = [UIImage kjwd_imageNamed:@"背景"];
 } updateConstraint:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
     make.edges.equalTo(superview);
 }];
 
 
 */

@interface CKJImageViewCellModel : CKJCommonCellModel


@property (assign, nonatomic) UIViewContentMode contentMode;
@property (copy, nonatomic) void(^updateConstraint)(MASConstraintMaker *make, UIView *superview);


@property (strong, nonatomic) UIImage *localImage;


@property (copy, nonatomic, nullable) NSString *r_Image_URL;
@property (strong, nonatomic, nullable) UIImage *r_placeholderImage;


+ (instancetype)imageViewWithCellHeight:(nullable NSNumber *)cellHeight detailSettingBlock:(nullable CKJImageViewCellRowBlock)detailSettingBlock updateConstraint:(void(^)(MASConstraintMaker *make, UIView *superview))updateConstraint;

@end


@interface CKJImageViewCell : CKJCommonTableViewCell

@end

NS_ASSUME_NONNULL_END
