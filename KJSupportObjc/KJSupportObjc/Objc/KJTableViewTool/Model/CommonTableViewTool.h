//
//  CommonTableViewTool.h
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/21.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "CommonSectionModel.h"
#import "CommonTableViewCellModel.h"
#import "KJCell.h"
#import "CommonTableViewHeaderFooterView.h"
#import "CommonHeaderFooterModel.h"


#define cellKEY  @"CellKEY"
#define isRegisterNibKEY  @"isRegisterNibKEY"


@class CommonTableViewTool;


@protocol CommonTableViewToolDataSource <NSObject>

@optional;

/**
 一定要匹配匹配正确
键值对   @{ NSStringFromClass([CommonHeaderFooterModel class]) : NSStringFromClass([CommonTableViewHeaderFooterView class])
 }
 @return 键值对
 */
- (nonnull NSDictionary <NSString *, NSString *> *)returnHeader_Model_keyValues;
- (nonnull NSDictionary <NSString *, NSString *> *)returnFooter_Model_keyValues;

@required;
/**
 一定要匹配匹配正确
 键值对  @{NSStringFromClass([CommonTableViewCellModel class]) : @{cellKEY : NSStringFromClass([CommonTableViewCell class]), isRegisterNibKEY : @NO}};

 @return 键值对
 */
- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues;

@end


@protocol CommonTableViewToolDelegate <NSObject>

@optional;

- (void)tableView:(UITableView *_Nullable)tableView didSelectRowAtSection:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *_Nonnull)indexPath model:(CommonTableViewCellModel *_Nullable)cellModel tableViewTool:(CommonTableViewTool *_Nonnull)tool;

@end


@interface CommonTableViewTool : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray <CommonSectionModel *>* _Nullable dataArr;

@property (weak, nonatomic, nullable) id  <CommonTableViewToolDelegate> delegate;
@property (weak, nonatomic, nullable) id  <CommonTableViewToolDataSource> dataSource;

/**
 一定要赋值
 */
@property (weak, nonatomic) UITableView * tablView;

@end
