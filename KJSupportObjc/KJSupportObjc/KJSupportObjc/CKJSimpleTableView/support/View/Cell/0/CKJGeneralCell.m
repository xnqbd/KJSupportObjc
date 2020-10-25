//
//  CKJGeneralCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/7/6.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJGeneralCell.h"

@implementation CKJImage2Model

+ (instancetype)image2ModelWithNormalImage:(nullable UIImage *)normalImage size:(nullable NSValue *)size left:(CGFloat)leftMargin {
    CKJImage2Model *model = [[self alloc] init];
    model.normalImage = normalImage;
    model.size = size ? size.CGSizeValue : normalImage.size;
    model.leftMargin = leftMargin;
    return model;
}
+ (instancetype)image2ModelWithImageString:(NSString *)imageString size:(CGSize)size left:(CGFloat)leftMargin {
    CKJImage2Model *model = [[self alloc] init];
    model.normalImage = [UIImage kjwd_imageNamed:imageString];
    model.size = size;
    model.leftMargin = leftMargin;
    return model;
}

+ (instancetype)image2ModelWithNormalImage:(nullable UIImage *)normalImage size:(nullable NSValue *)size left:(CGFloat)leftMargin detail:(void(^_Nullable)(CKJImage2Model *i))detail click:(nullable CKJBaseBtnClick)click {
    CKJImage2Model *m = [self image2ModelWithNormalImage:normalImage size:size left:leftMargin];
    m.userInteractionEnabled = YES;
    m.click = click;
    if (detail) {
        detail(m);
    }
    return m;
}

- (instancetype)init {
    if (self = [super init]) {
        self.userInteractionEnabled = NO;
    }
    return self;
}


@end


@implementation CKJTitle3Model

- (void)setAttributedText:(NSAttributedString *)attributedText {
    if ([attributedText isKindOfClass:[NSString class]]) {
        _attributedText = WDAttTitle((NSString *)attributedText);
    } else if ([attributedText isKindOfClass:[NSAttributedString class]]) {
        _attributedText = attributedText;
    } else if (attributedText == nil) {
        _attributedText = nil;
    }
    self.readOnly_title3Label.attributedText = nil;
}

+ (instancetype)title3ModelWithText:(nullable id)text left:(CGFloat)left {
    CKJTitle3Model *model = [[self alloc] init];
    model.attributedText = text;
    model.leftMargin = left;
    return model;
}

