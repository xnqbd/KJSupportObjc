//
//  CommonCollectionViewTool.h
//  RAC空项目
//
//  Created by chenkaijie on 2018/1/18.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "CommonCollectionViewCellModel.h"
#import "CommonCollectionReusableViewModel.h"
#import "CommonCollectionViewSectionModel.h"
#import "CommonCollectionViewCell.h"

#define typeKJweakself __weak typeof(self) weak_Self = self


@class CommonCollectionViewTool;

@protocol CommonCollectionViewToolDelegate <NSObject>

@optional;

- (void)collectionView:(UICollectionView *_Nonnull)collectionView didSelectItemAtSection:(NSInteger)section item:(NSInteger)item model:(CommonCollectionViewCellModel *_Nonnull)model commonCollectionViewTool:(CommonCollectionViewTool *_Nullable)commonCollectionViewTool;

@end


@interface CommonCollectionViewTool : NSObject <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property (strong, nonatomic) NSArray <CommonCollectionViewSectionModel *>* _Nullable dataArr;

@property (weak, nonatomic, nullable) id  <CommonCollectionViewToolDelegate> delegate;

@property (weak, nonatomic) UICollectionView * collectView;

@end
