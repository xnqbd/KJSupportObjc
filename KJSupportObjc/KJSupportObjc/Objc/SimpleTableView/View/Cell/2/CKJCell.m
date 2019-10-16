//
//  CKJCell.m
//  RAC空项目
//
//  Created by chenkaijie on 2018/1/19.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CKJCell.h"
#import <Masonry/Masonry.h>

#import "UIView+CKJDesingable.h"


@implementation CKJBaseBtnModel


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

@implementation CKJBtn5Model

+ (nonnull instancetype)btn5ModelWithSize:(CGSize)size normalImage:(nullable UIImage *)normalImage rightMargin:(CGFloat)rightMargin detailSettingBlock:(void(^_Nullable)(CKJBtn5Model *_Nonnull sender))detailSettingBlock didClickBtn7Handle:(nullable CKJDidClickbtn5Handle)didClickBtn7Handle {
    CKJBtn5Model *model = [[self alloc] init];
    model.normalImage = normalImage;
    model.rightMargin = rightMargin;
    model.size = size;
    if (detailSettingBlock) {
        detailSettingBlock(model);
    }
//    model.didClickBtn5Handle = didClickBtn5Handle;
    return model;
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

@implementation CKJBtn7Model



+ (nonnull instancetype)btn7ModelWithSize:(CGSize)size normalImage:(nullable UIImage *)normalImage rightMargin:(CGFloat)rightMargin detailSettingBlock:(void(^_Nullable)(CKJBtn7Model *_Nonnull sender))detailSettingBlock didClickBtn7Handle:(nullable CKJDidClickbtn7Handle)didClickBtn7Handle {
    CKJBtn7Model *model = [[self alloc] init];
    model.normalImage = normalImage;
    model.rightMargin = rightMargin;
    model.size = size;
    if (detailSettingBlock) {
        detailSettingBlock(model);
    }
    model.didClickBtn7Handle = didClickBtn7Handle;
    return model;
}

@end

#pragma mark - -----UI组件-----

@interface CKJTopBottomView : UIView
@end
@implementation CKJTopBottomView
@end



@interface CKJButton5 : UIButton
@end
@implementation CKJButton5
@end


@interface CKJView5TopLabel : UILabel
@end
@implementation CKJView5TopLabel
@end

@interface CKJView5BottomLabel : UILabel
@end
@implementation CKJView5BottomLabel
@end



@interface CKJButton7 : UIButton
@end
@implementation CKJButton7
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

@property (strong, nonatomic) UILabel *subTitle4;

@property (strong, nonatomic) UIButton *btn5;

@property (strong, nonatomic) CKJTopBottomView *view5;
@property (strong, nonatomic) UILabel *view5_topLabel;
@property (strong, nonatomic) UILabel *view5_bottomLabel;


/**
 中间的附加View
 */
@property (strong, nonatomic) CKJTextFieldWrapperView *tfWrapperView;



@property (strong, nonatomic) UIView *kjSwitch6;
@property (strong, nonatomic) UIButton *btn7;

@end

@implementation CKJCell

- (void)setupSubViews {
    [super setupSubViews];
    
    __weak typeof(self) weakSelf = self;
    
    [self create_subtitle4];
    [self create_btn5];
    [self create_View5];
    [self create_tfWrapperView];
    [self create_67];

    /*
     顺序
     
     [subTitle4  btn5  View5  tfWrapperView  kjSwitch6   btn7]
     
     */
    
    
    // 约束 subTitle4
    [self origin_subTitle4_Constraint];
    
    
    // 约束 View5的子视图
    [self origin_topBottomView_Constraint];
    
  
    
    [_view5 kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.top.bottom.equalTo(superview);
        make.right.equalTo(weakSelf.tfWrapperView.mas_left);
    }];
    [_tfWrapperView kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.top.bottom.equalTo(superview);
        make.right.equalTo(weakSelf.kjSwitch6.mas_left);
    }];
    
    [self origin_switchView6_Constraint];
    
    [_btn7 kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.centerY.right.equalTo(superview);
    }];
    
    BOOL debug = NO;
    if (debug) {
        
        //        self.leftWrapView.backgroundColor = [UIColor redColor];
        self.imageBtn2.backgroundColor = [UIColor purpleColor];
        self.title3.backgroundColor = [UIColor brownColor];
        self.subTitle4.backgroundColor = [UIColor yellowColor];
        
        
        self.btn5.backgroundColor = [UIColor magentaColor];
        
        self.view5.backgroundColor = [UIColor cyanColor];
        self.view5_topLabel.backgroundColor = [UIColor purpleColor];
        self.view5_bottomLabel.backgroundColor = [UIColor magentaColor];
        
        self.tfWrapperView.backgroundColor = [UIColor redColor];
        
        self.kjSwitch6.backgroundColor = [UIColor blueColor];
        //        self.rightWrapView.backgroundColor = [UIColor darkGrayColor];
        
        self.btn7.backgroundColor = [UIColor redColor];
        self.arrowImageView9.backgroundColor = [UIColor grayColor];
    }
}

