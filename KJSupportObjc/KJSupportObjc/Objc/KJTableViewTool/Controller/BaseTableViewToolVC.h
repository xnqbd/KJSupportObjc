//
//  BaseTableViewToolVC.h
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/26.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonTableViewTool.h"

@interface BaseTableViewToolVC : UIViewController <CommonTableViewToolDelegate>



@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) CommonTableViewTool *tableViewTool;


@end
