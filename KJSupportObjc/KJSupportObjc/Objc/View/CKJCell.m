//
//  CKJCell.m
//  RAC空项目
//
//  Created by chenkaijie on 2018/1/19.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CKJCell.h"
#import <Masonry/Masonry.h>



@implementation KJWDJButtonModel


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

@interface CKJAdditionView : UIView
@end
@implementation CKJAdditionView
@end

@interface CKJLeftView : UIView
@end
@implementation CKJLeftView
@end

@interface CKJRightView : UIView
@end
@implementation CKJRightView
@end


@interface CKJUIButton8 : UIButton
@end
@implementation CKJUIButton8
@end

@interface CKJArrowImageView9 : UIImageView
@end
@implementation CKJArrowImageView9
@end


#pragma mark - -----模型和cell-----
@implementation CKJCellModel

@end




@interface CKJCell ()

@property (strong, nonatomic) CKJAdditionView *view1;

@property (strong, nonatomic) CKJLeftView *leftWrapView;
@property (strong, nonatomic) UIButton *imageBtn2;
@property (strong, nonatomic) UILabel *title3;
@property (strong, nonatomic) UILabel *subTitle4;

@property (strong, nonatomic) CKJAdditionView *view5;
@property (strong, nonatomic) UILabel *view5_topLabel;
@property (strong, nonatomic) UILabel *view5_bottomLabel;

@property (strong, nonatomic) CKJRightView *rightWrapView;
@property (strong, nonatomic) CKJSwitchView *kjSwitch6;
@property (strong, nonatomic) UILabel *alikePriceLabel7;
//@property (strong, nonatomic) UIImageView *imageView8;
@property (strong, nonatomic) CKJUIButton8 *btn8;

@property (strong, nonatomic) CKJArrowImageView9 *arrowImageView9;


@property (strong, nonatomic) CKJAdditionView *view10;

@end

@implementation CKJCell


/*
 附加 View1
 左   leftWrapView (imageBtn2   title3   subTitle4)
 中   View5
 右   rightWrapView (kjSwitch6  alikePriceLabel7   imageView8   arrowImageBtn9)
 附加  View10
 */

#define imageBtn2_w_h  30
#define arrowImageView9_w  15
#define kjSwitch6_w  60

// 控件右边间距， 比如文字
#define Right_Margin (-8)



#define margin 15.0

