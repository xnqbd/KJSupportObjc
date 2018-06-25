//
//  MyFamilyCell.h
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/6/22.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "CommonCollectionViewCell.h"
#import "MyFamilyCellModel.h"

/**
 我的家庭cell
 */
@interface MyFamilyCell : CommonCollectionViewCell <MyFamilyCellModel *>

/**
 头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageV;

/**
 已认证/待实名认证
 */
@property (weak, nonatomic) IBOutlet UIButton *certifiedBtn;

/**
 本人/老公
 */
@property (weak, nonatomic) IBOutlet UILabel *identityLab;

/**
 周大大 31岁
 */
@property (weak, nonatomic) IBOutlet UILabel *dataLab;

/**
 我的家庭最后一个cell的背景View
 */
@property (weak, nonatomic) IBOutlet UIView *MyFamilyLastBGView;

/**
 选择家长最后一个cell的背景View
 */
@property (weak, nonatomic) IBOutlet UIView *chooseParentsLastBGView;



@end
