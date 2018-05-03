//
//  CommonCollectionViewCell.h
//  RAC空项目
//
//  Created by chenkaijie on 2018/1/18.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommonCollectionViewCellModel;

@interface CommonCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) CommonCollectionViewCellModel *cellModel;

/**
 *  此方法留着给子类重写，通常是拿到这几个参数 给子类cell设置UI数据
 */
- (void)setupData:(CommonCollectionViewCellModel *)cellModel section:(NSInteger)section item:(NSInteger)item collectionView:(UICollectionView *)collectionView;

@end
