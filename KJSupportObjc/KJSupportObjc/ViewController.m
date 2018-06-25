//
//  ViewController.m
//  KJSupportObjc
//
//  Created by uback on 2018/5/3.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "ViewController.h"

#import "DemoTableVC.h"
#import "InformationTableVC.h"
#import <CoreImage/CoreImage.h>
#import "MyFamilyViewController.h"
#import "DelegateViewController.h"
#import "CollectionVC2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor arc4Color];

    
//    NSMutableArray *cellModelArray = [NSMutableArray array];
//    CommonSectionModel *sectionModel = [CommonSectionModel new];
//    
//
//    {   // 我的资料
//        InformationCellModel *model = [InformationCellModel new];
//        model.left_ImageString2 = @"icon_data";
//        model.left_Title3 = @" 我的资料";
//        model.right_arrowImageString9 = @"arrow_right_black";
//        [cellModelArray addObject:model];
//    }
//    {   // 清除缓存
//        InformationCellModel *model = [InformationCellModel new];
//        model.left_Title3 = @"清除缓存";
//        model.right_alikePrice7 = @"14 MB";
//        model.right_arrowImageString9 = @"arrow_right_black";
//        [cellModelArray addObject:model];
//    }
//    {   // 淘宝昵称
//        InformationCellModel *model = [InformationCellModel new];
//        model.left_Title3 = @"淘宝昵称";
//        model.right_alikePrice7 = @"还是空的，快来取个有逼格的名字吧";
//        [cellModelArray addObject:model];
//    }
//    {   // 芝麻信用
//        InformationCellModel *model = [InformationCellModel new];
//        model.left_Title3 = @"芝麻信用";
//        model.left_subTitle4 = @"724";
//        model.right_arrowImageString9 = @"arrow_right_black";
//        [cellModelArray addObject:model];
//    }
//    {   // 消息推送
//        InformationCellModel *model = [InformationCellModel new];
//        model.left_ImageString2 = @"me_notice";
//        model.left_Title3 = @"消息推送";
//        model.showSwitch = YES;
//        model.swicthBlock = ^(BOOL switchOn) {
//            //  可以在这里进行 处理事件
//            NSLog(@"%@", switchOn ? @"开启推送" : @"关闭推送");
//        };
//        [cellModelArray addObject:model];
//    }
//    {   // 关于
//        InformationCellModel *model = [InformationCellModel new];
//        model.left_Title3 = @"关于";
//        model.right_arrowImageString9 = @"arrow_right_black";
//        [cellModelArray addObject:model];
//    }
//    {   // 账户管理
//        InformationCellModel *model = [InformationCellModel new];
//        model.left_Title3 = @"账户管理";
//        model.right_imageViewString8 = @"icon_xin";
//        model.right_arrowImageString9 = @"arrow_right_black";
//        [cellModelArray addObject:model];
//    }
//
//    sectionModel.modelArray = cellModelArray;
//
//
//
//    self.tableViewTool.dataArr = @[sectionModel];
//    [self.tableView reloadData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}

- (IBAction)tab1Action:(UIButton *)sender {
    [self.navigationController pushViewController:[DemoTableVC new] animated:YES];
}

- (IBAction)tabAction:(UIButton *)sender {
    [self.navigationController pushViewController:[DelegateViewController new] animated:YES];
}

- (IBAction)collAction:(UIButton *)sender {
    [self.navigationController pushViewController:[MyFamilyViewController new] animated:YES];
}
- (IBAction)collAction2:(UIButton *)sender {
    
      [self.navigationController pushViewController:[CollectionVC2 new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
 
 其他卡  只能添加的是社保卡
 
 
 1. 其他卡  -> 添加社保卡 返回来变成 -> 社保卡
 
 2. 健康卡  其他卡  -> 添加社保卡 返回来变成 -> 健康卡  社保卡
 
 3. 社保卡
 
 4. 健康卡  社保卡
 
 */






@end
