//
//  CommonCollectionReusableView.h
//  RAC空项目
//
//  Created by chenkaijie on 2018/1/18.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonCollectionReusableViewModel.h"


@interface CommonCollectionReusableView : UICollectionReusableView

@property (strong, nonatomic) CommonCollectionReusableViewModel *reusableViewModel;

- (void)setupData;

@end
