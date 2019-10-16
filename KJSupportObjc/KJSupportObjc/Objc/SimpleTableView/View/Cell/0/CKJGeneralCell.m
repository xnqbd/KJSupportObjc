//
//  CKJGeneralCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/7/6.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJGeneralCell.h"




@implementation CKJImage2Model

+ (nonnull instancetype)image2ModelWithNormalImage:(nullable UIImage *)normalImage size:(nullable NSValue *)size left:(CGFloat)leftMargin {
    CKJImage2Model *model = [[self alloc] init];
    model.normalImage = normalImage;
    model.sizeValue = size ? size : [NSValue valueWithCGSize:normalImage.size];
    model.leftMargin = leftMargin;
    return model;
}
+ (instancetype)image2ModelWithImageString:(NSString *)imageString size:(CGSize)size left:(CGFloat)leftMargin {
    CKJImage2Model *model = [[self alloc] init];
    model.normalImage = [UIImage kjwd_imageNamed:imageString];
    model.sizeValue = [NSValue valueWithCGSize:size];
    model.leftMargin = leftMargin;
    return model;
}



@end


@implementation CKJTitle3Model

+ (instancetype)title3ModelWithAttributedText:(nullable NSAttributedString *)text left:(CGFloat)left {
    CKJTitle3Model *model = [[self alloc] init];
    model.attributedText = text;
    model.leftMargin = left;
    return model;
}

+ (nonnull instancetype)title3ModelWithAttributedText:(nullable NSAttributedString *)text left:(CGFloat)left width:(CGFloat)width {
    CKJTitle3Model *model = [[self alloc] init];
    model.attributedText = text;
    model.leftMargin = left;
    model.width = width;
    return model;
}

- (void)changeText:(nullable NSString *)text {
    self.attributedText = [CKJWorker changeOriginAtt:self.attributedText text:text];
}

@end


@implementation CKJSubTitle4Model
+ (instancetype)subTitle4ModelWithAttributedText:(nullable NSAttributedString *)text top:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right {
    CKJSubTitle4Model *model = [[self alloc] init];
    model.attributedText = text;
    model.topMargin = top;
    model.leftMargin = left;
    model.rightMargin = right;
    model.bottomMargin = bottom;
    return model;
}


- (void)changeText:(nullable NSString *)text {
    self.attributedText = [CKJWorker changeOriginAtt:self.attributedText text:text];
}
@end



@implementation CKJLikePriceLabel8Model
+ (nonnull instancetype)likePriceLabel8ModelWithAttText:(nullable NSAttributedString *)text left:(CGFloat)left right:(CGFloat)right {
    CKJLikePriceLabel8Model *model = [[self alloc] init];
    model.attributedText = text;
    model.leftMargin = left;
    model.rightMargin = right;
    return model;
}
- (void)changeText:(nullable NSString *)text {
    self.attributedText = [CKJWorker changeOriginAtt:self.attributedText text:text];
}
@end



@implementation CKJArrow9Model

+ (instancetype)arrow9ModelWithImage:(UIImage *)image right:(nullable NSNumber *)right {
    CKJArrow9Model *model = [[self alloc] init];
    if ([right isKindOfClass:[NSNumber class]]) {
        model.right = right.floatValue;
    }
    model.image = image;
    return model;
}
+ (nonnull instancetype)arrow9SystemModel {
    return [[self alloc] init];
}


- (instancetype)init {
    if (self = [super init]) {
        self.right = 8;
        NSBundle *resourcesBundle = [CKJWorker kjbundle];
        UIImage *arrow = [UIImage imageNamed:@"kj_arrow1" inBundle:resourcesBundle compatibleWithTraitCollection:nil];
        arrow = [arrow kjwd_scaleToSize:CGSizeMake(16, 16)];
        self.image = arrow;
    }
    return self;
}

@end



@implementation CKJGeneralCellModel

+ (nonnull instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJGeneralCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJGeneralCellModelRowBlock)didSelectRowBlock {
    return [super modelWithCellHeight:cellHeight cellModel_id:cellModel_id detailSettingBlock:detailSettingBlock didSelectRowBlock:didSelectRowBlock];
}


@end


@interface CKJGeneralCell ()

@property (strong, nonatomic) CKJLeftView *leftWrapView;
@property (strong, nonatomic) UIButton *imageBtn2;
@property (strong, nonatomic) UILabel *title3;



@property (strong, nonatomic) CKJCenterView *centerView;

@property (strong, nonatomic) CKJRightView *rightWrapView;
@property (strong, nonatomic) UILabel *alikePriceLabel8;
@property (strong, nonatomic) UIImageView *arrowImageView9;

@end

@implementation CKJGeneralCell


- (void)setupSubViews {
    
    [self createLeft];
    [self createCenter];
    [self createRight];
    
    /*
     布局
     
     左                     中间      右
     [imageBtn2, title3]    []      [likePrice8, arrowImageView9]
     
     */
    
    
    [self origin_imageBtn2_Constraint];
    [self origin_title3_Constraint];
    
    [_leftWrapView kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.top.bottom.equalTo(superview);
        make.right.equalTo(self.centerView.mas_left);
    }];
    
    // 中间
    [_centerView kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.top.bottom.equalTo(superview);
        make.right.equalTo(self.rightWrapView.mas_left);
    }];
    
    
    // 右边
    [_alikePriceLabel8 kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        MASViewAttribute *temp = self.arrowImageView9.mas_left;
        make.left.top.bottom.equalTo(superview);
        make.right.equalTo(temp);
    }];
    [self origin_arrowImageView9_Constraint];
    [_rightWrapView kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.top.bottom.right.equalTo(superview);
    }];
    // 改变subviews_SuperView
    self.subviews_SuperView = self.centerView;
}


