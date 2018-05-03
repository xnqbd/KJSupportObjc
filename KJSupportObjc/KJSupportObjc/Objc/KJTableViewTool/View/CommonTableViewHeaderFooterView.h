//
//  CommonTableViewHeaderFooterView.h
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/21.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommonHeaderFooterModel;

@interface CommonTableViewHeaderFooterView : UITableViewHeaderFooterView


@property (strong, nonatomic) CommonHeaderFooterModel *headerFooterModel;

- (void)setupSubViews;

- (void)setupData;



@end
