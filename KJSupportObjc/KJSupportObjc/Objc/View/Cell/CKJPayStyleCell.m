//
//  CKJPayStyleCell.m
//  WDYHFSDK
//
//  Created by chenkaijie on 2018/12/7.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CKJPayStyleCell.h"

#import <Masonry/Masonry.h>
#import "NSObject+WDYHFCategory.h"

@implementation CKJPayStyleCellModel

@end

@implementation CKJPayStyleCell


- (void)setupData:(CKJPayStyleCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    self.titleLab.text = WDKJ_SpaceString(model.title);
    self.subTitleLab.text = WDKJ_SpaceString(model.subTitle);
    self.imageV.image = [UIImage imageNamed:model.image];
    self.btn.selected = model.selected;
    
    
    NSNumber *installCountNum = self.configDic[configDicKEY_CKJPayStyleCellInstall];
    NSInteger installCount = WDKJ_ConfirmNumber(installCountNum).integerValue;
    
    if (installCount == 3) {
        self.thirdLab.text = WDKJ_SpaceString(model.thirdTitle);
    } else if (installCount == 4) {
        self.thirdLab.text = WDKJ_SpaceString(model.thirdTitle);
        self.fourthLab.text = WDKJ_SpaceString(model.fourthTitle);
    } else if (installCount == 5) {
        self.thirdLab.text = WDKJ_SpaceString(model.thirdTitle);
        self.fourthLab.text = WDKJ_SpaceString(model.fourthTitle);
        self.fifthLab.text = WDKJ_SpaceString(model.fifthTitle);
    }
}


- (void)setupSubViews {
    
    // 默认是两个， title 和 subTitle
    NSNumber *installCountNum = self.configDic[configDicKEY_CKJPayStyleCellInstall];

    NSInteger installCount = WDKJ_ConfirmNumber(installCountNum).integerValue;
   
    UIView *bgV = self.bgV;
    
    UIImageView *imageV = [[UIImageView alloc] init];
    [bgV addSubview:imageV];
    self.imageV = imageV;
    
    UILabel *title = [UILabel new];
    title.text = @"支付宝";
    [bgV addSubview:title];
    self.titleLab = title;
    
    UILabel *subTitle = [UILabel new];
    subTitle.text = @"推荐有支付宝账户的用户使用";
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
    
    
    if (installCount == 3) {
        self.thirdLab = createLab();
    } else if (installCount == 4) {
        self.thirdLab = createLab();
        self.fourthLab = createLab();
    } else if (installCount == 5) {
        self.thirdLab = createLab();
        self.fourthLab = createLab();
        self.fifthLab = createLab();
    }
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgV addSubview:btn];
    self.btn = btn;
    
    CGFloat margin = 15;
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgV);
        make.left.equalTo(bgV).offset(margin);
        make.width.equalTo(@40);
        make.height.mas_equalTo(imageV.mas_width).multipliedBy(1);
    }];
    
    
    
    
    [title kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.top.equalTo(superview).offset(self.topBottomMargin);
        make.left.equalTo(imageV.mas_right).offset(self.image2TitleMargin);
        make.bottom.equalTo(subTitle.mas_top).offset(-(self.itemVerticalMargin));
    }];
    
    [subTitle kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
       if ((installCount == 3) || (installCount == 4) || (installCount == 5)) {
           make.bottom.equalTo(self.thirdLab.mas_top).offset(-(self.itemVerticalMargin));
       } else {
           make.bottom.equalTo(superview).offset(-(self.topBottomMargin));
       }
        make.left.equalTo(title.mas_left);
    }];
    
    
    if (installCount == 3) {
        [self.thirdLab kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
            make.left.equalTo(self.titleLab);
            make.right.equalTo(superview);
            make.bottom.equalTo(superview).offset(-(self.topBottomMargin));
        }];
    } else if (installCount == 4) {
        [self.thirdLab kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
            make.left.equalTo(self.titleLab);
            make.right.equalTo(superview);
            make.bottom.equalTo(self.fourthLab.mas_top).offset(-(self.itemVerticalMargin));
        }];
        [self.fourthLab kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
            make.left.equalTo(self.titleLab);
            make.bottom.equalTo(superview).offset(-(self.topBottomMargin));
            make.right.equalTo(superview);
        }];
    } else if (installCount == 5) {
        [self.thirdLab kjwd_mas_remakeConstraints:^(MASConstraintMaker *make, UIView *superview) {
            make.left.equalTo(self.titleLab);
            make.right.equalTo(superview);
            make.bottom.equalTo(self.fourthLab.mas_top).offset(-(self.itemVerticalMargin));
        }];
        [self.fourthLab kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
            make.left.equalTo(self.titleLab);
            make.bottom.equalTo(self.fifthLab.mas_top).offset(-(self.itemVerticalMargin));
            make.right.equalTo(superview);
        }];
        [self.fifthLab kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
            make.left.equalTo(self.titleLab);
            make.bottom.equalTo(superview).offset(-(self.topBottomMargin));
            make.right.equalTo(superview);
        }];
    }

    
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imageV);
        make.right.equalTo(bgV).offset(-margin);
        make.width.equalTo(@30);
        make.height.mas_equalTo(btn.mas_width).multipliedBy(1);
    }];
}

- (CGFloat)topBottomMargin {
    return 10;
}
- (CGFloat)itemVerticalMargin {
    return 5;
}
- (CGFloat)image2TitleMargin {
    return 10;
}


@end
