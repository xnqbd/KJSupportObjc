//
//  BaseTableViewToolVC.h
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/26.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonTableViewTool.h"



#warning  注意: 继承于本来的子类， 需实现 CommonTableViewToolDataSource 协议
@interface BaseTableViewToolVC : UIViewController <CommonTableViewToolDelegate, CommonTableViewToolDataSource>



@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) CommonTableViewTool *tableViewTool;

/**
 自定义TableView的约束或者 frame, 子类如果不重写，就默认和控制器一样大小
 */
- (void)layoutTableViewFrame;



@end
