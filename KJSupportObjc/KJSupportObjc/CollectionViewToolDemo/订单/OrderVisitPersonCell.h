//
//  OrderVisitPersonCell.h
//  HealthTaiZhou
//
//  Created by chenkaijie on 2018/6/29.
//  Copyright © 2018年 kingtang. All rights reserved.
//


#import "OrderVisitPersonModel.h"

/**
 订单界面 （选择就诊人界面） ->  就诊人Cell
 */
@interface OrderVisitPersonCell : CommonCollectionViewCell <OrderVisitPersonModel *>
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIView *shadow;

@end
