//
//  CKJImageLeftCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/7/8.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJImageLeftCell.h"




@implementation CKJImageLeftCellConfig

+ (instancetype)imageLeftCellConfigWithDetail:(void(^)(__kindof CKJImageLeftCellConfig * _Nonnull m))detail {
    return [super configWithDetail:detail];
}


@end

@implementation CKJImageLeftCellModel


+ (nonnull instancetype)imageLeftWithCellHeight:(nullable NSNumber *)cellHeight cellModel_id:(nullable NSString *)cellModel_id detailSettingBlock:(nullable CKJImageLeftCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJImageLeftCellModelRowBlock)didSelectRowBlock {
    return [self commonWithCellHeight:cellHeight cellModel_id:cellModel_id detailSettingBlock:detailSettingBlock didSelectRowBlock:didSelectRowBlock];
}


@end

@interface CKJImageLeftCell ()

@property (weak, nonatomic) UIView *rightWrapper;

@end


@implementation CKJImageLeftCell

- (void)setupSubViews {
    [super setupSubViews];
    
    CKJImageLeftCellConfig *config = self.configModel;
    CKJImageViewConfig *imgConfig = config.imgConfig;
    
    // 先创建附件
    UIView *rightWrapper = [[UIView alloc] init];
    [self.onlyView addSubview:rightWrapper];
    self.rightWrapper = rightWrapper;
    
    
    CGSize imageSize = imgConfig.imageSize;
    CGFloat imageVleftMargin = config.superView_margin_imageView;
    UIEdgeInsets fiveLabelViewEdge = config.fiveLabelViewEdge;
    
    UIImageView *imageV = self.imageV;
    
    
    [imageV kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.centerY.equalTo(superview);
        make.left.equalTo(superview).offset(imageVleftMargin);
        make.width.equalTo(@(imageSize.width));
        make.height.equalTo(@(imageSize.height));
    }];
    
    [self.fiveLabelView kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(imageV.mas_right).offset(fiveLabelViewEdge.left);
        make.top.equalTo(superview).offset(fiveLabelViewEdge.top);
        make.bottom.equalTo(superview).offset(-(fiveLabelViewEdge.bottom));
        make.right.equalTo(rightWrapper.mas_left).offset(-(fiveLabelViewEdge.right));
    }];
    
    [rightWrapper kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.top.bottom.right.equalTo(superview);
    }];
    
    self.subviews_SuperView = rightWrapper;
}


@end


// 下面的demo 不要删除， 留做 复制代码用




/*
 
 // ------------- .h --------------
 
 
 
 #import "CKJCommonTableViewCell.h"

 NS_ASSUME_NONNULL_BEGIN


 @interface SearchCellNetData : CKJBaseModel

 @property (copy, nonatomic) NSString *imageUrl;
 @property (copy, nonatomic) NSString *title;
 @property (copy, nonatomic) NSString *subTitle;

 @end



 @interface SearchCellModel : CKJCommonCellModel


 @end

 @interface SearchCell : CKJCommonTableViewCell

 @end



 NS_ASSUME_NONNULL_END

 
 
 */







/*


// --------------- .m -----------------

 
 #import "SearchCell.h"
 #import "UIImageView+WebCache.h"

 @implementation SearchCellNetData


 @end

 @implementation SearchCellModel


 @end

 @interface SearchCell ()

 @property (strong, nonatomic) UIImageView *imageV;
 @property (strong, nonatomic) UILabel *titleLab;
 @property (strong, nonatomic) UILabel *subTitleLab;

 @end


 @implementation SearchCell

 - (void)setupData:(__kindof CKJCommonCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
     
     SearchCellNetData *data = model.networkData;
     
     NSURL *url = nil;
     NSString *title = @"";
     NSString *subTitle = @"";
     
     url = [NSURL kjwd_URLWithString:data.hosImgUrl];
     title = data.hosName;
     
     
     [self.imageV sd_setImageWithURL:url placeholderImage:[UIImage kjwd_imageNamed:@""]];
     self.titleLab.text = WDKJ_SpaceString(title);
     self.subTitleLab.text = WDKJ_SpaceString(subTitle);
 }

 - (void)setupSubViews {
     [super setupSubViews];
     
     
     UIView *bgV = self.subviews_SuperView;
     
     
     CGSize imageSize = CGSizeMake(70, 50);
     UIEdgeInsets edge = UIEdgeInsetsMake(10, 15, 0, 15);
     CGFloat image_margin_title = 10;
     
     
     UIImageView *imageV = [[UIImageView alloc] init];
     [imageV kjwd_masWithSuperView:bgV makeConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
         make.left.equalTo(superview).offset(edge.left);
         make.top.equalTo(superview).offset(edge.top);
         make.bottom.equalTo(superview).offset(-edge.left);
         make.size.mas_equalTo(imageSize);
     }];
     self.imageV = imageV;
     
     UILabel *title = [[UILabel alloc] init];
 //    title.numberOfLines = 0;
     title.textColor = [UIColor kjwd_title];
     title.font = [UIFont systemFontOfSize:14];
     [title kjwd_masWithSuperView:bgV makeConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
         make.top.equalTo(imageV).offset(1);
         make.left.equalTo(imageV.mas_right).offset(image_margin_title);
         make.right.lessThanOrEqualTo(superview).offset(-edge.right);
     }];
     self.titleLab = title;
     
     UILabel *subTitle = [[UILabel alloc] init];
     subTitle.textColor = [UIColor kjwd_subTitle];
     subTitle.font = [UIFont systemFontOfSize:13.5];
     [subTitle kjwd_masWithSuperView:bgV makeConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
         make.bottom.equalTo(imageV).offset(-1);
         make.left.equalTo(title);
         make.right.lessThanOrEqualTo(superview).offset(-edge.right);
     }];
     self.subTitleLab = subTitle;
     
     BOOL debug = NO;
     if (debug) {
         title.text = @"标题标题标题标题标题标题标题标题标题标题标题标题标题标题";
         subTitle.text = @"子标题 时间的话吧我看见二百六喝多了千万奥克斯街道办我理解吧思考记得合并";
         
         imageV.backgroundColor = [UIColor systemBlueColor];
         title.backgroundColor = [UIColor redColor];
         subTitle.backgroundColor = [UIColor yellowColor];
     }
 }


 @end


 




*/
