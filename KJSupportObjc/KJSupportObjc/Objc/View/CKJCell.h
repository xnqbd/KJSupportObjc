//
//  CKJCell.h
//  RAC空项目
//
//  Created by chenkaijie on 2018/1/19.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//



#import "CKJCommonTableViewCell.h"
#import "NSObject+WDYHFCategory.h"



@class CKJCellModel, CKJCell;

@interface KJWDJButtonModel : NSObject

@property (copy, nonatomic) NSAttributedString *normalAttributedTitle;
@property (copy, nonatomic) NSAttributedString *selectedAttributedTitle;

@property (copy, nonatomic) NSString *normalBackgroundImage;
@property (copy, nonatomic) NSString *selectedBackgroundImage;

@property (copy, nonatomic) NSString *normalImage;
@property (copy, nonatomic) NSString *selectedImage;



//- (void)setupData:(CKJCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView
@property (copy, nonatomic) void(^btnBlock)(CKJCell *cell, UIButton *btn8);

@end




@protocol CKJCellModelDelegate <NSObject>

- (void)switchChangeBlock:(void(^)(BOOL switchOn, CKJCellModel *model))block;

@end


@protocol CKJCellDataSource <NSObject>

@optional;

/**
 imageBtn2 左边的图片 只能设置宽、高、距离父视图左边的距离
 */
- (void)imageBtn2_setup:(id)make section:(NSInteger)section row:(NSInteger)row cell:(CKJCell *)cell imageBtn2:(UIButton *)imageBtn2;


- (CGFloat)title3_leftMarginAtsection:(NSInteger)section row:(NSInteger)row cell:(CKJCell *)cell;

/**
  view5 上下label 间距
 */
- (CGFloat)view5_setup_top_title_marginTo_bottom_subTitle_Atsection:(NSInteger)section row:(NSInteger)row cell:(CKJCell *)cell;

/**
 view5 左边 间距, 需要设置在一定的范围内，不然会有约束冲突
 */
- (CGFloat)view5_setup_leftMarginAtsection:(NSInteger)section row:(NSInteger)row cell:(CKJCell *)cell;

- (UIEdgeInsets)alikePriceLabel7_edgeInsetsAtsection:(NSInteger)section row:(NSInteger)row cell:(CKJCell *)cell;

/**
 btn8  (只能调整 centerY、width、height)  ---> make.centerY.equalTo(btn8.superview)
 @return 距离右边的间距
 */
- (CGFloat)btn8_return_rightMargin:(id)make section:(NSInteger)section row:(NSInteger)row cell:(CKJCell *)cell btn8:(UIButton *)btn8;




@end



@interface CKJCellModel : CKJCommonCellModel


@property (copy, nonatomic) NSString *left_ImageString2;

@property (copy, nonatomic) NSAttributedString *title3;
@property (copy, nonatomic) NSAttributedString *subTitle4;

@property (copy, nonatomic) NSAttributedString *view5_topText;
@property (copy, nonatomic) NSAttributedString *view5_bottomText;

@property (copy, nonatomic) NSAttributedString *right_alikePrice7;
@property (strong, nonatomic) KJWDJButtonModel *btn8Model;

@property (copy, nonatomic) NSString *right_arrowImageString9;


@property (assign, nonatomic) BOOL showSwitch;
@property (assign, nonatomic) BOOL switchOn;
@property (weak, nonatomic) id <CKJCellModelDelegate> delegate;


@property (copy, nonatomic) void (^swicthBlock)(BOOL switchOn, CKJCell *cell, UISwitch *senderSwitch);

@property (copy, nonatomic) void (^cellBlock)(CKJCellModel *model, NSInteger section, NSInteger row, NSIndexPath *indexPath);


@end



@interface CKJCell : CKJCommonTableViewCell <CKJCellModel *>

@property (weak, nonatomic) id <CKJCellDataSource> ckjCellDataSource;

@end