- (void)setupSubViews {
    
    [self create_left_right];
    [self create_center_additional];
    
    __weak UIView *contentView = self.contentView;
    __weak typeof(self) weakSelf = self;
    
    [contentView addSubview:_leftWrapView];
    [contentView addSubview:_rightWrapView];
    
    
    //默认只有 left 和 right,  没有 view1、view10
    BOOL add_view1 = NO;
    BOOL add_view10 = NO;
    
    UIView *left_of_leftWrapView = contentView;
    UIView *right_of_rightWrapView = contentView;
    
    
    if (add_view1) {
        left_of_leftWrapView = self.view1;
    }
    if (add_view10) {
        right_of_rightWrapView = self.view10;
    }
    
    [self create_topLabel_bottomLabel:_view5];
    
    if (add_view1) {
        [contentView addSubview:_view1];
        [_view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(contentView);
            // 一般图片大小设置为固定
            make.width.equalTo(@(15));
        }];
    }
    
    // 中
    [contentView addSubview:_view5];
    [_view5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(contentView);
        make.right.equalTo(weakSelf.rightWrapView.mas_left);
    }];
    
    
    //附加
    if (add_view10) {
        [contentView addSubview:_view10];
        [_view10 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(contentView);
            // 给一个初始宽度
            make.width.equalTo(@(15));
        }];
    }
    
    [_title3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf.leftWrapView);
        make.right.equalTo(weakSelf.subTitle4.mas_left).offset(Right_Margin);
    }];
    [_subTitle4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf.leftWrapView);
        make.right.equalTo(weakSelf.leftWrapView).offset(Right_Margin);
    }];
    [_leftWrapView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (add_view1) {
            make.left.equalTo(left_of_leftWrapView.mas_right);
        } else {
            make.left.equalTo(left_of_leftWrapView.mas_left);
        }
        make.top.bottom.equalTo(contentView);
        make.right.equalTo(weakSelf.view5.mas_left);
    }];
    
    /*
     附加 View1
     左   leftWrapView (imageBtn2   title3   subTitle4)
     中   View5
     右   rightWrapView (kjSwitch6  alikePriceLabel7   btn8   arrowImageBtn9)
     附加  View10
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
        make.top.bottom.equalTo(contentView);
        if (add_view10) {
            make.right.equalTo(right_of_rightWrapView.mas_left);
        } else {
            make.right.equalTo(right_of_rightWrapView.mas_right);
        }
    }];
    
    BOOL debug = NO;
    if (debug) {
        self.view1.backgroundColor = [UIColor orangeColor];
        
        //        self.leftWrapView.backgroundColor = [UIColor redColor];
        self.imageBtn2.backgroundColor = [UIColor purpleColor];
        self.title3.backgroundColor = [UIColor brownColor];
        self.subTitle4.backgroundColor = [UIColor yellowColor];
        
        self.view5.backgroundColor = [UIColor cyanColor];
        
        self.kjSwitch6.backgroundColor = [UIColor blueColor];
        //        self.rightWrapView.backgroundColor = [UIColor darkGrayColor];
        self.alikePriceLabel7.backgroundColor = [UIColor greenColor];
        self.btn8.backgroundColor = [UIColor redColor];
        self.arrowImageView9.backgroundColor = [UIColor grayColor];
        
        self.view10.backgroundColor = [UIColor blackColor];
    }
}

- (void)setupData:(CKJCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    
    if ([self.ckjCellDataSource respondsToSelector:@selector(view5_setup_leftMarginAtsection:row:cell:)]) {
        CGFloat view5_leftMargin = [self.ckjCellDataSource view5_setup_leftMarginAtsection:section row:row cell:self];
        if (view5_leftMargin < 0) {
            view5_leftMargin = 0;
        }
        [_leftWrapView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view5.mas_left).offset(-view5_leftMargin);
        }];
    }
    {
        void (^rightBlock)(MASConstraintMaker *make) = ^ (MASConstraintMaker *make){
            CGFloat rightOffset = 0;
            if ([self.ckjCellDataSource respondsToSelector:@selector(title3_leftMarginAtsection:row:cell:)]) {
                rightOffset = [self.ckjCellDataSource title3_leftMarginAtsection:section row:row cell:self];
            }
            make.right.equalTo(self.title3.mas_left).offset(-(rightOffset));
        };
        
        UIView *imageBtn2SuperView = self.imageBtn2.superview;
        
        NSString *imageString = model.left_ImageString2;
        if ([self isEmptyString:imageString]) {
            [_imageBtn2 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(imageBtn2SuperView).offset(0);
                make.centerY.equalTo(imageBtn2SuperView);
                make.width.height.equalTo(@0);
                rightBlock ? rightBlock(make) : nil;
            }];
        } else {
            [self.imageBtn2 setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
            
            [_imageBtn2 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(imageBtn2SuperView);
                rightBlock ? rightBlock(make) : nil;
                // 一般图片大小设置为固定
                if ([self.ckjCellDataSource respondsToSelector:@selector(imageBtn2_setup:section:row:cell:imageBtn2:)]) {
                    [self.ckjCellDataSource imageBtn2_setup:make section:section row:row cell:self imageBtn2:self.imageBtn2];
                } else {
                    make.left.equalTo(self.imageBtn2.superview).offset(15);
                    make.width.height.equalTo(@(imageBtn2_w_h));
                }
            }];
        }
    }
    self.title3.attributedText = model.title3;
    if ([self isEmptyString:model.title3.string]) {
        [_title3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.leftWrapView);
            make.right.equalTo(self.subTitle4.mas_left);
        }];
    } else {
        [_title3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.leftWrapView);
            make.right.equalTo(self.subTitle4.mas_left).offset(Right_Margin);
        }];
    }
    
    self.subTitle4.attributedText = model.subTitle4;
    if ([self isEmptyString:model.subTitle4.string]) {
        [_subTitle4 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.leftWrapView);
            make.right.equalTo(self.leftWrapView);
        }];
    } else {
        [_subTitle4 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.leftWrapView);
            make.right.equalTo(self.leftWrapView).offset(Right_Margin);
        }];
    }
    
    // 设置 top bottom
    [self layoutTopBottomLabel];
    
    UIEdgeInsets edge = UIEdgeInsetsZero;
    if ([self.ckjCellDataSource respondsToSelector:@selector(alikePriceLabel7_edgeInsetsAtsection:row:cell:)]) {
        edge = [self.ckjCellDataSource alikePriceLabel7_edgeInsetsAtsection:section row:row cell:self];
    }
    
    {
        if (model.showSwitch == NO) {
            self.kjSwitch6.hidden = YES;
            [_kjSwitch6 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@0);
            }];
        } else {
            self.kjSwitch6.hidden = NO;
            [_kjSwitch6 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(kjSwitch6_w));
            }];
//            NSLog(@"%@ ", model.switchOn ? @"开" : @"关");
            self.kjSwitch6.swicth.on = model.switchOn;
        }
    }
    {
        self.alikePriceLabel7.attributedText = model.right_alikePrice7;
        [_alikePriceLabel7 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.alikePriceLabel7.superview).offset(edge.top);
            make.bottom.equalTo(self.alikePriceLabel7.superview).offset(-(edge.bottom));
            make.right.equalTo(self.btn8.mas_left).offset(-(edge.right));
        }];
    }
    
    {
        KJWDJButtonModel *btn8Model = model.btn8Model;
        
        UIButton *btn8 = self.btn8;
        
        [btn8 setAttributedTitle:btn8Model.normalAttributedTitle forState:UIControlStateNormal];
        [btn8 setAttributedTitle:btn8Model.selectedAttributedTitle forState:UIControlStateSelected];
        
        UIImage *normalBackgroundImage = nil;
        UIImage *selectedBackgroundImage = nil;
        UIImage *normalImage = nil;
        UIImage *selectedImage = nil;
        
        if ([self isEmptyString:btn8Model.normalBackgroundImage] == NO) {
            normalBackgroundImage = [UIImage imageNamed:btn8Model.normalBackgroundImage];
        }
        if ([self isEmptyString:btn8Model.selectedBackgroundImage] == NO) {
            selectedBackgroundImage = [UIImage imageNamed:btn8Model.selectedBackgroundImage];
        }
        if ([self isEmptyString:btn8Model.normalImage] == NO) {
            normalImage = [UIImage imageNamed:btn8Model.normalImage];
        }
        if ([self isEmptyString:btn8Model.selectedImage] == NO) {
            selectedImage = [UIImage imageNamed:btn8Model.selectedImage];
        }
        [btn8 setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
        [btn8 setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
        [btn8 setImage:normalImage forState:UIControlStateNormal];
        [btn8 setImage:selectedImage forState:UIControlStateSelected];
        
        
        BOOL emptyAttributedTitle = [self isEmptyString:btn8.currentAttributedTitle.string];
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
            // 一般图片大小设置为固定
            if ([self.ckjCellDataSource respondsToSelector:@selector(btn8_return_rightMargin:section:row:cell:btn8:)]) {
                [_btn8 mas_remakeConstraints:^(MASConstraintMaker *make) {
                    CGFloat offset = [self.ckjCellDataSource btn8_return_rightMargin:make section:section row:row cell:self btn8:self.btn8];
                    make.right.equalTo(self.arrowImageView9.mas_left).offset(-(offset));
                }];
            } else {
                [self origin_btn8_Constraint];
            }
        }
    }
    

    if ([self isEmptyString:model.right_arrowImageString9]) {
        __weak typeof(self) weakSelf = self;
        // 布局 arrow箭头图片
        [_arrowImageView9 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.right.equalTo(weakSelf.rightWrapView);
            make.width.height.equalTo(@0);
        }];
        _arrowImageView9.hidden = YES;
    } else {
        [self origin_arrowImageView9_Constraint];
        _arrowImageView9.hidden = NO;
        self.arrowImageView9.image = [UIImage imageNamed:model.right_arrowImageString9];
    }
}

- (BOOL)isEmptyString:(NSString *)string {
    return string == nil || [string isEqualToString:@""];
}

- (void)create_left_right {
    // 左
    CKJLeftView *leftWrapView = [CKJLeftView new];
    
    UIButton *imageBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    imageBtn2.userInteractionEnabled = NO;
    [leftWrapView addSubview:imageBtn2];
    
    
    UILabel *title3 = [UILabel new];
    title3.textColor = [UIColor colorWithRed:63 / 255.0 green:63 / 255.0 blue:63 / 255.0 alpha:1.0];
    title3.font = [UIFont systemFontOfSize:16];
    title3.textAlignment = NSTextAlignmentLeft;
    [leftWrapView addSubview:title3];
    [title3 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [title3 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    UILabel *subTitle4 = [UILabel new];
    subTitle4.numberOfLines = 0;
    subTitle4.textColor = [UIColor lightGrayColor];
    subTitle4.font = [UIFont systemFontOfSize:14];
    subTitle4.textAlignment = NSTextAlignmentLeft;
    [leftWrapView addSubview:subTitle4];
    
    
    // 右
    CKJRightView *rightWrapView = [CKJRightView new];
    
    CKJSwitchView *switchView6 = [[CKJSwitchView alloc] init];
    [switchView6.swicth addTarget:self action:@selector(swicthAction:) forControlEvents:UIControlEventValueChanged];
    [switchView6 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [switchView6 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [rightWrapView addSubview:switchView6];
    
    
    UILabel *alikePriceLabel7 = [UILabel new];
    alikePriceLabel7.textColor = [UIColor lightGrayColor];
    alikePriceLabel7.font = [UIFont systemFontOfSize:14];
    [alikePriceLabel7 setContentHuggingPriority:UILayoutPriorityRequired - 1 forAxis:UILayoutConstraintAxisHorizontal];
    [alikePriceLabel7 setContentCompressionResistancePriority:UILayoutPriorityRequired - 1 forAxis:UILayoutConstraintAxisHorizontal];
    [rightWrapView addSubview:alikePriceLabel7];
    
    
    CKJUIButton8 *btn8 = [CKJUIButton8 buttonWithType:(UIButtonTypeCustom)];
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
    
    // 附加 view1
    CKJAdditionView *view1 = [CKJAdditionView new];
    
    // 中
    CKJAdditionView *view5 = [CKJAdditionView new];
    
    // 附加
    CKJAdditionView *view10 = [CKJAdditionView new];
    
    self.view1 = view1;
    self.view5 = view5;
    self.view10 = view10;
}


- (void)origin_btn8_Constraint {
    __weak typeof(self) weakSelf = self;
    [_btn8 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.btn8.superview);
        make.right.equalTo(weakSelf.arrowImageView9.mas_left);
    }];
}
- (void)origin_arrowImageView9_Constraint {
    __weak typeof(self) weakSelf = self;
    [_arrowImageView9 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.rightWrapView);
        make.right.equalTo(weakSelf.rightWrapView).offset(-margin);
        make.width.equalTo(@(arrowImageView9_w));
        make.height.equalTo(weakSelf.arrowImageView9.mas_width).multipliedBy(1.5);
    }];
}

- (void)swicthAction:(UISwitch *)swicth {
    BOOL on = swicth.on;
    CKJCellModel *model = (CKJCellModel *)self.cellModel;
    model.switchOn = on;
    if (model.swicthBlock) {
        model.swicthBlock(on, self, swicth);
    }
}

- (UIColor *)arc4Color {
    return [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1];
}

- (void)create_topLabel_bottomLabel:(UIView *)superView {
    
    UILabel *title = [UILabel new];
    [superView addSubview:title];
    self.view5_topLabel = title;
    
    UILabel *subTitle = [UILabel new];
    subTitle.textColor = [UIColor lightGrayColor];
    subTitle.font = [UIFont systemFontOfSize:14];
    [superView addSubview:subTitle];
    self.view5_bottomLabel = subTitle;
    
    [title setContentHuggingPriority:240 forAxis:UILayoutConstraintAxisHorizontal];
    [title setContentCompressionResistancePriority:740 forAxis:UILayoutConstraintAxisHorizontal];
    
    [subTitle setContentHuggingPriority:240 forAxis:UILayoutConstraintAxisHorizontal];
    [subTitle setContentCompressionResistancePriority:740 forAxis:UILayoutConstraintAxisHorizontal];
    
    [self layoutTopBottomLabel];
}

- (void)layoutTopBottomLabel {
    
    CKJCellModel *model = self.cellModel;
    
    UILabel *title = self.view5_topLabel;
    UILabel *subTitle = self.view5_bottomLabel;
    UIView *superView = title.superview;
    
    NSString *topText = model.view5_topText.string;
    NSString *bottomText = model.view5_bottomText.string;
    
    title.attributedText = model.view5_topText;
    subTitle.attributedText = model.view5_bottomText;
    
    CGFloat topBottomMargin = 6;
    if ([self.ckjCellDataSource respondsToSelector:@selector(view5_setup_top_title_marginTo_bottom_subTitle_Atsection:row:cell:)]) {
        CGFloat dataSourceMargin = [self.ckjCellDataSource  view5_setup_top_title_marginTo_bottom_subTitle_Atsection:0 row:0 cell:self];
        if (dataSourceMargin >= 0) {
            topBottomMargin = dataSourceMargin;
        }
    }
    
    // 如果不显示文字，那就让上下之间的间距为0
    if ([self isEmptyString:topText] && [self isEmptyString:bottomText]) {
        topBottomMargin = 0;
    }
    
    // 默认文字和顶部底部的间距
    CGFloat flagMargin = 10;
    
    [title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(superView.mas_centerY).offset(-(topBottomMargin / 2.0));
        make.left.right.equalTo(superView);
        if (self.cellModel.cellHeight > 0) {
        } else {
            make.top.equalTo(superView).offset(flagMargin);
        }
    }];
    
    [subTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_centerY).offset(topBottomMargin / 2.0);
        make.left.right.equalTo(superView);
        if (self.cellModel.cellHeight > 0) {
        } else {
            make.bottom.equalTo(superView).offset(-flagMargin);
        }
    }];
}

- (void)btnAction:(UIButton *)sender {
    if (self.cellModel.btn8Model.btnBlock) {
        self.cellModel.btn8Model.btnBlock(self, sender);
    }
}


@end



