//
//  BaseCollectionViewToolVC.h
//  RAC空项目
//
//  Created by chenkaijie on 2018/1/18.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonCollectionViewTool.h"

@class SimpleCollectionView;

#warning  注意: 继承于本来的子类， 需实现 CommonCollectionViewToolDataSource 协议
@interface BaseCollectionViewToolVC : UIViewController <CommonCollectionViewToolDelegate, CommonCollectionViewToolDataSource>


@property (weak, nonatomic) IBOutlet SimpleCollectionView *simpleCollectionView;


- (UICollectionViewLayout *)get_subVC_collectionViewLayout;

/**
 自定义CollectionView的约束或者 frame
 */
- (void)layoutCollectionViewFrame;


@end