- (void)setupData:(CKJCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    [super setupData:model section:section row:row selectIndexPath:indexPath tableView:tableView];
    if ([model isKindOfClass:[CKJCellModel class]] == NO) return;
    
    [self origin_subTitle4_Constraint];
    
    [self origin_btn5_Constraint];
    
    // 设置 top bottom
    [self origin_topBottomView_Constraint];
    
    [self update_tfWrapperView_Constraint];
    
    [self origin_switchView6_Constraint];
    
    [self origin_btn7_Constraint];
}


- (void)swicthAction:(UISwitch *)swicth {
    BOOL on = swicth.on;
    CKJCellModel *model = (CKJCellModel *)self.cellModel;
    model.switch6Model.switchOn = on;
    if (model.switch6Model.swicthBlock) {
        model.switch6Model.swicthBlock(on, model, swicth);
    }
}

- (void)create_subtitle4 {

    UILabel *subTitle4 = [CKJSubTitle4Label new];
    subTitle4.numberOfLines = 0;
    [self.subviews_SuperView addSubview:subTitle4];
    
    self.subTitle4 = subTitle4;
}

- (void)create_btn5 {
    
    CKJButton5 *btn5 = [CKJButton5 buttonWithType:UIButtonTypeCustom];
//    [btn5 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.subviews_SuperView addSubview:btn5];
    
    self.btn5 = btn5;
}

- (void)create_View5 {
    
    CKJTopBottomView *view5 = [CKJTopBottomView new];
    [self.subviews_SuperView addSubview:view5];
    self.view5 = view5;
    
    UILabel *title = [CKJView5TopLabel new];
    [view5 addSubview:title];
    self.view5_topLabel = title;
    
    UILabel *subTitle = [CKJView5BottomLabel new];
    [view5 addSubview:subTitle];
    self.view5_bottomLabel = subTitle;
    
    [title setContentHuggingPriority:240 forAxis:UILayoutConstraintAxisHorizontal];
    [title setContentCompressionResistancePriority:740 forAxis:UILayoutConstraintAxisHorizontal];
    
    [subTitle setContentHuggingPriority:240 forAxis:UILayoutConstraintAxisHorizontal];
    [subTitle setContentCompressionResistancePriority:740 forAxis:UILayoutConstraintAxisHorizontal];
    
    
    [title setContentHuggingPriority:242 forAxis:UILayoutConstraintAxisVertical];
    [title setContentCompressionResistancePriority:742 forAxis:UILayoutConstraintAxisVertical];
    
    [subTitle setContentHuggingPriority:240 forAxis:UILayoutConstraintAxisVertical];
    [subTitle setContentCompressionResistancePriority:740 forAxis:UILayoutConstraintAxisVertical];
}

- (void)create_tfWrapperView {
    CKJTextFieldWrapperView *tfWrapperView = [CKJTextFieldWrapperView new];
    self.tfWrapperView = tfWrapperView;
    [self.subviews_SuperView addSubview:tfWrapperView];
}

- (void)create_67 {
    CKJSwitchView *switchView6 = [[CKJSwitchView alloc] init];
    [switchView6.swicth addTarget:self action:@selector(swicthAction:) forControlEvents:UIControlEventValueChanged];
    [switchView6 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [switchView6 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.subviews_SuperView addSubview:switchView6];

    CKJButton7 *btn7 = [self __privateMethodOfCreateBtn7];
    [btn7 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.subviews_SuperView addSubview:btn7];
    
    self.kjSwitch6 = switchView6;
    self.btn7 = btn7;
}

- (void)origin_subTitle4_Constraint {
    CKJCellModel *model = (CKJCellModel *)self.cellModel;
    CKJSubTitle4Model *subTitle4Model = model.subTitle4Model;
    
    CGFloat subTitle4LeftMarign = subTitle4Model.leftMargin;
    
    NSAttributedString *subTitle4 = subTitle4Model.attributedText;
    _subTitle4.attributedText = WDKJ_ConfirmAttString(subTitle4);
    
    CGFloat topMargin = subTitle4Model.topMargin;
    CGFloat bottomMargin = subTitle4Model.bottomMargin;
    CGFloat rightMargin = subTitle4Model.rightMargin;
    
    // [subTitle4  btn5  View5  tfWrapperView  kjSwitch6   btn7]
    
    [_subTitle4 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(superview).offset(subTitle4LeftMarign);
        make.top.equalTo(superview).offset(topMargin);
        make.bottom.equalTo(superview).offset(-(bottomMargin));
        make.right.equalTo(_btn5.mas_left).offset(-(rightMargin));
//        make.right.equalTo(_view5.mas_left).offset(-(rightMargin));
    }];
}

