//
//  CKJCell.m
//  RAC空项目
//
//  Created by chenkaijie on 2018/1/19.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CKJCell.h"
#import <Masonry/Masonry.h>


@implementation CKJImage2Model
+ (instancetype)image2ModelWithImageString:(NSString *)imageString size:(CGSize)size left:(CGFloat)leftMargin {
    CKJImage2Model *model = [[self alloc] init];
    model.imageString2 = imageString;
    model.size = size;
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

@implementation CKJView5Model

+ (instancetype)view5ModelWithTopAttributedText:(nullable NSAttributedString *)topText bottomAttributedText:(nullable NSAttributedString *)bottomText centerMarign:(CGFloat)centerMarign topBottomMargin:(CGFloat)topBottomMargin leftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin {
    
    CKJView5Model *model = [[self alloc] init];
    model.topText = topText;
    model.bottomText = bottomText;
    
    UIEdgeInsets topEdge = UIEdgeInsetsMake(topBottomMargin, leftMargin, centerMarign / 2.0, rightMargin);
    UIEdgeInsets bottomEdge = UIEdgeInsetsMake(centerMarign / 2.0, leftMargin, topBottomMargin, rightMargin);
    
    model.topLabelEdge = topEdge;
    model.bottomLabelEdge = bottomEdge;
    
    return model;
}

+ (instancetype)view5ModelWithTopAttributedText:(nullable NSAttributedString *)topText bottomAttributedText:(nullable NSAttributedString *)bottomText topEdge:(UIEdgeInsets)topEdge bottomEdge:(UIEdgeInsets)bottomEdge {
    
    CKJView5Model *model = [[self alloc] init];
    model.topText = topText;
    model.bottomText = bottomText;
    
    model.topLabelEdge = topEdge;
    model.bottomLabelEdge = bottomEdge;
    
    return model;
}

- (void)changeTopText:(nullable NSString *)text {
    self.topText = [CKJWorker changeOriginAtt:self.topText text:text];
}

- (void)changeBottomText:(nullable NSString *)text {
    self.bottomText = [CKJWorker changeOriginAtt:self.bottomText text:text];
}

@end

@implementation CKJSwitch6Model


+ (instancetype)switch6ModelWithSwitchOn:(BOOL)switchOn left:(CGFloat)left top:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom callBack:(CKJSwitch6Block)callBack {
    CKJSwitch6Model *model = [[self alloc] init];
    model.switchOn = switchOn;
    model.left = left;
    model.top = top;
    model.right = right;
    model.bottom = bottom;
    model.swicthBlock = callBack;
    return model;
}

@end

@implementation CKJLikePriceLabel7Model
+ (instancetype)likePriceLabel7ModelWithAttributedText:(NSAttributedString *)text top:(CGFloat)top bottom:(CGFloat)bottom right:(CGFloat)right {
    CKJLikePriceLabel7Model *model = [[self alloc] init];
    model.attributedText = text;
    model.topMargin = top;
    model.rightMargin = right;
    model.bottomMargin = bottom;
    return model;
}

- (void)changeText:(nullable NSString *)text {
    self.attributedText = [CKJWorker changeOriginAtt:self.attributedText text:text];
}
@end

@implementation CKJBtn8Model



+ (instancetype)btn8ModelWithSize:(CGSize)size normalImage:(UIImage *)normalImage rightMargin:(CGFloat)rightMargin detailSettingBlock:(void(^)(CKJBtn8Model *sender))detailSettingBlock didClickBtn8Handle:(CKJDidClickBtn8Handle)didClickBtn8Handle {
    CKJBtn8Model *model = [[self alloc] init];
    model.normalImage = normalImage;
    model.rightMargin = rightMargin;
    model.size = size;
    if (detailSettingBlock) {
        detailSettingBlock(model);
    }
    model.didClickBtn8Handle = didClickBtn8Handle;
    return model;
}

- (void)changeNormalText:(nullable NSString *)text {
    self.normalAttributedTitle = [CKJWorker changeOriginAtt:self.normalAttributedTitle text:text];
}
- (void)changeSelectedText:(nullable NSString *)text {
    self.selectedAttributedTitle = [CKJWorker changeOriginAtt:self.selectedAttributedTitle text:text];
}


- (instancetype)init {
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
    }
    return self;
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

- (instancetype)init {
    if (self = [super init]) {
        self.right = 15;
    }
    return self;
}

@end

#pragma mark - -----UI组件-----

@interface CKJSwitchView : UIView
@property (strong, nonatomic) UISwitch *swicth;
@end

@implementation CKJSwitchView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    UISwitch *kjSwitch = [[UISwitch alloc] init];
    kjSwitch.on = YES;
    [self addSubview:kjSwitch];
    kjSwitch.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:kjSwitch attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:kjSwitch attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self addConstraints:@[centerX, centerY]];
    self.swicth = kjSwitch;
}
@end

