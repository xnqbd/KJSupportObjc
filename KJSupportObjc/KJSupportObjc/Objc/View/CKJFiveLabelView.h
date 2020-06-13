//
//  CKJFiveLabelView.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/7/8.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKJBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CKJFiveLabelViewConfig : CKJCommonConfig

#pragma mark - 上下间距

/** SuperView 和 title 之间的距离 (默认0) */
@property (assign, nonatomic) CGFloat superview_margin_title;

/** title和subTitle之间的距离     (默认0) */
@property (assign, nonatomic) CGFloat title_margin_subTitle;

/** subTitle和thirdLab之间的距离  (默认0) */
@property (assign, nonatomic) CGFloat subTitle_margin_thirdLab;

/** thirdLab和fourthLab之间的距离 (默认0) */
@property (assign, nonatomic) CGFloat thirdLab_margin_fourthLab;

/** fourthLab和fifthLab之间的距离 (默认0) */
@property (assign, nonatomic) CGFloat fourthLab_margin_fifthLab;

/** fifthLab和SuperView之间的距离 (默认0) */
@property (assign, nonatomic) CGFloat fifthLab_margin_SuperView;


// 这几个Label 默认都是1行
@property(assign, nonatomic) NSInteger title_numberOfLines;
@property(assign, nonatomic) NSInteger subTitle_numberOfLines;
@property(assign, nonatomic) NSInteger three_numberOfLines;
@property(assign, nonatomic) NSInteger four_numberOfLines;
@property(assign, nonatomic) NSInteger five_numberOfLines;


#pragma mark - 左右间距
@property (assign, nonatomic) CGFloat left_margin;
@property (assign, nonatomic) CGFloat right_margin;


+ (instancetype)fiveLabelViewConfigWithDetail:(nullable void(^)(__kindof CKJFiveLabelViewConfig *c))detailSettingBlock;


@end


@interface CKJFiveLabelModel : CKJBaseModel


@property (copy, nonatomic, nullable) NSAttributedString *title;
@property (copy, nonatomic, nullable) NSAttributedString *subTitle;
@property (copy, nonatomic, nullable) NSAttributedString *threeTitle;
@property (copy, nonatomic, nullable) NSAttributedString *fourTitle;
@property (copy, nonatomic, nullable) NSAttributedString *fiveTitle;


@end



@interface CKJFiveLabelView : UIView

@property (weak, nonatomic) UILabel *titleLab;
@property (weak, nonatomic) UILabel *subTitleLab;
@property (weak, nonatomic) UILabel *threeLab;
@property (weak, nonatomic) UILabel *fourLab;
@property (weak, nonatomic) UILabel *fiveLab;


- (instancetype)initWithFrame:(CGRect)frame config:(nonnull CKJFiveLabelViewConfig *)config;


- (void)updateUIWithData:(CKJFiveLabelModel *_Nullable)data;

@end

NS_ASSUME_NONNULL_END
