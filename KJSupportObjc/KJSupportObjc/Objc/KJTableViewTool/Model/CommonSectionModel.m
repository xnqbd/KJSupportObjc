//
//  CommonSectionModel.m
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/21.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import "CommonSectionModel.h"

@implementation CommonSectionModel

+ (instancetype)sectionWithModelArray:(NSArray <CommonTableViewCellModel *>*)modelArray {
    CommonSectionModel *model = [CommonSectionModel new];
    model.modelArray = modelArray;
    return model;
}

@end
