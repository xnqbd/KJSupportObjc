//
//  BaseCollectionViewToolVC.h
//  RAC空项目
//
//  Created by chenkaijie on 2018/1/18.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonCollectionViewTool.h"


#warning  注意: 继承于本来的子类， 需实现 CommonCollectionViewToolDataSource 协议
@interface BaseCollectionViewToolVC : UIViewController <CommonCollectionViewToolDelegate, CommonCollectionViewToolDataSource>



@property (strong, nonatomic) UICollectionView *collectionView;


- (UICollectionViewLayout *)get_subVC_collectionViewLayout;

/**
 自定义CollectionView的约束或者 frame, 子类如果不重写，就默认和控制器一样大小
 */
- (void)layoutCollectionViewFrame;

@property (strong, nonatomic) CommonCollectionViewTool *collectionViewTool;


@end