+ (instancetype)title3ModelWithText:(nullable id)text left:(CGFloat)left width:(CGFloat)width {
    CKJTitle3Model *model = [[self alloc] init];
    model.attributedText = text;
    model.leftMargin = left;
    model.width = @(width);
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
+ (instancetype)subTitle4ModelWithAttributedText:(nullable NSAttributedString *)text top:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right click:(CKJSubTitle4Click _Nullable)click {
    CKJSubTitle4Model *m = [self subTitle4ModelWithAttributedText:text top:left left:right bottom:bottom right:right];
    m.click = click;
    m.enable = YES;
    return m;
}



- (void)changeText:(nullable NSString *)text {
    self.attributedText = [CKJWorker changeOriginAtt:self.attributedText text:text];
}
@end



@implementation CKJLikePriceLabel8Model
+ (nonnull instancetype)likePriceLabel8ModelWithAttText:(nullable id)text left:(CGFloat)left right:(CGFloat)right {
    CKJLikePriceLabel8Model *model = [[self alloc] init];
    model.attributedText = text;
    model.leftMargin = left;
    model.rightMargin = right;
    return model;
}
- (void)changeText:(nullable NSString *)text {
    self.attributedText = [CKJWorker changeOriginAtt:self.attributedText text:text];
}


- (void)setAttributedText:(NSAttributedString *)attributedText {
    if ([attributedText isKindOfClass:[NSString class]]) {
        _attributedText = WDCKJAttributed2((NSString *)attributedText, [UIColor kjwd_subTitle], @14);
        self.readOnly_alikePriceLabel8.attributedText = _attributedText;
    } else if ([attributedText isKindOfClass:[NSAttributedString class]]) {
        _attributedText = attributedText;
    } else if (attributedText == nil) {
        _attributedText = nil;
    }
    self.readOnly_alikePriceLabel8.attributedText = _attributedText;
}


@end

@implementation CKJArrow9Model

+ (instancetype)arrow9ModelWithImage:(nullable UIImage *)image right:(nullable NSNumber *)right click:(nullable CKJArrow9Block)click {
    CKJArrow9Model *model = [[self alloc] init];
    if ([right isKindOfClass:[NSNumber class]]) {
        model.right = right.floatValue;
    }
    model.image = image;
    model.click = click;
    return model;
}
+ (instancetype)arrow9ModelWithImage:(nullable UIImage *)image imageViewSize:(nullable NSValue *)imageViewSize mode:(UIViewContentMode)mode right:(nullable NSNumber *)right click:(nullable CKJArrow9Block)click {
    CKJArrow9Model *m = [self arrow9ModelWithImage:image right:right click:click];
    m.imageView_Size = imageViewSize;
    m.imageView_content_Mode = mode;
    return m;
}


+ (nonnull instancetype)arrow9SystemModel {
    return [[CKJArrow9Model alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        self.right = 10;
        NSBundle *resourcesBundle = [CKJWorker kjbundle];
        UIImage *arrow = [UIImage imageNamed:@"kj_arrow1" inBundle:resourcesBundle compatibleWithTraitCollection:nil];
        arrow = [arrow kjwd_scaleToSize:CGSizeMake(16, 16)];
        self.image = arrow;
        self.imageView_content_Mode = UIViewContentModeCenter;
    }
    return self;
}

@end

@implementation CKJGeneralSetting

@end


@implementation CKJGeneralItem

+ (instancetype)itemWithImage:(nullable id)image title:(id)title detail:(nullable CKJGeneralCellModelRowBlock)detail click:(nullable CKJGeneralCellModelRowBlock)click {
    CKJGeneralItem *item = [[CKJGeneralItem alloc] init];
    item.image = image;
    item.title = title;
    item.detail = detail;
    item.click = click;
    return item;
}

@end

@implementation CKJGeneralCellModel

- (NSString *_Nullable)title3Text {
    return _title3Model.attributedText.string;
}

+ (instancetype)generalWithCellHeight:(nullable NSNumber *)cellHeight cellModel_id:(nullable NSString *)cellModel_id detailSettingBlock:(nullable CKJGeneralCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJGeneralCellModelRowBlock)didSelectRowBlock {
    return [self commonWithCellHeight:cellHeight cellModel_id:cellModel_id detailSettingBlock:detailSettingBlock didSelectRowBlock:didSelectRowBlock];
}

+ (instancetype)generalWithTitle:(id)title arrow:(CKJArrow9Model *)arrow didSelectRowBlock:(nullable CKJGeneralCellModelRowBlock)didSelectRowBlock {
    return[self generalWithCellHeight:nil cellModel_id:nil detailSettingBlock:^(CKJGeneralCellModel *__weak  _Nonnull m) {
        m.title3Model = [CKJTitle3Model title3ModelWithText:title left:kO_super_margin_title];
            m.arrow9Model = arrow;
    } didSelectRowBlock:didSelectRowBlock];
}

+ (instancetype)generalWithImageName:(NSString *)imageName imageSize:(CGSize)imageSize title:(id)title arrow:(BOOL)arrow didSelectRowBlock:(nullable CKJGeneralCellModelRowBlock)didSelectRowBlock {
    return[self generalWithCellHeight:nil cellModel_id:nil detailSettingBlock:^(CKJGeneralCellModel *__weak  _Nonnull m) {
        m.image2Model = [CKJImage2Model image2ModelWithImageString:imageName size:imageSize left:15];
        m.title3Model = [CKJTitle3Model title3ModelWithText:title left:kO_super_margin_title];
        if (arrow) {
            m.arrow9Model = [CKJArrow9Model arrow9SystemModel];
        }
    } didSelectRowBlock:didSelectRowBlock];
}

+ (instancetype)generalWithTitle:(id)title likePriceAttText:(id)likePriceAttText setting:(CKJGeneralSetting *)setting didSelectRowBlock:(CKJGeneralCellModelRowBlock)didSelectRowBlock {
    CKJGeneralCellModel *m = [self generalWithTitle:title likePriceAttText:likePriceAttText setting:setting arrow:nil didSelectRowBlock:didSelectRowBlock];
    m.arrow9Model = nil;
    return m;
}

+ (instancetype)generalWithTitle:(id)title likePriceAttText:(nullable id)likePriceAttText setting:(CKJGeneralSetting *)setting arrow:(nullable CKJArrow9Model *)arrow didSelectRowBlock:(nullable CKJGeneralCellModelRowBlock)didSelectRowBlock {
    return [self generalWithCellHeight:nil cellModel_id:nil detailSettingBlock:^(CKJGeneralCellModel *__weak  _Nonnull m) {
        m.title3Model = [CKJTitle3Model title3ModelWithText:title left:setting.image2_margin_title];
        m.likePrice8Model = [CKJLikePriceLabel8Model likePriceLabel8ModelWithAttText:likePriceAttText left:0 right:setting.likePriceLabel8_margin_arrow9];
        if (arrow == nil) {
            m.arrow9Model = [CKJArrow9Model arrow9SystemModel];
        } else {
            m.arrow9Model = arrow;
        }
        m.arrow9Model.right = setting.arrow9_margin_super;
    } didSelectRowBlock:didSelectRowBlock];
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
    
    WDCKJ_ifDEBUG(^{
        BOOL debug = [self __privateMethod_openDebug];
        if (debug) {
            
            //        self.leftWrapView.backgroundColor = [UIColor redColor];
            self.imageBtn2.backgroundColor = [UIColor purpleColor];
            self.title3.backgroundColor = [UIColor brownColor];
            
            self.centerView.backgroundColor = [UIColor orangeColor];
            self.alikePriceLabel8.backgroundColor = [UIColor blueColor];
            self.arrowImageView9.backgroundColor = [UIColor grayColor];
        }
    }, nil);
}

- (BOOL)__privateMethod_openDebug {
    return NO;
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
    
    
    __weak typeof(self) weakSelf = self;
    [imageBtn2 kjwd_addTouchUpInsideForCallBack:^(UIButton * _Nonnull _sender) {
        CKJGeneralCellModel *cellModel = weakSelf.cellModel;
        CKJImage2Model *image2Model = cellModel.image2Model;
        if (image2Model.click) {
            image2Model.click(image2Model, _sender);
        }
    }];
}

- (void)createCenter {
    CKJCenterView *centerView = [[CKJCenterView alloc] init];
    [self.onlyView addSubview:centerView];
    self.centerView = centerView;
}


- (void)createRight {
    __weak typeof(self) weakSelf = self;
    
    // 右
    CKJRightView *rightWrapView = [CKJRightView new];
    [self.onlyView addSubview:rightWrapView];
    self.rightWrapView = rightWrapView;
    
    
    UILabel *alikePriceLabel8 = [CKJLikePriceLabel8 new];
    [rightWrapView addSubview:alikePriceLabel8];
    self.alikePriceLabel8 = alikePriceLabel8;
    
    
    // 右边箭头图片
    CKJArrowImageView9 *arrowImageView9 = [CKJArrowImageView9 new];
    [arrowImageView9 kjwd_addGestureRecognizer:[[UITapGestureRecognizer alloc] init] handleBlock:^(UIGestureRecognizer * _Nonnull _gestureRecognizer, UIView * _Nonnull _currentView) {
        CKJGeneralCellModel *cellModel = weakSelf.cellModel;
        CKJArrow9Model *arrow9 = cellModel.arrow9Model;
        if (arrow9.click) {
            arrow9.click(arrow9);
        }
    }];
    arrowImageView9.contentMode = UIViewContentModeCenter;
    [rightWrapView addSubview:arrowImageView9];
    self.arrowImageView9 = arrowImageView9;
}


- (void)setupData:(CKJGeneralCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    if ([model isKindOfClass:[CKJGeneralCellModel class]] == NO) return;

    
    [self origin_imageBtn2_Constraint];
    [self origin_title3_Constraint];

    
    [self update_alikePriceLabel8_Constraint];
    [self origin_arrowImageView9_Constraint];
}

- (void)origin_imageBtn2_Constraint {
    CKJGeneralCellModel *model = self.cellModel;
    
    CKJImage2Model *image2Model = model.image2Model;

    CGFloat leftMargin = image2Model.leftMargin;
    
    __weak CKJGeneralCellModel *cellModel = self.cellModel;
    
    CGFloat title3LeftMargin = cellModel.title3Model.leftMargin;
    
    [CKJWorker reloadWithBtnModel:image2Model btn:self.imageBtn2 emptyHandle:^(CKJImage2Model * _Nonnull btnM) {
           [self.imageBtn2 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
               make.left.equalTo(superview).offset(leftMargin);
               make.centerY.equalTo(superview);
               make.width.height.equalTo(@0);
               make.right.equalTo(self.title3.mas_left).offset(-(title3LeftMargin));
           }];
       } noEmptyHandle:^(CKJImage2Model * _Nonnull btnM) {
           CGSize size = image2Model.size;
           [self.imageBtn2 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
               make.centerY.equalTo(superview);
               make.left.equalTo(superview).offset(leftMargin);
               make.width.equalTo(@(size.width));
               make.height.equalTo(@(size.height));
               make.right.equalTo(self.title3.mas_left).offset(-(title3LeftMargin));
           }];
       }];
    
//    if (normalImage == nil) {
//        [_imageBtn2 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
//            make.left.equalTo(superview).offset(leftMargin);
//            make.centerY.equalTo(superview);
//            make.width.height.equalTo(@0);
//            make.right.equalTo(self.title3.mas_left).offset(-(title3LeftMargin));
//        }];
//    } else {
//        [self.imageBtn2 setImage:normalImage forState:UIControlStateNormal];
//        CGSize size = image2Model.size;
//        [_imageBtn2 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
//            make.centerY.equalTo(superview);
//            make.left.equalTo(superview).offset(leftMargin);
//            make.width.equalTo(@(size.width));
//            make.height.equalTo(@(size.height));
//            make.right.equalTo(self.title3.mas_left).offset(-(title3LeftMargin));
//        }];
//    }
//
//    CGFloat radius = image2Model.cornerRadius;
//
//    if (radius <= 0) {
//        if (_imageBtn2.layer.cornerRadius != 0) {
//            _imageBtn2.layer.cornerRadius = 0;
//            _imageBtn2.clipsToBounds = NO;
//        }
//    } else {
//        if (_imageBtn2.layer.cornerRadius != radius) {
//            _imageBtn2.layer.cornerRadius = radius;
//            _imageBtn2.clipsToBounds = YES;
//        }
//    }
}

