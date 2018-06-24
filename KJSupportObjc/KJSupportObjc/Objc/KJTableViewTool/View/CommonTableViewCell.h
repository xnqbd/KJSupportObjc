//
//  CommonTableViewCell.h
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/21.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommonTableViewCellModel, CommonTableViewTool;

@interface CommonTableViewCell <E : CommonTableViewCellModel *> : UITableViewCell

@property (nonatomic, strong) E cellModel;

/**
 *  此方法留着给子类重写，通常是拿到这几个参数 给子类cell设置UI数据
 */
- (void)setupData:(E)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *_Nonnull)indexPath tableView:(UITableView *)tableView tableViewTool:(CommonTableViewTool *_Nonnull)tool;


@end