- (void)origin_btn5_Constraint {
    
    
    CKJCellModel *model = (CKJCellModel *)self.cellModel;
    CKJBtn5Model *btn5Model = model.btn5Model;
    
    UIButton *btn5 = self.btn5;
    
    [btn5 setAttributedTitle:btn5Model.normalAttributedTitle forState:UIControlStateNormal];
    [btn5 setAttributedTitle:btn5Model.selectedAttributedTitle forState:UIControlStateSelected];
    
    UIImage *normalBackgroundImage =  btn5Model.normalBackgroundImage;
    UIImage *selectedBackgroundImage = btn5Model.selectedBackgroundImage;
    UIImage *normalImage = btn5Model.normalImage;
    UIImage *selectedImage = btn5Model.selectedImage;
    
    normalBackgroundImage = WDKJ_IsNullObj(normalBackgroundImage, [UIImage class]) ? nil : normalBackgroundImage;
    selectedBackgroundImage = WDKJ_IsNullObj(selectedBackgroundImage, [UIImage class]) ? nil : selectedBackgroundImage;
    normalImage = WDKJ_IsNullObj(normalImage, [UIImage class]) ? nil : normalImage;
    selectedImage =  WDKJ_IsNullObj(selectedImage, [UIImage class]) ? nil : selectedImage;
    
    [btn5 setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
    [btn5 setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
    [btn5 setImage:normalImage forState:UIControlStateNormal];
    [btn5 setImage:selectedImage forState:UIControlStateSelected];
    
    BOOL emptyAttributedTitle = WDKJ_IsEmpty_Str(btn5.currentAttributedTitle.string);
    BOOL emptyImage = btn5.currentImage == nil;
    BOOL emptyBackgroundImage = btn5.currentBackgroundImage == nil;
    // 如果什么都没有， 那么就width = 0
    
    // [subTitle4  btn5  View5  tfWrapperView  kjSwitch6   btn7]
    
    if ((emptyAttributedTitle && emptyImage && emptyBackgroundImage) || btn5Model.btnHidden) {
        
        [_btn5 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
            make.centerY.equalTo(superview);
            make.width.height.equalTo(@0);
            make.right.equalTo(_view5.mas_left);
        }];
    } else {
        CGFloat centerYOffset = btn5Model.centerYOffset;
        CGFloat rightMargin = btn5Model.rightMargin;
        CGSize size = btn5Model.size;
        
        [_btn5 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
            make.centerY.equalTo(superview).offset(centerYOffset);
            make.width.equalTo(@(size.width));
            make.height.equalTo(@(size.height));
            make.right.equalTo(_view5.mas_left).offset(-(rightMargin));
        }];
        
        if (btn5Model.cornerRadius > 0) {
            btn5.layer.cornerRadius = btn5Model.cornerRadius;
            btn5.clipsToBounds = YES;
        } else {
            btn5.layer.cornerRadius = 0;
            btn5.clipsToBounds = NO;
        }
        btn5.kBorderColor = btn5Model.borderColor;
        btn5.kBorderWidth = btn5Model.borderWidth;
        btn5.selected = btn5Model.selected;
        btn5.userInteractionEnabled = btn5Model.userInteractionEnabled;
        
        if (btn5Model.layoutButton) {
            btn5Model.layoutButton(btn5);
        }
    }
    
    [btn5 kjwd_setHidden:btn5Model.btnHidden];
}

- (void)origin_topBottomView_Constraint {
    
    CKJCellModel *model = (CKJCellModel *)self.cellModel;
    
    UILabel *title = _view5_topLabel;
    UILabel *subTitle = _view5_bottomLabel;
    
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



- (void)update_tfWrapperView_Constraint {
    
    CKJCellModel *model = (CKJCellModel *)self.cellModel;
    
    CKJSwitch6Model *switch6Model = model.switch6Model;
    CGFloat left = switch6Model.left;
    
    [_tfWrapperView kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.right.equalTo(self.kjSwitch6.mas_left).offset(-(left));
    }];
}
    
