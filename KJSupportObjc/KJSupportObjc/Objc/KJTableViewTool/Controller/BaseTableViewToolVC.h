//
//  BaseTableViewToolVC.h
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/26.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonTableViewTool.h"

@class SimpleTableView;



#warning  注意: 继承于本来的子类， 需实现 CommonTableViewToolDataSource 协议
@interface BaseTableViewToolVC : UIViewController <CommonTableViewToolDelegate, CommonTableViewToolDataSource>

@property (weak, nonatomic) IBOutlet SimpleTableView *simpleTableView;

/**
 simpleTableView的约束或者 frame
 */
- (void)layoutTableViewFrame:(SimpleTableView *)tableV;



@end