@interface CKJTopBottomView : UIView
@end
@implementation CKJTopBottomView
@end

@interface CKJLeftView : UIView
@end
@implementation CKJLeftView
@end



@interface CKJTitle3Label : UILabel
@end
@implementation CKJTitle3Label
@end


@interface CKJSubTitle4Label : UILabel
@end
@implementation CKJSubTitle4Label
@end

@interface CKJView5TopLabel : UILabel
@end
@implementation CKJView5TopLabel
@end

@interface CKJView5BottomLabel : UILabel
@end
@implementation CKJView5BottomLabel
@end


@interface CKJLikePriceLabel7 : UILabel
@end
@implementation CKJLikePriceLabel7
@end







@interface CKJRightView : UIView
@end
@implementation CKJRightView
@end


@interface CKJButton8 : UIButton
@end
@implementation CKJButton8
@end

@interface CKJArrowImageView9 : UIImageView
@end
@implementation CKJArrowImageView9
@end


#pragma mark - -----模型和cell-----
@implementation CKJCellModel

- (instancetype)init {
    if (self = [super init]) {
        self.showLine = YES;
    }
    return self;
}

+ (instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJCellModelRowBlock)didSelectRowBlock {
    return [super modelWithCellHeight:cellHeight cellModel_id:cellModel_id detailSettingBlock:detailSettingBlock didSelectRowBlock:didSelectRowBlock];
}


@end




@interface CKJCell ()

@property (strong, nonatomic) CKJLeftView *leftWrapView;
@property (strong, nonatomic) UIButton *imageBtn2;
@property (strong, nonatomic) UILabel *title3;
@property (strong, nonatomic) UILabel *subTitle4;

@property (strong, nonatomic) CKJTopBottomView *view5;
@property (strong, nonatomic) UILabel *view5_topLabel;
@property (strong, nonatomic) UILabel *view5_bottomLabel;

@property (strong, nonatomic) CKJRightView *rightWrapView;
@property (strong, nonatomic) UIView *kjSwitch6;
@property (strong, nonatomic) UILabel *alikePriceLabel7;
@property (strong, nonatomic) UIButton *btn8;

@property (strong, nonatomic) UIImageView *arrowImageView9;

@end

@implementation CKJCell


/*
 附加 View1
 左   leftWrapView (imageBtn2   title3   subTitle4)
 中   View5        (view5_topLabel, view5_bottomLabel)
 右   rightWrapView (kjSwitch6  alikePriceLabel7   imageView8   arrowImageBtn9)
 附加  View10
 */

#define imageBtn2_w_h  30
#define kjSwitch6_w  60

// 控件右边间距， 比如文字
#define Right_Margin (-8)


