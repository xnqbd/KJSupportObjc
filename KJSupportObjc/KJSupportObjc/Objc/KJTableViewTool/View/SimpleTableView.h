//
//  SimpleTableView.h
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/6/23.
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


@interface SimpleTableView : UITableView <CommonTableViewToolDelegate, CommonTableViewToolDataSource>

@property (strong, nonatomic) CommonTableViewTool *tableViewTool;

@property (strong, nonatomic) NSArray <CommonSectionModel *>* _Nullable dataArr;

@property (weak, nonatomic, nullable) IBOutlet id  <CommonTableViewToolDelegate> simpleTableViewDelegate;
@property (weak, nonatomic, nullable) IBOutlet id  <CommonTableViewToolDataSource> simpleTableViewDataSource;
/**
 拼接在最后一个分区的 最后一行
 */
- (void)appendCellModelAtLastSectionLastRow:(CommonCellModel *)model;
/**
 插入模型在某个分区的某一行
 */
- (void)insertCellModel:(CommonCellModel *)model atSection:(NSInteger)section row:(NSInteger)row;
/**
 删除模型在某个分区的某一行
 */
- (void)removeCellModelAtSection:(NSInteger)section row:(NSInteger)row;
/**
 删除某个分区
 */
- (void)removeSection:(NSInteger)section;

@end
