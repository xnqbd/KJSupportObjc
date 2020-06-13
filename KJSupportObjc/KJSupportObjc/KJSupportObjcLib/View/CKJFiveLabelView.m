//
//  CKJFiveLabelView.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/7/8.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJFiveLabelView.h"
#import "NSObject+WDYHFCategory.h"

@implementation CKJFiveLabelViewConfig

+ (instancetype)fiveLabelViewConfigWithDetail:(nullable void(^)(__kindof CKJFiveLabelViewConfig *c))detailSettingBlock {
    return [super configWithDetail:detailSettingBlock];
}


- (instancetype)init {
    if (self = [super init]) {

        
        self.title_numberOfLines = 1;
        self.subTitle_numberOfLines = 1;
        self.three_numberOfLines = 1;
        self.four_numberOfLines = 1;
        self.five_numberOfLines = 1;
        
//        CGFloat superview_margin_title = 0;
//
//        self.superview_margin_title = superview_margin_title;
//        self.fifthLab_margin_SuperView = superview_margin_title;
//        self.title_margin_subTitle = 0;
    }
    return self;
}


@end


@implementation CKJFiveLabelModel


//- (instancetype)init {
//    if (self = [super init]) {
//    }
//    return self;
//}


@end


@interface CKJFiveLabelView ()

@property (strong, nonatomic) CKJFiveLabelViewConfig *fiveConfig;

@end

@implementation CKJFiveLabelView


//+ (nonnull instancetype)fiveViewWithConfig:(nonnull CKJFiveLabelViewConfig *)config {
//    CKJFiveLabelView *view = [[self alloc] init];
//
//    return view;
//}

- (instancetype)initWithFrame:(CGRect)frame config:(nonnull CKJFiveLabelViewConfig *)config {
    if (self = [super initWithFrame:frame]) {
        self.fiveConfig = config;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
 
    UIView *bgV = self;
    
    UILabel *title = [UILabel new];
    [bgV addSubview:title];
    self.titleLab = title;
    
    UILabel *subTitle = [UILabel new];
    subTitle.textColor = [UIColor lightGrayColor];
    subTitle.font = [UIFont systemFontOfSize:14];
    [bgV addSubview:subTitle];
    self.subTitleLab = subTitle;
    
    
    UILabel *(^createLab)(void) = ^UILabel *{
        UILabel *lab = [UILabel new];
        lab.textColor = subTitle.textColor;
        lab.font = subTitle.font;
        [bgV addSubview:lab];
        return lab;
    };
    
    self.threeLab = createLab();
    self.fourLab = createLab();
    self.fiveLab = createLab();
    
    [title          setContentHuggingPriority:251 forAxis:UILayoutConstraintAxisVertical];
    [subTitle       setContentHuggingPriority:250 forAxis:UILayoutConstraintAxisVertical];
    [self.threeLab  setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisVertical];
    [self.fourLab setContentHuggingPriority:248 forAxis:UILayoutConstraintAxisVertical];
    [self.fiveLab  setContentHuggingPriority:247 forAxis:UILayoutConstraintAxisVertical];
    
    
    [title          setContentCompressionResistancePriority:750 forAxis:UILayoutConstraintAxisVertical];
    [subTitle       setContentCompressionResistancePriority:749 forAxis:UILayoutConstraintAxisVertical];
    [self.threeLab  setContentCompressionResistancePriority:748 forAxis:UILayoutConstraintAxisVertical];
    [self.fourLab setContentCompressionResistancePriority:747 forAxis:UILayoutConstraintAxisVertical];
    [self.fiveLab  setContentCompressionResistancePriority:746 forAxis:UILayoutConstraintAxisVertical];
    
    
    CKJFiveLabelViewConfig *config = self.fiveConfig;
    
    CGFloat left = config.left_margin;
    CGFloat right = config.right_margin;
    
    
    CGFloat superview_margin_title = config.superview_margin_title;
    
    CGFloat title_margin_subTitle = config.title_margin_subTitle;
    CGFloat subTitle_margin_thirdLab = config.subTitle_margin_thirdLab;
    CGFloat thirdLab_margin_fourthLab = config.thirdLab_margin_fourthLab;
    CGFloat fourthLab_margin_fifthLab = config.fourthLab_margin_fifthLab;
    CGFloat fifthLab_margin_SuperView = config.fifthLab_margin_SuperView;
    
    
    
    
    id temp = self;
    
    [title kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(superview).offset(left);
        make.top.equalTo(superview).offset(superview_margin_title);
        make.right.equalTo(temp).offset(-(right));
        make.bottom.equalTo(subTitle.mas_top).offset(-(title_margin_subTitle));
    }];
    [subTitle kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(title.mas_left);
        make.right.equalTo(temp).offset(-(right));
        make.bottom.equalTo(self.threeLab.mas_top).offset(-(subTitle_margin_thirdLab));
    }];
    [self.threeLab kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(self.titleLab);
        make.right.equalTo(temp).offset(-(right));
        make.bottom.equalTo(self.fourLab.mas_top).offset(-(thirdLab_margin_fourthLab));
    }];
    [self.fourLab kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(self.titleLab);
        make.bottom.equalTo(self.fiveLab.mas_top).offset(-(fourthLab_margin_fifthLab));
        make.right.equalTo(temp).offset(-(right));
    }];
    [self.fiveLab kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(self.titleLab);
        make.bottom.equalTo(superview).offset(-(fifthLab_margin_SuperView));
        make.right.equalTo(temp).offset(-(right));
    }];
    
    
    title.numberOfLines = config.title_numberOfLines;
    subTitle.numberOfLines = config.subTitle_numberOfLines;
    self.threeLab.numberOfLines = config.three_numberOfLines;
    self.fourLab.numberOfLines = config.four_numberOfLines;
    self.fiveLab.numberOfLines = config.five_numberOfLines;
    
    
    
    BOOL debug = NO;
    if (debug) {
        self.titleLab.backgroundColor = [UIColor purpleColor];
        self.subTitleLab.backgroundColor = [UIColor yellowColor];
        self.threeLab.backgroundColor = [UIColor greenColor];
        self.fourLab.backgroundColor = [UIColor blueColor];
        self.fiveLab.backgroundColor = [UIColor redColor];
    }
}
- (void)updateUIWithData:(CKJFiveLabelModel *_Nullable)data {
    self.titleLab.attributedText = WDKJ_ConfirmAttString(data.title);
    self.subTitleLab.attributedText = WDKJ_ConfirmAttString(data.subTitle);
    self.threeLab.attributedText = WDKJ_ConfirmAttString(data.threeTitle);
    self.fourLab.attributedText = WDKJ_ConfirmAttString(data.fourTitle);
    self.fiveLab.attributedText = WDKJ_ConfirmAttString(data.fiveTitle);
}


@end
