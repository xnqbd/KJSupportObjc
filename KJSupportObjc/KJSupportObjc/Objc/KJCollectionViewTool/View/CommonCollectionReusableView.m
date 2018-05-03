//
//  CommonCollectionReusableView.m
//  RAC空项目
//
//  Created by chenkaijie on 2018/1/18.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CommonCollectionReusableView.h"


@implementation CommonCollectionReusableView


- (void)setReusableViewModel:(CommonCollectionReusableViewModel *)reusableViewModel {
    _reusableViewModel = reusableViewModel;
    [self setupData];
}

- (void)setupData {
    
}

@end
