//
//  KJCell.m
//  RAC空项目
//
//  Created by chenkaijie on 2018/1/19.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "KJCell.h"
#import <Masonry/Masonry.h>

@interface KJSwitchView : UIView
@property (strong, nonatomic) UISwitch *swicth;
@end

@implementation KJSwitchView
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

@interface AdditionView : UIView
@end
@implementation AdditionView
@end

@interface LeftView : UIView
@end
@implementation LeftView
@end

@interface RightView : UIView
@end
@implementation RightView
@end


@interface KJCell ()

@property (strong, nonatomic) AdditionView *view1;

@property (strong, nonatomic) LeftView *leftWrapView;
@property (strong, nonatomic) UIButton *imageBtn2;
@property (strong, nonatomic) UILabel *left_title3;
@property (strong, nonatomic) UILabel *left_subTitle4;

@property (strong, nonatomic) AdditionView *view5;

@property (strong, nonatomic) RightView *rightWrapView;
@property (strong, nonatomic) KJSwitchView *kjSwitch6;
@property (strong, nonatomic) UILabel *alikePriceLabel7;
@property (strong, nonatomic) UIImageView *imageView8;
@property (strong, nonatomic) UIImageView *arrowImageView9;


@property (strong, nonatomic) AdditionView *view10;

@end

@implementation KJCell


/*
 附加 View1
 左   leftWrapView (imageBtn2   left_title3   left_subTitle4)
 中   View5
 右   rightWrapView (kjSwitch6  alikePriceLabel7   imageView8   arrowImageBtn9)
 附加  View10
 */

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}


#define imageBtn2_w_h  30
#define arrowImageView9_w  15
#define kjSwitch6_w  60

// 控件右边间距， 比如文字
#define Right_Margin (-8)



#define margin 15.0

- (void)setupUI {
    
    [self create_left_right];
    [self create_center_additional];
    
    __weak UIView *contentView = self.contentView;
    __weak typeof(self) weakSelf = self;
    
    [contentView addSubview:_leftWrapView];
    [contentView addSubview:_rightWrapView];
    
    
    //默认只有 left 和 right,  没有 view1、center、view10
    BOOL add_view1 = NO;
    BOOL add_view5 = NO;
    BOOL add_view10 = NO;
    
    UIView *left_of_leftWrapView = contentView;
    UIView *right_of_leftWrapView = _rightWrapView;
    UIView *right_of_rightWrapView = contentView;
    
    
    if (add_view1) {
        left_of_leftWrapView = self.view1;
    }
    if (add_view5) {
        right_of_leftWrapView = self.view5;
    }
    if (add_view10) {
        right_of_rightWrapView = self.view10;
    }
    
    if (add_view1) {
        [contentView addSubview:_view1];
        [_view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(contentView);
            // 一般图片大小设置为固定
            make.width.equalTo(@(15));
        }];
    }
    // 中
    if (add_view5) {
        [contentView addSubview:_view5];
        [_view5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(contentView);
            make.right.equalTo(weakSelf.rightWrapView.mas_left);
            // 一般图片大小设置为固定
            make.width.equalTo(@(20));
        }];
    }
    
    //附加
    if (add_view10) {
        [contentView addSubview:_view10];
        [_view10 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(contentView);
            // 给一个初始宽度
            make.width.equalTo(@(15));
        }];
    }
    
    
    // 左
    [_imageBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftWrapView).offset(margin);
        make.centerY.equalTo(weakSelf.leftWrapView);
        make.right.equalTo(weakSelf.left_title3.mas_left);
        // 一般图片大小设置为固定
        make.width.height.equalTo(@(imageBtn2_w_h));
    }];
    [_left_title3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf.leftWrapView);
        make.right.equalTo(weakSelf.left_subTitle4.mas_left).offset(Right_Margin);
    }];
    [_left_subTitle4 mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.right.equalTo(right_of_leftWrapView.mas_left);
    }];
    
    /*
     附加 View1
     左   leftWrapView (imageBtn2   left_title3   left_subTitle4)
     中   View5
     右   rightWrapView (kjSwitch6  alikePriceLabel7   imageView8   arrowImageBtn9)
     附加  View10
     */
    
    // 右
    [_kjSwitch6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(weakSelf.rightWrapView);
        make.right.equalTo(weakSelf.alikePriceLabel7.mas_left);
        make.width.equalTo(@(kjSwitch6_w));
    }];
    [_alikePriceLabel7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf.rightWrapView);
        make.right.equalTo(weakSelf.imageView8.mas_left).offset(Right_Margin);
    }];
    [self origin_imageView8_Constraint];
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
        self.left_title3.backgroundColor = [UIColor brownColor];
        self.left_subTitle4.backgroundColor = [UIColor yellowColor];
        
        self.view5.backgroundColor = [UIColor cyanColor];
        
        self.kjSwitch6.backgroundColor = [UIColor blueColor];
        //        self.rightWrapView.backgroundColor = [UIColor darkGrayColor];
        self.alikePriceLabel7.backgroundColor = [UIColor greenColor];
        self.imageView8.backgroundColor = [UIColor redColor];
        self.arrowImageView9.backgroundColor = [UIColor grayColor];
        
        self.view10.backgroundColor = [UIColor blackColor];
    }
    
    
    
}

