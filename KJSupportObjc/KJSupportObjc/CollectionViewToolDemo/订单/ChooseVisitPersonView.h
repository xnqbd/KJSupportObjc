//
//  ChooseVisitPersonView.h
//  HealthTaiZhou
//
//  Created by chenkaijie on 2018/6/29.
//  Copyright © 2018年 kingtang. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 选择就诊人下面的View， 一个就诊人，一个就诊卡
 */
@interface ChooseVisitPersonView : UIView

/**
 就诊人CollectionView
 */
@property (weak, nonatomic) IBOutlet SimpleCollectionView *visitPersonCollectionView;
/**
 就诊卡CollectionView
 */
@property (weak, nonatomic) IBOutlet SimpleCollectionView *visitCardCollectionView;



@end
