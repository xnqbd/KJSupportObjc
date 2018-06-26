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


@end
