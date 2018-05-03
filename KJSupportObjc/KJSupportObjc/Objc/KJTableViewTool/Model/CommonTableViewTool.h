//
//  CommonTableViewTool.h
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/21.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class CommonSectionModel, CommonTableViewCellModel, CommonTableViewTool;
#import "CommonSectionModel.h"
#import "CommonTableViewCellModel.h"
#import "KJCell.h"
#import "CommonTableViewHeaderFooterView.h"
#import "CommonHeaderFooterModel.h"

@class CommonTableViewTool;


@protocol CommonTableViewToolDelegate <NSObject>

@optional;

- (void)tableView:(UITableView *_Nullable)tableView didSelectRowAtSection:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *_Nonnull)indexPath model:(CommonTableViewCellModel *_Nullable)cellModel tableViewTool:(CommonTableViewTool *_Nonnull)tool;

@end


@interface CommonTableViewTool : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray <CommonSectionModel *>* _Nullable dataArr;

@property (weak, nonatomic, nullable) id  <CommonTableViewToolDelegate> delegate;


/**
 一定要赋值
 */
@property (weak, nonatomic) UITableView * tablView;

@end
