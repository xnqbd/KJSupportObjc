//
//  CommonCollectionReusableView.h
//  RAC空项目
//
//  Created by chenkaijie on 2018/1/18.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonCollectionReusableViewModel.h"

@class CommonCollectionViewTool;

@interface CommonCollectionReusableView : UICollectionReusableView

@property (strong, nonatomic) CommonCollectionReusableViewModel *reusableViewModel;


/**
 *  此方法留着给子类重写，通常是拿到这几个参数 给子类cell设置UI数据
 */
- (void)setupData:(CommonCollectionReusableViewModel *)model section:(NSInteger)section item:(NSInteger)item selectIndexPath:(NSIndexPath *_Nonnull)indexPath collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind reusableView:(CommonCollectionReusableView *)reusableView tool:(CommonCollectionViewTool *_Nonnull)tool;

@end