- (void)setupSubViews {
    
    [self create_left_right];
    [self create_center_additional];
    
    __weak UIView *bgV = self.bgV;
    __weak typeof(self) weakSelf = self;
    
    [bgV addSubview:_leftWrapView];
    [bgV addSubview:_rightWrapView];
    
    
    UIView *left_of_leftWrapView = bgV;
    UIView *right_of_rightWrapView = bgV;
    
    [self create_topLabel_bottomLabel:_view5];
    
    
    // 中
    [bgV addSubview:_view5];
    [_view5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(bgV);
        make.right.equalTo(weakSelf.rightWrapView.mas_left);
    }];
    
    
    [_title3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf.leftWrapView);
        make.right.equalTo(weakSelf.subTitle4.mas_left).offset(Right_Margin);
    }];
    [_subTitle4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf.leftWrapView);
        make.right.equalTo(weakSelf.leftWrapView).offset(Right_Margin);
    }];
    [_leftWrapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(left_of_leftWrapView.mas_left);
        make.top.bottom.equalTo(bgV);
        make.right.equalTo(weakSelf.view5.mas_left);
    }];
    
    /*
     左   leftWrapView (imageBtn2   title3   subTitle4)
     中   View5
     右   rightWrapView (kjSwitch6  alikePriceLabel7   btn8   arrowImageBtn9)
     */
    
    // 右
    [_kjSwitch6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(weakSelf.rightWrapView);
        make.right.equalTo(weakSelf.alikePriceLabel7.mas_left);
        make.width.equalTo(@(kjSwitch6_w));
    }];
    [_alikePriceLabel7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf.alikePriceLabel7.superview);
        make.right.equalTo(weakSelf.btn8.mas_left).offset(Right_Margin);
    }];
    
    
    
    [self origin_btn8_Constraint];
    [self origin_arrowImageView9_Constraint];
    
    self.arrowImageView9.layer.contentsGravity = kCAGravityResizeAspectFill;
    
    [_rightWrapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(bgV);
        make.right.equalTo(right_of_rightWrapView.mas_right);
    }];
    
    BOOL debug = NO;
    if (debug) {
        
        //        self.leftWrapView.backgroundColor = [UIColor redColor];
        self.imageBtn2.backgroundColor = [UIColor purpleColor];
        self.title3.backgroundColor = [UIColor brownColor];
        self.subTitle4.backgroundColor = [UIColor yellowColor];
        
        self.view5.backgroundColor = [UIColor cyanColor];
        self.view5_topLabel.backgroundColor = [UIColor purpleColor];
        self.view5_bottomLabel.backgroundColor = [UIColor magentaColor];
        
        self.kjSwitch6.backgroundColor = [UIColor blueColor];
        //        self.rightWrapView.backgroundColor = [UIColor darkGrayColor];
        self.alikePriceLabel7.backgroundColor = [UIColor greenColor];
        self.btn8.backgroundColor = [UIColor redColor];
        self.arrowImageView9.backgroundColor = [UIColor grayColor];
        
    }
}

