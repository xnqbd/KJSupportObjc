//
//  CKJPayStyleCell.h
//  WDYHFSDK
//
//  Created by chenkaijie on 2018/12/7.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CKJCommonTableViewCell.h"



/** 安装的个数， 3、4、5个 */
#define configDicKEY_CKJPayStyleCellInstall @"configDicKEY_CKJPayStyleCellInstall"




@interface CKJPayStyleCellModel : CKJCommonCellModel


@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subTitle;
@property (copy, nonatomic) NSString *thirdTitle;
@property (copy, nonatomic) NSString *fourthTitle;
@property (copy, nonatomic) NSString *fifthTitle;

@property (copy, nonatomic) NSString *image;


@end



NS_ASSUME_NONNULL_BEGIN

@interface CKJPayStyleCell : CKJCommonTableViewCell


@property (weak, nonatomic) UILabel *titleLab;
@property (weak, nonatomic) UILabel *subTitleLab;
@property (weak, nonatomic) UILabel *thirdLab;
@property (weak, nonatomic) UILabel *fourthLab;
@property (weak, nonatomic) UILabel *fifthLab;

@property (weak, nonatomic) UIImageView *imageV;

@property (weak, nonatomic) UIButton *btn;

/**
 title和SuperView之间的距离
 */
@property (assign, nonatomic, readonly) CGFloat topBottomMargin;

/**
 title和subTitle之间的距离
 */
@property (assign, nonatomic, readonly) CGFloat itemVerticalMargin;


@property (assign, nonatomic, readonly) CGFloat image2TitleMargin;


@end

NS_ASSUME_NONNULL_END
