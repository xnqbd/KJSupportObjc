//
//  RJTestListVC.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/20.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseTableVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface RJTestListVC : CKJBaseTableVC

@end

NS_ASSUME_NONNULL_END


// 仁济绑卡相关的几个页面需要修改，因为HIS那边的证件类型字典变了，之前是（1身份证、2护照、3驾驶证、4军官证、9其他），现在改成了（1身份证、3护照、5驾驶证、4军官证、99其他），请你们立刻把安卓和IOS改掉，否则部分证件类型的就诊卡无法绑定。老版本的APP存在无法绑定情况，因为HIS那边已经升级了，我无法兼容，只能等到新APP升级，强制要求老版本用户升级