- (void)setupData:(CKJCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    if ([model isKindOfClass:[CKJCellModel class]] == NO) return;
    {
        UIImage *image = [UIImage kjwd_imageNamed:model.image2Model.imageString2];
        CGFloat leftMargin = model.image2Model.leftMargin;
        
        CGFloat title3LeftMargin = model.title3Model.leftMargin;
        
        if (image == nil) {
            [_imageBtn2 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
                make.left.equalTo(superview).offset(leftMargin);
                make.centerY.equalTo(superview);
                make.width.height.equalTo(@0);
                make.right.equalTo(self.title3.mas_left).offset(-(title3LeftMargin));
            }];
        } else {
            [self.imageBtn2 setImage:image forState:UIControlStateNormal];
            CGSize size = model.image2Model.size;
            [_imageBtn2 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
                make.centerY.equalTo(superview);
                make.left.equalTo(superview).offset(leftMargin);
                make.width.equalTo(@(size.width));
                make.height.equalTo(@(size.height));
                make.right.equalTo(self.title3.mas_left).offset(-(title3LeftMargin));
            }];
        }
    }
    
    NSAttributedString *titleAtt = model.title3Model.attributedText;
    
    self.title3.attributedText = WDKJ_ConfirmAttString(titleAtt);
    CGFloat subTitle4LeftMarign = model.subTitle4Model.leftMargin;
    if (WDKJ_IsEmpty_AttributedStr(titleAtt)) {
        [_title3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.leftWrapView);
            make.right.equalTo(self.subTitle4.mas_left).offset(-(subTitle4LeftMarign));
        }];
    } else {
        [_title3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.leftWrapView);
            make.right.equalTo(self.subTitle4.mas_left).offset(-(subTitle4LeftMarign));
        }];
    }
    
    
    NSAttributedString *subTitle4 = model.subTitle4Model.attributedText;
    self.subTitle4.attributedText = WDKJ_ConfirmAttString(subTitle4);
    if (WDKJ_IsEmpty_AttributedStr(subTitle4)) {
        [_subTitle4 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.leftWrapView);
            make.right.equalTo(self.leftWrapView);
        }];
    } else {
        CGFloat topMargin = model.subTitle4Model.topMargin;
        CGFloat bottomMargin = model.subTitle4Model.bottomMargin;
        CGFloat rightMargin = model.subTitle4Model.rightMargin;
        
        [_subTitle4 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
            make.top.equalTo(superview).offset(topMargin);
            make.bottom.equalTo(superview).offset(-(bottomMargin));
            make.right.equalTo(superview).offset(-(rightMargin));
        }];
    }
    
    // 设置 top bottom
    [self layoutTopBottomLabel];
    
    {
        
        CKJSwitch6Model *switch6Model = model.switch6Model;
        CGFloat left = switch6Model.left;
        CGFloat top = switch6Model.top;
        CGFloat right = switch6Model.right;
        CGFloat bottom = switch6Model.bottom;
        
        if (switch6Model == nil) {
            self.kjSwitch6.hidden = YES;
            [_kjSwitch6 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
                make.left.top.bottom.equalTo(superview);
                make.right.equalTo(self.alikePriceLabel7.mas_left);
                make.width.equalTo(@0);
            }];
        } else {
            self.kjSwitch6.hidden = NO;
            [_kjSwitch6 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
                make.left.equalTo(superview).offset(left);
                make.top.equalTo(superview).offset(top);
                make.bottom.equalTo(superview).offset(-(bottom));
                make.right.equalTo(self.alikePriceLabel7.mas_left).offset(-(right));
                make.width.equalTo(@(kjSwitch6_w));
            }];
            ((CKJSwitchView *)self.kjSwitch6).swicth.on = switch6Model.switchOn;
        }
    }
    {
        self.alikePriceLabel7.attributedText = WDKJ_ConfirmAttString(model.likePrice7Model.attributedText);
        
        CGFloat topMargin = model.likePrice7Model.topMargin;
        CGFloat bottomMargin = model.likePrice7Model.bottomMargin;
        CGFloat rightMargin = model.likePrice7Model.rightMargin;
        
        [_alikePriceLabel7 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
            make.top.equalTo(superview).offset(topMargin);
            make.bottom.equalTo(superview).offset(-(bottomMargin));
            make.right.equalTo(self.btn8.mas_left).offset(-(rightMargin));
        }];
    }
    
    {
        CKJBtn8Model *btn8Model = model.btn8Model;
        
        UIButton *btn8 = self.btn8;
        
        [btn8 setAttributedTitle:btn8Model.normalAttributedTitle forState:UIControlStateNormal];
        [btn8 setAttributedTitle:btn8Model.selectedAttributedTitle forState:UIControlStateSelected];
        
        UIImage *normalBackgroundImage =  btn8Model.normalBackgroundImage;
        UIImage *selectedBackgroundImage = btn8Model.selectedBackgroundImage;
        UIImage *normalImage = btn8Model.normalImage;
        UIImage *selectedImage = btn8Model.selectedImage;
        
        normalBackgroundImage = WDKJ_IsNullObj(normalBackgroundImage, [UIImage class]) ? nil : normalBackgroundImage;
        selectedBackgroundImage = WDKJ_IsNullObj(selectedBackgroundImage, [UIImage class]) ? nil : selectedBackgroundImage;
        normalImage = WDKJ_IsNullObj(normalImage, [UIImage class]) ? nil : normalImage;
        selectedImage =  WDKJ_IsNullObj(selectedImage, [UIImage class]) ? nil : selectedImage;
        
        
        [btn8 setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
        [btn8 setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
        [btn8 setImage:normalImage forState:UIControlStateNormal];
        [btn8 setImage:selectedImage forState:UIControlStateSelected];
        
        BOOL emptyAttributedTitle = WDKJ_IsEmpty_Str(btn8.currentAttributedTitle.string);
        BOOL emptyImage = btn8.currentImage == nil;
        BOOL emptyBackgroundImage = btn8.currentBackgroundImage == nil;
        // 如果什么都没有， 那么就width = 0
        if (emptyAttributedTitle && emptyImage && emptyBackgroundImage) {
            [_btn8 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.btn8.superview);
                make.right.equalTo(self.arrowImageView9.mas_left);
                make.width.equalTo(@0);
            }];
        } else {
            
            CGFloat centerYOffset = btn8Model.centerYOffset;
            CGFloat rightMargin = btn8Model.rightMargin;
            CGSize size = btn8Model.size;
            
            [_btn8 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
                make.centerY.equalTo(superview).offset(centerYOffset);
                make.width.equalTo(@(size.width));
                make.height.equalTo(@(size.height));
                make.right.equalTo(self.arrowImageView9.mas_left).offset(-(rightMargin));
            }];
        }
        
        
        if (btn8Model.cornerRadius > 0) {
            btn8.layer.cornerRadius = btn8Model.cornerRadius;
            btn8.clipsToBounds = YES;
        } else {
            btn8.layer.cornerRadius = 0;
            btn8.clipsToBounds = NO;
        }
        btn8.selected = btn8Model.selected;
        btn8.userInteractionEnabled = btn8Model.userInteractionEnabled;
    }
    
    [self origin_arrowImageView9_Constraint];
}

