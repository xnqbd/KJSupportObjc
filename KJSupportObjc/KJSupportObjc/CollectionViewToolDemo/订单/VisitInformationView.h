//
//  VisitInformationView.h
//  HealthTaiZhou
//
//  Created by chenkaijie on 2018/7/2.
//  Copyright © 2018年 kingtang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YuyueConfirmViewController;


/**
 确认订单视图的 就诊人信息View的 数据Model
 */
@interface VisitInformationModel : NSObject

/**
 就诊人姓名
 */
@property (copy, nonatomic) NSString *name;

/**
 就诊人身份证号
 */
@property (copy, nonatomic) NSString *idNumber;

/**
 就诊人家庭地址
 */
@property (copy, nonatomic) NSString *address;

@end





/**
 确认订单视图的 就诊人信息View
 */
@interface VisitInformationView : UIView

/**
 姓名输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *nameTF;

/**
 身份证号输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *cardTF;

/**
 家庭地址输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *addressTF;

@property (weak, nonatomic) YuyueConfirmViewController *currentVC;

@property (strong, nonatomic) VisitInformationModel *model;

//- (void)updateView:(VisitInformationModel *)model;

@end
