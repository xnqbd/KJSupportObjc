//
//  KJCellModel.h
//  RAC空项目
//
//  Created by chenkaijie on 2018/2/26.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CommonCellModel.h"

//struct KJItem {
//    __unsafe_unretained NSString *str;
//    CGFloat leftMargin;
//    CGFloat rightMargin;
//};
//

@class KJCellModel;

@protocol KJCellModelDelegate

- (void)switchChangeBlock:(void(^)(BOOL switchOn, KJCellModel *model))block;

@end

@interface KJCellModel : CommonCellModel

@property (copy, nonatomic) NSString *left_ImageString2;

@property (copy, nonatomic) NSString *left_Title3;
@property (copy, nonatomic) NSString *left_subTitle4;
@property (copy, nonatomic) NSString *right_alikePrice7;
@property (copy, nonatomic) NSString *right_imageViewString8;
@property (copy, nonatomic) NSString *right_arrowImageString9;


@property (assign, nonatomic) BOOL showSwitch;
@property (assign, nonatomic) BOOL switchOn;
@property (weak, nonatomic) id <KJCellModelDelegate>delegate;


@property (copy, nonatomic) void (^swicthBlock)(BOOL switchOn);

@property (copy, nonatomic) void (^cellBlock)(KJCellModel *model, NSInteger section, NSInteger row, NSIndexPath *indexPath);


@end
