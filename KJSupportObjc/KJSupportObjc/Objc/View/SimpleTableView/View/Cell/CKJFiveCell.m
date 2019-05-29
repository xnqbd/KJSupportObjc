//
//  CKJPayStyleCell.m
//  WDYHFSDK
//
//  Created by chenkaijie on 2018/12/7.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CKJFiveCell.h"
#import <Masonry/Masonry.h>
#import <objc/message.h>

@implementation CKJFiveCellConfig

+ (nonnull instancetype)fiveCellConfigWithImageSize:(CGSize)imageSize image_margin_title:(CGFloat)image_margin_title topBottomMargin:(CGFloat)topBottomMargin centerMargin:(CGFloat)centerMargin {
    CKJFiveCellConfig *config = [[self alloc] init];
    config.leftImageSize = imageSize;
    config.image_margin_title = image_margin_title;
    
    config.superview_margin_title = topBottomMargin;
    config.fifthLab_margin_SuperView = topBottomMargin;
    
    config.title_margin_subTitle = centerMargin;
    config.subTitle_margin_thirdLab = centerMargin;
    config.thirdLab_margin_fourthLab = centerMargin;
    config.fourthLab_margin_fifthLab = centerMargin;
    
    return config;
}
+ (nonnull instancetype)configWithDetailSettingBlock:(nullable CKJFiveCellConfigBlock)detailSettingBlock {
    return [super configWithDetailSettingBlock:detailSettingBlock];
}

- (instancetype)init {
    if (self = [super init]) {
        self.leftImageSize = CGSizeZero;
        self.leftImageView_MarginToSuperViewLeft = 0;
        
        CGFloat superview_margin_title = 10;
        
        self.superview_margin_title = superview_margin_title;
        self.fifthLab_margin_SuperView = superview_margin_title;
        
        self.title_margin_subTitle = 5;
    }
    return self;
}

@end

@implementation CKJFiveCellModel

+ (nonnull instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJFiveCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJFiveCellModelRowBlock)didSelectRowBlock {
    return [super modelWithCellHeight:cellHeight cellModel_id:cellModel_id detailSettingBlock:detailSettingBlock didSelectRowBlock:didSelectRowBlock];
}

@end

@implementation CKJFiveCell

- (void)setupData:(CKJFiveCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    if ([model isKindOfClass:[CKJFiveCellModel class]] == NO) return;
    
    self.titleLab.attributedText = WDKJ_ConfirmAttString(model.title);
    self.subTitleLab.attributedText = WDKJ_ConfirmAttString(model.subTitle);
    self.threeLab.attributedText = WDKJ_ConfirmAttString(model.thirdTitle);
    self.fourLab.attributedText = WDKJ_ConfirmAttString(model.fourthTitle);
    self.fiveLab.attributedText = WDKJ_ConfirmAttString(model.fifthTitle);

    self.radioBtn.selected = model.radio_Selected;
    
    UIImage *imageName = model.left_ImageName;
    NSString *image_URL = model.left_Image_URL;
    
    if (WDKJ_IsNullObj(imageName, [UIImage class])) {
        if (WDKJ_IsEmpty_Str(image_URL) ) {
        } else {
            NSURL *url = [NSURL kjwd_URLWithString:image_URL];
            UIImage *placeholderImage = nil;
            if (WDKJ_IsNullObj(model.placeholderImage, [UIImage class])) {
                placeholderImage = nil;
            } else {
                placeholderImage = model.placeholderImage;
            }
            NSString *temp1 = @"sd_setImageWithURL:placeholderImage:";
            
            SEL sel = NSSelectorFromString(temp1);
            if ([self.imageV respondsToSelector:sel]) {
                
                void (*kj_sengMsg)(id, SEL, NSURL *, UIImage *) = (void (*)(id, SEL, NSURL *, UIImage *))objc_msgSend;
                
                kj_sengMsg(self.imageV, sel_registerName([temp1 UTF8String]), url, placeholderImage);
//                [self.imageV sd_setImageWithURL:[NSURL URLWithString:@"https://ps.ssl.qhmsg.com/sdr/400__/t01c8515616311ff6b9.jpg"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
            }
        }
    } else {
        self.imageV.image = imageName;
    }
    
    [self installData:model section:section row:row selectIndexPath:indexPath tableView:tableView];
}
- (void)installData:(__kindof CKJFiveCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    
}


- (void)click_RadioBtn {
    
}


