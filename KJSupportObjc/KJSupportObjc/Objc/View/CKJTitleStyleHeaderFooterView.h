//
//  CKJTitleStyleTableViewHeaderFooterView.h
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/7/17.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "CKJCommonTableViewHeaderFooterView.h"

#import "CKJCommonHeaderFooterModel.h"


@interface CKJTitleStyleHeaderFooterModel : CKJCommonHeaderFooterModel

@property (copy, nonatomic) NSString *customTitle;

+ (instancetype)modelTitle:(NSString *)title;

@end



@class CKJTitleStyleHeaderFooterView;

@protocol TitleStyleHeaderFooterViewDelegate <NSObject>


/**
 处理区头区尾UI，(字体大小，颜色等等)

 @param lab 传入的Label
 @return 区头区尾的UIEdgeInsets
 */
//- (UIEdgeInsets)layout_customTitleLab:(UILabel *)lab bgV:(UIView *)bgv;

/**
 就像cellForRow一样调用的更新数据
 */
- (void)setupCKJTitleStyleHeaderFooterView:(CKJTitleStyleHeaderFooterView *)titleHeaderFooterView label:(UILabel *)label bgV:(UIView *)bgv data:(CKJCommonHeaderFooterModel *)headerFooterModel section:(NSInteger)section tableView:(UITableView *)tableView;

@end



/**
 只有文字的区头、区尾
 */
@interface CKJTitleStyleHeaderFooterView : CKJCommonTableViewHeaderFooterView

@property (strong, nonatomic) UILabel *customTitleLab;

@property (weak, nonatomic) id <TitleStyleHeaderFooterViewDelegate> delegate;

@end
