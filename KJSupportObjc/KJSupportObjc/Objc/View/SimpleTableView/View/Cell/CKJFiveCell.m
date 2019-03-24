//
//  CKJPayStyleCell.m
//  WDYHFSDK
//
//  Created by chenkaijie on 2018/12/7.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CKJFiveCell.h"
#import <Masonry/Masonry.h>
#import "NSObject+WDYHFCategory.h"

@implementation CKJFiveCellModel

- (NSString *)image_Name {
   return WDKJ_ConfirmString(_image_Name);
}

@end

@implementation CKJFiveCell

- (void)setupData:(CKJFiveCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    self.titleLab.text = WDKJ_ConfirmString(model.title);
    self.subTitleLab.text = WDKJ_ConfirmString(model.subTitle);
    self.thirdLab.text = WDKJ_ConfirmString(model.thirdTitle);
    self.fourthLab.text = WDKJ_ConfirmString(model.fourthTitle);
    self.fifthLab.text = WDKJ_ConfirmString(model.fifthTitle);
    [self installData:model section:section row:row selectIndexPath:indexPath tableView:tableView];
}

- (void)installData:(CKJFiveCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    // 子类需要重写此方法，完成左边图片的设置
    // self.imageV.image = [UIImage kjwd_imageNamed:model.image_Name];
}

- (void)chooseBtnAction {
    
}


- (void)setupSubViews {
    
    UIView *bgV = self.bgV;
    
    UIImageView *imageV = [[UIImageView alloc] init];
    [bgV addSubview:imageV];
    self.imageV = imageV;
    
    UILabel *title = [UILabel new];
    title.text = @"";  // 支付宝
    [bgV addSubview:title];
    self.titleLab = title;
    
    UILabel *subTitle = [UILabel new];
    subTitle.text = @""; // 推荐有支付宝账户的用户使用
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
    
    self.thirdLab = createLab();
    self.fourthLab = createLab();
    self.fifthLab = createLab();
    
    [title          setContentHuggingPriority:251 forAxis:UILayoutConstraintAxisVertical];
    [subTitle       setContentHuggingPriority:250 forAxis:UILayoutConstraintAxisVertical];
    [self.thirdLab  setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisVertical];
    [self.fourthLab setContentHuggingPriority:248 forAxis:UILayoutConstraintAxisVertical];
    [self.fifthLab  setContentHuggingPriority:247 forAxis:UILayoutConstraintAxisVertical];
    
    
    [title          setContentCompressionResistancePriority:750 forAxis:UILayoutConstraintAxisVertical];
    [subTitle       setContentCompressionResistancePriority:749 forAxis:UILayoutConstraintAxisVertical];
    [self.thirdLab  setContentCompressionResistancePriority:748 forAxis:UILayoutConstraintAxisVertical];
    [self.fourthLab setContentCompressionResistancePriority:747 forAxis:UILayoutConstraintAxisVertical];
    [self.fifthLab  setContentCompressionResistancePriority:746 forAxis:UILayoutConstraintAxisVertical];
    
    
    
    UILabel *rightWrapperLabel = [[UILabel alloc] init];
    rightWrapperLabel.userInteractionEnabled = YES;
    [bgV addSubview:rightWrapperLabel];
    self.rightWrapperLabel = rightWrapperLabel;
    
    CGFloat margin = 15;
    
    CGSize size = self.imageSize;
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgV);
        make.left.equalTo(bgV).offset(margin);
        make.width.equalTo(@(size.width));
        make.height.equalTo(@(size.height));
    }];
    
    
    CGFloat superview_margin_title = self.superview_margin_title;
    
    id temp = rightWrapperLabel.mas_left;
    
    [title kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(imageV.mas_right).offset(self.image_margin_title);
        make.top.equalTo(superview).offset(superview_margin_title);
        make.right.equalTo(temp).offset(-(self.title_RightMargin));
        make.bottom.equalTo(subTitle.mas_top).offset(-(self.title_margin_subTitle));
    }];
    [subTitle kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(title.mas_left);
        make.right.equalTo(temp).offset(-(self.subTitle_RightMargin));
        make.bottom.equalTo(self.thirdLab.mas_top).offset(-(self.subTitle_margin_thirdLab));
    }];
    [self.thirdLab kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(self.titleLab);
        make.right.equalTo(temp).offset(-(self.thirdLab_RightMargin));
        make.bottom.equalTo(self.fourthLab.mas_top).offset(-(self.thirdLab_margin_fourthLab));
    }];
    [self.fourthLab kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(self.titleLab);
        make.bottom.equalTo(self.fifthLab.mas_top).offset(-(self.fourthLab_margin_fifthLab));
        make.right.equalTo(temp).offset(-(self.fourthLab_RightMargin));
    }];
    [self.fifthLab kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(self.titleLab);
        make.bottom.equalTo(superview).offset(-(superview_margin_title));
        make.right.equalTo(temp).offset(-(self.fifthLab_RightMargin));
    }];
    
    
    
    [rightWrapperLabel kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.top.right.bottom.equalTo(superview);
    }];
    
    
    
    UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [chooseBtn addTarget:self action:@selector(chooseBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [rightWrapperLabel addSubview:chooseBtn];
    self.chooseBtn = chooseBtn;
    
    
    BOOL debug = NO;
    if (debug) {
        self.titleLab.backgroundColor = [UIColor purpleColor];
        self.subTitleLab.backgroundColor = [UIColor yellowColor];
        self.thirdLab.backgroundColor = [UIColor greenColor];
        self.fourthLab.backgroundColor = [UIColor blueColor];
        self.fifthLab.backgroundColor = [UIColor redColor];
//        self.rightWrapperLabel.backgroundColor = [UIColor brownColor];
        self.chooseBtn.backgroundColor = [UIColor brownColor];
    }
}

- (CGFloat)superview_margin_title {
    return 10;
}
- (CGFloat)title_margin_subTitle {
    return 5;
}
- (CGFloat)subTitle_margin_thirdLab {
    return 0;
}
- (CGFloat)thirdLab_margin_fourthLab {
    return 0;
}
- (CGFloat)fourthLab_margin_fifthLab {
    return 0;
}
- (CGFloat)fifthLab_margin_SuperView {
    return 0;
}



- (CGFloat)title_RightMargin {
    return 8;
}
- (CGFloat)subTitle_RightMargin {
    return self.title_RightMargin;
}
- (CGFloat)thirdLab_RightMargin {
    return self.title_RightMargin;
}
- (CGFloat)fourthLab_RightMargin {
    return self.title_RightMargin;
}
- (CGFloat)fifthLab_RightMargin {
    return self.title_RightMargin;
}





- (CGFloat)image_margin_title {
    return 10;
}
- (CGSize)imageSize {
    return CGSizeMake(40, 40);
}



@end
