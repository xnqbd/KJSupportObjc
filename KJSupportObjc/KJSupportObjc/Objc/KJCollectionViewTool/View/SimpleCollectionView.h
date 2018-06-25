//
//  SimpleCollectionView.h
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/6/25.
//  Copyright © 2018年 uback. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "CommonTableViewTool.h"
#import "CommonCollectionViewTool.h"
#import "SimpleTableView.h"


#import "BaseTableViewToolVC.h"
#import "BaseCollectionViewToolVC.h"

#import "LightStorageManager.h"
#import "NSObject+KJCategory.h"
#import <objc/message.h>
#import "KJHeader.h"
#import <Masonry/Masonry.h>

IB_DESIGNABLE
@interface SimpleCollectionView : UICollectionView <CommonCollectionViewToolDelegate, CommonCollectionViewToolDataSource>

@property (strong, nonatomic) CommonCollectionViewTool *collectionViewTool;

@property (strong, nonatomic) NSArray <CommonCollectionViewSectionModel *>* _Nullable dataArr;


@property (weak, nonatomic, nullable) IBOutlet id  <CommonCollectionViewToolDelegate> simpleCollectionViewDelegate;
@property (weak, nonatomic, nullable) IBOutlet id  <CommonCollectionViewToolDataSource> simpleCollectionViewDataSource;


@end