- (void)origin_title3_Constraint {

    CKJGeneralCellModel *model = self.cellModel;
    
    CKJTitle3Model *title3Model = model.title3Model;
    title3Model.readOnly_title3Label = self.title3;
    
    NSAttributedString *titleAtt = title3Model.attributedText;
    NSNumber *width = title3Model.width;
    
    self.title3.attributedText = WDKJ_ConfirmAttString(titleAtt);
    
    if (WDKJ_IsNull_Num(width)) { // 自适应宽度
        [_title3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self.leftWrapView);
        }];
    } else {  //  固定宽度  width == @100
        [_title3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self.leftWrapView);
            make.width.equalTo(width);
        }];
    }
}

- (void)update_alikePriceLabel8_Constraint {
    
    CKJGeneralCellModel *model = self.cellModel;
    CKJLikePriceLabel8Model *likePrice8Model = model.likePrice8Model;
    likePrice8Model.readOnly_alikePriceLabel8 = self.alikePriceLabel8;
    
//    左                     中间      右
//    [imageBtn2, title3]    []      [likePrice8, arrowImageView9]
    
    self.alikePriceLabel8.attributedText = WDKJ_ConfirmAttString(likePrice8Model.attributedText);
    
    CGFloat left = likePrice8Model.leftMargin;
    CGFloat right = likePrice8Model.rightMargin;
    
    [_alikePriceLabel8 kjwd_mas_updateConstraints:^(MASConstraintMaker *make, UIView *superview) {
        MASViewAttribute *temp = self.arrowImageView9.mas_left;
        
        make.left.equalTo(superview).offset(left);
        make.right.equalTo(temp).offset(-(right));
    }];
}

- (void)origin_arrowImageView9_Constraint {
    CKJGeneralCellModel *cellModel = self.cellModel;
    CKJArrow9Model *arrow9 = cellModel.arrow9Model;
    arrow9.readOnly_ImageView = _arrowImageView9;
    NSValue *size = arrow9.imageView_Size;
    CGFloat right = arrow9.right;
    UIImage *image = arrow9.image;
    
    _arrowImageView9.image = image;
    _arrowImageView9.hidden = image ? NO : YES;
    _arrowImageView9.userInteractionEnabled = arrow9.click ? YES : NO;
    if (_arrowImageView9.contentMode != arrow9.imageView_content_Mode) {
        _arrowImageView9.contentMode = arrow9.imageView_content_Mode;
    }
    
    [_arrowImageView9 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.centerY.equalTo(superview);
        make.right.equalTo(superview).offset(-(right));
        if (image) {
            if (size) {
                make.width.equalTo(@(size.CGSizeValue.width));
                make.height.equalTo(@(size.CGSizeValue.height));
            } else {
                make.width.equalTo(@(image.size.width));
                make.height.equalTo(@(image.size.height));
            }
        } else {
            make.width.height.equalTo(@0);
        }
    }];
}


@end