- (void)setupSubViews {
    
    
    CKJFiveCellConfig *config  = self.configDic[configDicKEY_ConfigModel];
    
    
    WDCKJ_ifDEBUG(^{
        if (config == nil || ([config isKindOfClass:[CKJFiveCellConfig class]] == NO)) {
            NSException *exception = [NSException exceptionWithName:@"未配置Config对象" reason:[NSString stringWithFormat:@"%@警告！请配置一个 CKJFiveCellConfig或它的子类", self] userInfo:nil];
            [exception raise];
        }
    }, nil);
    
    
    UIView *bgV = self.bgV;
    
    UIImageView *imageV = [[UIImageView alloc] init];
    [bgV addSubview:imageV];
    self.imageV = imageV;
    
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
    
    
    
    UILabel *rightWrapperLabel = [[UILabel alloc] init];
    rightWrapperLabel.userInteractionEnabled = YES;
    [bgV addSubview:rightWrapperLabel];
    self.rightWrapperLabel = rightWrapperLabel;
    
    
    CGSize imageSize = config.leftImageSize;
    CGFloat imageVleftMargin = config.leftImageView_MarginToSuperViewLeft;
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgV);
        make.left.equalTo(bgV).offset(imageVleftMargin);
        make.width.equalTo(@(imageSize.width));
        make.height.equalTo(@(imageSize.height));
    }];
    
    
    
    
    CGFloat superview_margin_title = config.superview_margin_title;
    CGFloat image_margin_title = config.image_margin_title;
    
    CGFloat title_RightMargin = config.title_RightMargin;
    CGFloat title_margin_subTitle = config.title_margin_subTitle;
    
    CGFloat subTitle_RightMargin = config.subTitle_RightMargin;
    CGFloat subTitle_margin_thirdLab = config.subTitle_margin_thirdLab;
    
    CGFloat thirdLab_RightMargin = config.thirdLab_RightMargin;
    CGFloat thirdLab_margin_fourthLab = config.thirdLab_margin_fourthLab;
    
    CGFloat fourthLab_margin_fifthLab = config.fourthLab_margin_fifthLab;
    CGFloat fourthLab_RightMargin = config.fourthLab_RightMargin;
    
    CGFloat fifthLab_margin_SuperView = config.fifthLab_margin_SuperView;
    CGFloat fifthLab_RightMargin = config.fifthLab_RightMargin;
    
    
    id temp = rightWrapperLabel.mas_left;
    
    [title kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(imageV.mas_right).offset(image_margin_title);
        make.top.equalTo(superview).offset(superview_margin_title);
        make.right.equalTo(temp).offset(-(title_RightMargin));
        make.bottom.equalTo(subTitle.mas_top).offset(-(title_margin_subTitle));
    }];
    [subTitle kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(title.mas_left);
        make.right.equalTo(temp).offset(-(subTitle_RightMargin));
        make.bottom.equalTo(self.threeLab.mas_top).offset(-(subTitle_margin_thirdLab));
    }];
    [self.threeLab kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(self.titleLab);
        make.right.equalTo(temp).offset(-(thirdLab_RightMargin));
        make.bottom.equalTo(self.fourLab.mas_top).offset(-(thirdLab_margin_fourthLab));
    }];
    [self.fourLab kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(self.titleLab);
        make.bottom.equalTo(self.fiveLab.mas_top).offset(-(fourthLab_margin_fifthLab));
        make.right.equalTo(temp).offset(-(fourthLab_RightMargin));
    }];
    [self.fiveLab kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(self.titleLab);
        make.bottom.equalTo(superview).offset(-(fifthLab_margin_SuperView));
        make.right.equalTo(temp).offset(-(fifthLab_RightMargin));
    }];
    
    [rightWrapperLabel kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.top.right.bottom.equalTo(superview);
    }];
    
    UIButton *radioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [radioBtn addTarget:self action:@selector(click_RadioBtn) forControlEvents:UIControlEventTouchUpInside];
    [rightWrapperLabel addSubview:radioBtn];
    self.radioBtn = radioBtn;
    
    BOOL debug = NO;
    if (debug) {
        self.imageV.backgroundColor = [UIColor redColor];
        self.titleLab.backgroundColor = [UIColor purpleColor];
        self.subTitleLab.backgroundColor = [UIColor yellowColor];
        self.threeLab.backgroundColor = [UIColor greenColor];
        self.fourLab.backgroundColor = [UIColor blueColor];
        self.fiveLab.backgroundColor = [UIColor redColor];
        self.rightWrapperLabel.backgroundColor = [UIColor magentaColor];
        self.radioBtn.backgroundColor = [UIColor brownColor];
    }
}


@end