- (void)setupData:(CommonTableViewCellModel *)cellModel section:(NSInteger)section row:(NSInteger)row tableView:(UITableView *)tableView {
    /*
     不建议 调整左右间距， 如果想要调整左右间距， 可以通过拼接字符串或其他方式
     */
    
    KJCellModel *model = (KJCellModel *)self.cellModel;
    NSString *imageString = model.left_ImageString2;
    if ([self isEmptyString:imageString]) {
        [_imageBtn2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@0);
        }];
    } else {
        [self.imageBtn2 setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
        [_imageBtn2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@(imageBtn2_w_h));
        }];
    }
    
    self.left_title3.text = model.left_Title3;
    self.left_subTitle4.text = model.left_subTitle4;
    
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
        NSLog(@"%@ ", model.switchOn ? @"开" : @"关");
        self.kjSwitch6.swicth.on = model.switchOn;
    }
    self.alikePriceLabel7.text = model.right_alikePrice7;
    
    
    if ([self isEmptyString:model.right_imageViewString8]) {
        __weak typeof(self) weakSelf = self;
        [_imageView8 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.rightWrapView);
            make.right.equalTo(weakSelf.arrowImageView9.mas_left).offset(Right_Margin);
            make.width.equalTo(@0);
        }];
        _imageView8.hidden = YES;
    } else {
        [self origin_imageView8_Constraint];
        _imageView8.hidden = NO;
        self.imageView8.image = [UIImage imageNamed:model.right_imageViewString8];
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
    LeftView *leftWrapView = [LeftView new];
    
    UIButton *imageBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    imageBtn2.userInteractionEnabled = NO;
    [leftWrapView addSubview:imageBtn2];
    
    
    UILabel *left_title3 = [UILabel new];
    left_title3.textColor = [UIColor colorWithRed:63 / 255.0 green:63 / 255.0 blue:63 / 255.0 alpha:1.0];
    left_title3.font = [UIFont systemFontOfSize:16];
    left_title3.textAlignment = NSTextAlignmentLeft;
    [leftWrapView addSubview:left_title3];
    [left_title3 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [left_title3 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    UILabel *left_subTitle4 = [UILabel new];
    left_subTitle4.numberOfLines = 0;
    left_subTitle4.textColor = [UIColor lightGrayColor];
    left_subTitle4.font = [UIFont systemFontOfSize:14];
    left_subTitle4.textAlignment = NSTextAlignmentLeft;
    [leftWrapView addSubview:left_subTitle4];
    
    
    // 右
    RightView *rightWrapView = [RightView new];
    
    KJSwitchView *switchView6 = [[KJSwitchView alloc] init];
    [switchView6.swicth addTarget:self action:@selector(swicthAction:) forControlEvents:UIControlEventValueChanged];
    [switchView6 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [switchView6 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [rightWrapView addSubview:switchView6];
    
    
    UILabel *alikePriceLabel7 = [UILabel new];
    alikePriceLabel7.textColor = [UIColor lightGrayColor];
    alikePriceLabel7.font = [UIFont systemFontOfSize:14];
    [rightWrapView addSubview:alikePriceLabel7];
    [alikePriceLabel7 setContentHuggingPriority:UILayoutPriorityRequired - 1 forAxis:UILayoutConstraintAxisHorizontal];
    [alikePriceLabel7 setContentCompressionResistancePriority:UILayoutPriorityRequired - 1 forAxis:UILayoutConstraintAxisHorizontal];
    
    
    UIImageView *imageView8 = [UIImageView new];
    [imageView8 setContentHuggingPriority:UILayoutPriorityRequired - 2 forAxis:UILayoutConstraintAxisHorizontal];
    [imageView8 setContentCompressionResistancePriority:UILayoutPriorityRequired - 2 forAxis:UILayoutConstraintAxisHorizontal];
    [rightWrapView addSubview:imageView8];
    
    // UIViewContentModeScaleAspectFill
    // UIViewContentModeScaleAspectFit
    // UIViewContentModeScaleToFill
    // 右边箭头图片
    UIImageView *arrowImageView9 = [UIImageView new];
    arrowImageView9.contentMode = UIViewContentModeScaleAspectFit;
    [rightWrapView addSubview:arrowImageView9];
    
    self.leftWrapView = leftWrapView;
    self.imageBtn2 = imageBtn2;
    self.left_title3 = left_title3;
    self.left_subTitle4 = left_subTitle4;
    
    self.rightWrapView = rightWrapView;
    self.kjSwitch6 = switchView6;
    self.alikePriceLabel7 = alikePriceLabel7;
    self.imageView8 = imageView8;
    self.arrowImageView9 = arrowImageView9;
}

- (void)create_center_additional {
    
    // 附加 view1
    AdditionView *view1 = [AdditionView new];
    
    // 中
    AdditionView *view5 = [AdditionView new];
    
    // 附加
    AdditionView *view10 = [AdditionView new];
    
    self.view1 = view1;
    self.view5 = view5;
    self.view10 = view10;
}

- (void)origin_imageView8_Constraint {
    __weak typeof(self) weakSelf = self;
    [_imageView8 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.rightWrapView);
        make.right.equalTo(weakSelf.arrowImageView9.mas_left).offset(Right_Margin);
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
    KJCellModel *model = (KJCellModel *)self.cellModel;
    model.switchOn = on;
    if (model.swicthBlock) {
        model.swicthBlock(on);
    }
}

- (UIColor *)arc4Color {
    return [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1];
}


@end



