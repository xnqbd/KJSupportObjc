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

@class CommonCollectionViewTool;


@protocol CommonCollectionViewToolDataSource <NSObject>
@required;

/**
 键值对 @{NSStringFromClass([CommonTableViewCellModel class]) : @{cellKEY : NSStringFromClass([CommonTableViewCell class]), isRegisterNibKEY : @YES}};
 
 @return 键值对
 */
- (NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues;

@end

@protocol CommonCollectionViewToolDelegate <NSObject>
@optional;
- (void)collectionView:(UICollectionView *_Nonnull)collectionView didSelectItemAtSection:(NSInteger)section item:(NSInteger)item model:(CommonCollectionViewCellModel *_Nonnull)model commonCollectionViewTool:(CommonCollectionViewTool *_Nullable)commonCollectionViewTool;
@end


@interface CommonCollectionViewTool : NSObject <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property (strong, nonatomic) NSArray <CommonCollectionViewSectionModel *>* _Nullable dataArr;


@property (weak, nonatomic, nullable) id  <CommonCollectionViewToolDataSource> dataSource;
@property (weak, nonatomic, nullable) id  <CommonCollectionViewToolDelegate> delegate;

/**
 一定要赋值
 */
@property (weak, nonatomic) UICollectionView * collectView;

@end
