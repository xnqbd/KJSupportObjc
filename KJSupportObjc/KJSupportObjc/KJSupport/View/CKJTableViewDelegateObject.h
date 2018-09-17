//
//  CKJTableViewDelegateObject.h
//  YHFSDK
//
//  Created by chenkaijie on 2018/7/21.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CKJSimpleTableView.h"

@interface CKJTableViewDelegateObject : NSObject <UITableViewDelegate>

/**
 一定要赋值
 */
@property (weak, nonatomic) CKJSimpleTableView *simpleTableView;

@end
