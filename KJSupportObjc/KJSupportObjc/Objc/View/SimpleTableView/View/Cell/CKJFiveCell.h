//
//  CKJPayStyleCell.h
//  WDYHFSDK
//
//  Created by chenkaijie on 2018/12/7.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CKJCommonTableViewCell.h"

@interface CKJFiveCellModel : CKJCommonCellModel

@property (copy, nonatomic) NSString *image_Name;
@property (copy, nonatomic) NSString *image_URL;

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subTitle;
@property (copy, nonatomic) NSString *thirdTitle;
@property (copy, nonatomic) NSString *fourthTitle;
@property (copy, nonatomic) NSString *fifthTitle;

@property (assign, nonatomic) BOOL chooseBtn_Selected;

@end



NS_ASSUME_NONNULL_BEGIN


// 该类一般需要继承使用
@interface CKJFiveCell : CKJCommonTableViewCell<CKJFiveCellModel *>

/** 子类需重写此方法，不要重写setupData方法了 */
- (void)installData:(CKJFiveCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView;

/** 点击 右边选择按钮 */
- (void)chooseBtnAction;


@property (weak, nonatomic) UILabel *titleLab;
@property (weak, nonatomic) UILabel *subTitleLab;
@property (weak, nonatomic) UILabel *thirdLab;
@property (weak, nonatomic) UILabel *fourthLab;
@property (weak, nonatomic) UILabel *fifthLab;

@property (weak, nonatomic) UIImageView *imageV;

@property (weak, nonatomic) UIView *rightWrapperLabel;

/** 右边选择的按钮 */
@property (weak, nonatomic) UIButton *chooseBtn;


/** 图片大小 */
@property (assign, nonatomic, readonly) CGSize imageSize;

#pragma mark - 上下间距

/** SuperView 和 title 之间的距离 */
@property (assign, nonatomic, readonly) CGFloat superview_margin_title;

/** title和subTitle之间的距离 */
@property (assign, nonatomic, readonly) CGFloat title_margin_subTitle;

/** subTitle和thirdLab之间的距离 */
@property (assign, nonatomic, readonly) CGFloat subTitle_margin_thirdLab;

/** thirdLab和fourthLab之间的距离 */
@property (assign, nonatomic, readonly) CGFloat thirdLab_margin_fourthLab;

/** fourthLab和fifthLab之间的距离 */
@property (assign, nonatomic, readonly) CGFloat fourthLab_margin_fifthLab;

/** fifthLab和SuperView之间的距离 */
@property (assign, nonatomic, readonly) CGFloat fifthLab_margin_SuperView;



#pragma mark - 右边间距
@property (assign, nonatomic, readonly) CGFloat title_RightMargin;
@property (assign, nonatomic, readonly) CGFloat subTitle_RightMargin;
@property (assign, nonatomic, readonly) CGFloat thirdLab_RightMargin;
@property (assign, nonatomic, readonly) CGFloat fourthLab_RightMargin;
@property (assign, nonatomic, readonly) CGFloat fifthLab_RightMargin;

/** image和title之间的距离 */
@property (assign, nonatomic, readonly) CGFloat image_margin_title;

@end

NS_ASSUME_NONNULL_END
