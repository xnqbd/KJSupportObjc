//
//  CKJCommonCellModel.h
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/7/4.
//  Copyright © 2018年 uback. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CKJCommonTableViewCell;

@interface CKJCommonCellModel : NSObject

/**
 行高
 */
@property (assign, nonatomic) CGFloat cellHeight;

/**
 是否选中
 */
@property (assign, nonatomic) BOOL selected;

/**
 是否在UITableView里面显示
 */
@property (assign, nonatomic) BOOL displayInTableView;

/**
 标识, 每一个该model的id_flag 一定不能相同
 */
@property (assign, nonatomic) int id_flag;

@property (weak, nonatomic) CKJCommonTableViewCell *cell;


//@property (copy, nonatomic) NSString *sectionProperty_XXX;

@end