- (void)origin_switchView6_Constraint {
    
    CKJCellModel *model = (CKJCellModel *)self.cellModel;

        CKJSwitch6Model *switch6Model = model.switch6Model;
        // CGFloat left = switch6Model.left;
        CGFloat top = switch6Model.top;
        CGFloat right = switch6Model.right;
        CGFloat bottom = switch6Model.bottom;
        
        /*
         顺序
         
         [subTitle4  btn5  View5  tfWrapperView  kjSwitch6   btn7]
         */
    
        if (switch6Model == nil) {
            self.kjSwitch6.hidden = YES;
            [_kjSwitch6 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
                make.top.bottom.equalTo(superview);
                make.right.equalTo(self.btn7.mas_left);
                make.width.equalTo(@0);
            }];
        } else {
            self.kjSwitch6.hidden = NO;
            
            [_kjSwitch6 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
                make.top.equalTo(superview).offset(top);
                make.bottom.equalTo(superview).offset(-(bottom));
                make.right.equalTo(self.btn7.mas_left).offset(-(right));
                make.width.equalTo(@60);
            }];
            ((CKJSwitchView *)self.kjSwitch6).swicth.on = switch6Model.switchOn;
        }
}


- (void)origin_btn7_Constraint {
    CKJCellModel *model = (CKJCellModel *)self.cellModel;
    CKJBtn7Model *btn7Model = model.btn7Model;
    
    UIButton *btn7 = self.btn7;
    
    [btn7 setAttributedTitle:btn7Model.normalAttributedTitle forState:UIControlStateNormal];
    [btn7 setAttributedTitle:btn7Model.selectedAttributedTitle forState:UIControlStateSelected];
    
    UIImage *normalBackgroundImage =  btn7Model.normalBackgroundImage;
    UIImage *selectedBackgroundImage = btn7Model.selectedBackgroundImage;
    UIImage *normalImage = btn7Model.normalImage;
    UIImage *selectedImage = btn7Model.selectedImage;
    
    normalBackgroundImage = WDKJ_IsNullObj(normalBackgroundImage, [UIImage class]) ? nil : normalBackgroundImage;
    selectedBackgroundImage = WDKJ_IsNullObj(selectedBackgroundImage, [UIImage class]) ? nil : selectedBackgroundImage;
    normalImage = WDKJ_IsNullObj(normalImage, [UIImage class]) ? nil : normalImage;
    selectedImage =  WDKJ_IsNullObj(selectedImage, [UIImage class]) ? nil : selectedImage;
    
    [btn7 setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
    [btn7 setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
    [btn7 setImage:normalImage forState:UIControlStateNormal];
    [btn7 setImage:selectedImage forState:UIControlStateSelected];
    
    BOOL emptyAttributedTitle = WDKJ_IsEmpty_Str(btn7.currentAttributedTitle.string);
    BOOL emptyImage = btn7.currentImage == nil;
    BOOL emptyBackgroundImage = btn7.currentBackgroundImage == nil;
    // 如果什么都没有， 那么就width = 0
    
    if ((emptyAttributedTitle && emptyImage && emptyBackgroundImage) || btn7Model.btnHidden) {
        
        [_btn7 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
            make.centerY.right.equalTo(superview);
            make.width.equalTo(@0);
            make.right.equalTo(superview);
        }];
    } else {
        CGFloat centerYOffset = btn7Model.centerYOffset;
        CGFloat rightMargin = btn7Model.rightMargin;
        CGSize size = btn7Model.size;
        
        [_btn7 kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
            make.centerY.equalTo(superview).offset(centerYOffset);
            make.width.equalTo(@(size.width));
            make.height.equalTo(@(size.height));
            make.right.equalTo(superview).offset(-(rightMargin));
        }];
        
        if (btn7Model.cornerRadius > 0) {
            btn7.layer.cornerRadius = btn7Model.cornerRadius;
            btn7.clipsToBounds = YES;
        } else {
            btn7.layer.cornerRadius = 0;
            btn7.clipsToBounds = NO;
        }
        btn7.kBorderColor = btn7Model.borderColor;
        btn7.kBorderWidth = btn7Model.borderWidth;
        btn7.selected = btn7Model.selected;
        btn7.userInteractionEnabled = btn7Model.userInteractionEnabled;
        
        if (btn7Model.layoutButton) {
            btn7Model.layoutButton(btn7);
        }
    }
    
    [btn7 kjwd_setHidden:btn7Model.btnHidden];
}



- (void)btnAction:(UIButton *)sender {
    CKJCellModel *model = (CKJCellModel *)self.cellModel;
    if (model.btn7Model.didClickBtn7Handle) {
        model.btn7Model.didClickBtn7Handle(self, model.btn7Model);
    }
}

- (__kindof UIButton *)__privateMethodOfCreateBtn7 {
    return [CKJButton7 buttonWithType:(UIButtonTypeCustom)];
}
- (UIView *_Nonnull)tfWrapperView {
    return _tfWrapperView;
}


@end



