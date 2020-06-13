//
//  RJTestResource.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/7/31.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "RJTestResource.h"

@implementation RJTestResource

+ (NSArray <NSDictionary *>*)item1 {
    return @[
             @{@"avatarImageName" : @"newhome_报告", @"name" : @"狄文1", @"job" : @"主任", @"department" : @"胸外科"},
             @{@"avatarImageName" : @"newhome_药费查询", @"name" : @"赵小强1", @"job" : @"经理", @"department" : @"心内科"},
             @{@"avatarImageName" : @"newhome_报告", @"name" : @"狄文2", @"job" : @"主任", @"department" : @"胸外科"},
             @{@"avatarImageName" : @"newhome_药费查询", @"name" : @"赵小强2", @"job" : @"经理", @"department" : @"心内科"},
             @{@"avatarImageName" : @"newhome_报告", @"name" : @"狄文3", @"job" : @"主任", @"department" : @"胸外科"},
             @{@"avatarImageName" : @"newhome_药费查询", @"name" : @"赵小强3", @"job" : @"经理", @"department" : @"心内科"},
             @{@"avatarImageName" : @"newhome_报告", @"name" : @"狄文4", @"job" : @"主任", @"department" : @"胸外科"},
             @{@"avatarImageName" : @"newhome_药费查询", @"name" : @"赵小强4", @"job" : @"经理", @"department" : @"心内科"},
             @{@"avatarImageName" : @"newhome_报告", @"name" : @"狄文5", @"job" : @"主任", @"department" : @"胸外科"},
             @{@"avatarImageName" : @"newhome_药费查询", @"name" : @"赵小强5", @"job" : @"经理", @"department" : @"心内科"}
             ];
}
+ (NSArray <NSDictionary *>*)item2 {
    return @[
             @{@"title" : @"入院取号", @"imageName" : @"newhome_入院取号"},
             @{@"title" : @"出院取号", @"imageName" : @"newhome_出院取号"},
             @{@"title" : @"住院日清单", @"imageName" : @"newhome_住院清单"},
             @{@"title" : @"入院取号2", @"imageName" : @"newhome_入院取号"},
             @{@"title" : @"出院取号2", @"imageName" : @"newhome_出院取号"},
             @{@"title" : @"住院日清单2", @"imageName" : @"newhome_住院清单"}
             ];
}

+ (NSArray <NSDictionary *>*)item3 {
    
    UIImage *(^b_image)(NSString *imageName) = ^UIImage *(NSString *imageName) {
        return [[UIImage kjwd_imageNamed:imageName] kjwd_scaleToSize:CGSizeMake(30, 30)];
    };
    
    return @[
             @{KJPrefix_cNormalAttTitle : WDAtt13(@"报告查询"), KJPrefix_cNormalImage : b_image(@"newhome_报告")},
             @{KJPrefix_cNormalAttTitle : WDAtt13(@"药费查询"), KJPrefix_cNormalImage : b_image(@"newhome_药费查询")},
             @{KJPrefix_cNormalAttTitle : WDAtt13(@"处方查询"), KJPrefix_cNormalImage : b_image(@"newhome_处方")},
             @{KJPrefix_cNormalAttTitle : WDAtt13(@"药品查询"), KJPrefix_cNormalImage : b_image(@"newhome_药品")},
             @{KJPrefix_cNormalAttTitle : WDAtt13(@"精准预约"), KJPrefix_cNormalImage : b_image(@"newhome_预约")},
             @{KJPrefix_cNormalAttTitle : WDAtt13(@"日间手术"), KJPrefix_cNormalImage : b_image(@"newhome_手术")},
             @{KJPrefix_cNormalAttTitle : WDAtt13(@"小i机器人"), KJPrefix_cNormalImage : b_image(@"newhome_机器人")},
             @{KJPrefix_cNormalAttTitle : WDAtt13(@"更多"), KJPrefix_cNormalImage : b_image(@"newhome_更多"),  KJPrefix_cSelectedAttTitle : WDAtt13(@"日间手术"), KJPrefix_cSelectedImage : b_image(@"日间手术")},
             
             @{KJPrefix_cNormalAttTitle : WDAtt13(@"预约检查"), KJPrefix_cNormalImage : b_image(@"预约检查")},
             ];
}

+ (NSArray <NSDictionary *>*)item4 {
    
    UIImage *(^b_image)(NSString *imageName) = ^UIImage *(NSString *imageName) {
        return [[UIImage kjwd_imageNamed:imageName] kjwd_scaleToSize:CGSizeMake(30, 30)];
    };
    
    return @[
             @{KJPrefix_cNormalAttTitle : WDAtt13(@"报告查询"), KJPrefix_cNormalImage : b_image(@"newhome_报告")},
             @{KJPrefix_cNormalAttTitle : WDAtt13(@"药费查询"), KJPrefix_cNormalImage : b_image(@"newhome_药费查询")},
             @{KJPrefix_cNormalAttTitle : WDAtt13(@"处方查询"), KJPrefix_cNormalImage : b_image(@"newhome_处方")}
             ];
}

@end
