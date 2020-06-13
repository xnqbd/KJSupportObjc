//
//  CKJDemoCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/17.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJDemoCell.h"


@implementation CKJDemoCell1Model

@end

@implementation CKJDemoCell1


- (void)setupData:(nonnull CKJDemoCell1Model *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *_Nonnull)indexPath tableView:(CKJSimpleTableView *_Nonnull)tableView {
    if ([model isKindOfClass:[CKJCommonCellModel class]] == NO) return;
    
//    self.titleLab.attributedText = WDKJ_ConfirmAttString(model.title);
//    self.subTitleLab.attributedText = WDKJ_ConfirmAttString(model.subTitle);
//    self.threeLab.attributedText = WDKJ_ConfirmAttString(model.threeTitle);
//    self.fourLab.attributedText = WDKJ_ConfirmAttString(model.fourTitle);
//    self.fiveLab.attributedText = WDKJ_ConfirmAttString(model.fiveTitle);
//
//
//
//    self.titleLab.text = WDKJ_ConfirmString(model.title);
//    self.subTitleLab.text = WDKJ_ConfirmString(model.subTitle);
//    self.threeLab.text = WDKJ_ConfirmString(model.threeTitle);
//    self.fourLab.text = WDKJ_ConfirmString(model.fourTitle);
//    self.fiveLab.text = WDKJ_ConfirmString(model.fiveTitle);
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    BOOL debug = YES;
    if (debug) {
        self.imageV.backgroundColor = [UIColor redColor];
        self.titleLab.backgroundColor = [UIColor purpleColor];
        self.subTitleLab.backgroundColor = [UIColor yellowColor];
        self.threeLab.backgroundColor = [UIColor greenColor];
        self.fourLab.backgroundColor = [UIColor blueColor];
        self.fiveLab.backgroundColor = [UIColor redColor];
    }
}


- (void)setupSubViews {

    UIView *bgV = self.subviews_SuperView;

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

    CGSize imageSize = CGSizeMake(100, 75);
    CGFloat imageleftMargin = 15;

    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgV);
        make.left.equalTo(bgV).offset(imageleftMargin);
        make.width.equalTo(@(imageSize.width));
        make.height.equalTo(@(imageSize.height));
    }];



    
    

    CGFloat superview_margin_title = 13;
    CGFloat image_margin_title = 7;

    CGFloat title_RightMargin = 10;
    CGFloat title_margin_subTitle = 4;
    
    CGFloat centerMargin = 0;
    

    CGFloat subTitle_RightMargin = title_RightMargin;
    CGFloat subTitle_margin_threeLab = centerMargin;

    CGFloat threeLab_RightMargin = title_RightMargin;
    CGFloat threeLab_margin_fourLab = centerMargin;

    CGFloat fourLab_RightMargin = title_RightMargin;
    CGFloat fourLab_margin_fiveLab = centerMargin;

    CGFloat fiveLab_RightMargin = title_RightMargin;
    CGFloat fiveLab_margin_SuperView = superview_margin_title;


    id temp = self.subviews_SuperView.mas_right;

    [title kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(imageV.mas_right).offset(image_margin_title);
        make.top.equalTo(superview).offset(superview_margin_title);
        make.right.equalTo(temp).offset(-(title_RightMargin));
        make.bottom.equalTo(subTitle.mas_top).offset(-(title_margin_subTitle));
    }];
    [subTitle kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(title.mas_left);
        make.right.equalTo(temp).offset(-(subTitle_RightMargin));
    make.bottom.equalTo(self.threeLab.mas_top).offset(-(subTitle_margin_threeLab));
//        make.bottom.equalTo(superview).offset(-(superview_margin_title));
    }];
    [self.threeLab kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(self.titleLab);
        make.right.equalTo(temp).offset(-(threeLab_RightMargin));
        make.bottom.equalTo(self.fourLab.mas_top).offset(-(threeLab_margin_fourLab));
        //        make.bottom.equalTo(superview).offset(-(superview_margin_title));
    }];
    [self.fourLab kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(self.titleLab);
        make.right.equalTo(temp).offset(-(fourLab_RightMargin));
        make.bottom.equalTo(self.fiveLab.mas_top).offset(-(fourLab_margin_fiveLab));
//        make.bottom.equalTo(superview).offset(-(superview_margin_title));
    }];
    [self.fiveLab kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(self.titleLab);
        make.right.equalTo(temp).offset(-(fiveLab_RightMargin));
        make.bottom.equalTo(superview).offset(-(fiveLab_margin_SuperView));
    }];


    BOOL debug = NO;
    if (debug) {
        self.imageV.backgroundColor = [UIColor redColor];
        self.titleLab.backgroundColor = [UIColor purpleColor];
        self.subTitleLab.backgroundColor = [UIColor yellowColor];
        self.threeLab.backgroundColor = [UIColor greenColor];
        self.fourLab.backgroundColor = [UIColor blueColor];
        self.fiveLab.backgroundColor = [UIColor redColor];
    }
}



@end
