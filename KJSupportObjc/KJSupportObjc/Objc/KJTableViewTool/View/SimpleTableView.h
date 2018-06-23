//
//  SimpleTableView.h
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/6/23.
//  Copyright © 2018年 uback. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleTableView : UITableView <CommonTableViewToolDelegate, CommonTableViewToolDataSource>

@property (strong, nonatomic) CommonTableViewTool *tableViewTool;

@property (strong, nonatomic) NSArray <CommonSectionModel *>* _Nullable dataArr;

@property (weak, nonatomic, nullable) id  <CommonTableViewToolDelegate> simpleTableViewDelegate;
@property (weak, nonatomic, nullable) id  <CommonTableViewToolDataSource> simpleTableViewDataSource;


@end