- (void)createLeft {
    
    // 左
    CKJLeftView *leftWrapView = [CKJLeftView new];
    [self.onlyView addSubview:leftWrapView];
    
    UIButton *imageBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    imageBtn2.userInteractionEnabled = NO;
    [leftWrapView addSubview:imageBtn2];
    
    
    UILabel *title3 = [CKJTitle3Label new];
    [title3 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [title3 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [leftWrapView addSubview:title3];
    
    
    self.imageBtn2 = imageBtn2;
    self.title3 = title3;
    
    self.leftWrapView = leftWrapView;
}

- (void)createCenter {
    CKJCenterView *centerView = [[CKJCenterView alloc] init];
    [self.onlyView addSubview:centerView];
    self.centerView = centerView;
}


- (void)createRight {
    // 右
    CKJRightView *rightWrapView = [CKJRightView new];
    [self.onlyView addSubview:rightWrapView];
    self.rightWrapView = rightWrapView;
    
    
    UILabel *alikePriceLabel8 = [CKJLikePriceLabel8 new];
    [alikePriceLabel8 setContentHuggingPriority:850 forAxis:UILayoutConstraintAxisHorizontal];
    [alikePriceLabel8 setContentCompressionResistancePriority:850 forAxis:UILayoutConstraintAxisHorizontal];
    [rightWrapView addSubview:alikePriceLabel8];
    self.alikePriceLabel8 = alikePriceLabel8;
    
    // 右边箭头图片
    CKJArrowImageView9 *arrowImageView9 = [CKJArrowImageView9 new];
    arrowImageView9.contentMode = UIViewContentModeScaleAspectFit;
    [rightWrapView addSubview:arrowImageView9];
    self.arrowImageView9 = arrowImageView9;
}


- (void)setupData:(CKJGeneralCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    if ([model isKindOfClass:[CKJGeneralCellModel class]] == NO) return;

    
    [self origin_imageBtn2_Constraint];
    [self origin_title3_Constraint];

    
    [self update_alikePriceLabel8_Constraint];
    [self origin_arrowImageView9_Constraint];
    
    BOOL debug = NO;
    if (debug) {
        
        //        self.leftWrapView.backgroundColor = [UIColor redColor];
        self.imageBtn2.backgroundColor = [UIColor purpleColor];
        self.title3.backgroundColor = [UIColor brownColor];
        
        self.centerView.backgroundColor = [UIColor orangeColor];
        self.alikePriceLabel8.backgroundColor = [UIColor blueColor];
        self.arrowImageView9.backgroundColor = [UIColor grayColor];
    }
}

- (void)origin_imageBtn2_Constraint {
    CKJGeneralCellModel *model = self.cellModel;

    UIImage *normalImage = model.image2Model.normalImage;
    CGFloat leftMargin = model.image2Model.leftMargin;
    
    CGFloat title3LeftMargin = model.title3Model.leftMargin;
    
    if (normalImage == nil) {
        [_imageBtn2 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
            make.left.equalTo(superview).offset(leftMargin);
            make.centerY.equalTo(superview);
            make.width.height.equalTo(@0);
            make.right.equalTo(self.title3.mas_left).offset(-(title3LeftMargin));
        }];
    } else {
        [self.imageBtn2 setImage:normalImage forState:UIControlStateNormal];
        CGSize size = model.image2Model.sizeValue.CGSizeValue;
        [_imageBtn2 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
            make.centerY.equalTo(superview);
            make.left.equalTo(superview).offset(leftMargin);
            make.width.equalTo(@(size.width));
            make.height.equalTo(@(size.height));
            make.right.equalTo(self.title3.mas_left).offset(-(title3LeftMargin));
        }];
    }
}

- (void)origin_title3_Constraint {

    CKJGeneralCellModel *model = self.cellModel;
    
    NSAttributedString *titleAtt = model.title3Model.attributedText;
    CGFloat width = model.title3Model.width;
    
    self.title3.attributedText = WDKJ_ConfirmAttString(titleAtt);
    if (WDKJ_IsEmpty_AttributedStr(titleAtt)) {
        [_title3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self.leftWrapView);
            make.width.equalTo(@0);
        }];
    } else {
        [_title3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self.leftWrapView);
            if (width) {
                make.width.equalTo(@(width));
            }
        }];
    }
}

- (void)update_alikePriceLabel8_Constraint {
    
    CKJGeneralCellModel *model = self.cellModel;
    
//    左                     中间      右
//    [imageBtn2, title3]    []      [likePrice8, arrowImageView9]
    
    self.alikePriceLabel8.attributedText = WDKJ_ConfirmAttString(model.likePrice8Model.attributedText);
    
    CGFloat left = model.likePrice8Model.leftMargin;
    CGFloat right = model.likePrice8Model.rightMargin;
    
    [_alikePriceLabel8 kjwd_mas_updateConstraints:^(MASConstraintMaker *make, UIView *superview) {
        MASViewAttribute *temp = self.arrowImageView9.mas_left;
        
        make.left.equalTo(superview).offset(left);
        make.right.equalTo(temp).offset(-(right));
    }];
}
- (void)origin_arrowImageView9_Constraint {
    CKJArrow9Model *arrow9 = self.cellModel.arrow9Model;
    CGFloat right = arrow9.right;
    UIImage *image = arrow9.image;
    
    _arrowImageView9.image = image;
    _arrowImageView9.hidden = image ? NO : YES;
    

    [_arrowImageView9 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.centerY.equalTo(superview);
        make.right.equalTo(superview).offset(-(right));
        if (image) {
            make.width.equalTo(@(image.size.width));
            make.height.equalTo(@(image.size.height));
        } else {
            make.width.height.equalTo(@0);
        }
    }];
}


@end