- (void)create_left_right {
    // 左
    CKJLeftView *leftWrapView = [CKJLeftView new];
    
    UIButton *imageBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    imageBtn2.userInteractionEnabled = NO;
    [leftWrapView addSubview:imageBtn2];
    
    
    UILabel *title3 = [CKJTitle3Label new];
    [leftWrapView addSubview:title3];
    [title3 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [title3 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    UILabel *subTitle4 = [CKJSubTitle4Label new];
    subTitle4.numberOfLines = 0;
    [leftWrapView addSubview:subTitle4];
    
    
    // 右
    CKJRightView *rightWrapView = [CKJRightView new];
    
    CKJSwitchView *switchView6 = [[CKJSwitchView alloc] init];
    [switchView6.swicth addTarget:self action:@selector(swicthAction:) forControlEvents:UIControlEventValueChanged];
    [switchView6 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [switchView6 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [rightWrapView addSubview:switchView6];
    
    
    UILabel *alikePriceLabel7 = [CKJLikePriceLabel7 new];
    [alikePriceLabel7 setContentHuggingPriority:850 forAxis:UILayoutConstraintAxisHorizontal];
    [alikePriceLabel7 setContentCompressionResistancePriority:850 forAxis:UILayoutConstraintAxisHorizontal];
    [rightWrapView addSubview:alikePriceLabel7];
    
    
    CKJButton8 *btn8 = [CKJButton8 buttonWithType:(UIButtonTypeCustom)];
    [btn8 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightWrapView addSubview:btn8];
    
    // 右边箭头图片
    CKJArrowImageView9 *arrowImageView9 = [CKJArrowImageView9 new];
    arrowImageView9.contentMode = UIViewContentModeScaleAspectFit;
    [rightWrapView addSubview:arrowImageView9];
    
    self.leftWrapView = leftWrapView;
    self.imageBtn2 = imageBtn2;
    self.title3 = title3;
    self.subTitle4 = subTitle4;
    
    self.rightWrapView = rightWrapView;
    self.kjSwitch6 = switchView6;
    self.alikePriceLabel7 = alikePriceLabel7;
    self.btn8 = btn8;
    self.arrowImageView9 = arrowImageView9;
}

- (void)create_center_additional {
    // 中
    CKJTopBottomView *view5 = [CKJTopBottomView new];
    self.view5 = view5;
}


- (void)origin_btn8_Constraint {
    __weak typeof(self) weakSelf = self;
    [_btn8 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.btn8.superview);
        make.right.equalTo(weakSelf.arrowImageView9.mas_left);
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

- (void)swicthAction:(UISwitch *)swicth {
    BOOL on = swicth.on;
    CKJCellModel *model = (CKJCellModel *)self.cellModel;
    model.switch6Model.switchOn = on;
    if (model.switch6Model.swicthBlock) {
        model.switch6Model.swicthBlock(on, model, swicth);
    }
}

- (void)create_topLabel_bottomLabel:(UIView *)superView {
    
    UILabel *title = [CKJView5TopLabel new];
    [superView addSubview:title];
    self.view5_topLabel = title;
    
    UILabel *subTitle = [CKJView5BottomLabel new];
    [superView addSubview:subTitle];
    self.view5_bottomLabel = subTitle;
    
    [title setContentHuggingPriority:240 forAxis:UILayoutConstraintAxisHorizontal];
    [title setContentCompressionResistancePriority:740 forAxis:UILayoutConstraintAxisHorizontal];
    
    [subTitle setContentHuggingPriority:240 forAxis:UILayoutConstraintAxisHorizontal];
    [subTitle setContentCompressionResistancePriority:740 forAxis:UILayoutConstraintAxisHorizontal];
    
    
    [title setContentHuggingPriority:242 forAxis:UILayoutConstraintAxisVertical];
    [title setContentCompressionResistancePriority:742 forAxis:UILayoutConstraintAxisVertical];
    
    [subTitle setContentHuggingPriority:240 forAxis:UILayoutConstraintAxisVertical];
    [subTitle setContentCompressionResistancePriority:740 forAxis:UILayoutConstraintAxisVertical];
    
    [self layoutTopBottomLabel];
}

- (void)layoutTopBottomLabel {
    
    CKJCellModel *model = self.cellModel;
    
    UILabel *title = self.view5_topLabel;
    UILabel *subTitle = self.view5_bottomLabel;
    
    UIEdgeInsets topEdge = model.view5Model.topLabelEdge;
    UIEdgeInsets bottomEdge = model.view5Model.bottomLabelEdge;
    
    title.attributedText = WDKJ_ConfirmAttString(model.view5Model.topText);
    subTitle.attributedText = WDKJ_ConfirmAttString(model.view5Model.bottomText);
    
    [title kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.top.equalTo(superview).offset(topEdge.top);
        make.left.equalTo(superview).offset(topEdge.left);
        make.right.equalTo(superview).offset(-(topEdge.right));
        make.bottom.equalTo(superview.mas_centerY).offset(-(topEdge.bottom));
    }];
    [subTitle kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.top.equalTo(superview.mas_centerY).offset(bottomEdge.top);
        make.left.equalTo(superview).offset(bottomEdge.left);
        make.right.equalTo(superview).offset(-(bottomEdge.right));
        make.bottom.equalTo(superview).offset(-(bottomEdge.bottom));
    }];
    
    title.textAlignment = model.view5Model.topLabelTextAlignment;
    subTitle.textAlignment = model.view5Model.bottomLabelTextAlignment;
}

- (void)btnAction:(UIButton *)sender {
    if (self.cellModel.btn8Model.didClickBtn8Handle) {
        self.cellModel.btn8Model.didClickBtn8Handle(self, self.cellModel.btn8Model);
    }
}


@end



