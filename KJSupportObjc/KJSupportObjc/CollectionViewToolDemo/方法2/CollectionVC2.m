//
//  CollectionVC2.m
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/6/25.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "CollectionVC2.h"
#import "OnlyLabelCell.h"
#import "OnlyLabelModel.h"
#import "VisitCardModel.h"
#import "VisitCardCell.h"

@interface CollectionVC2 () <CommonCollectionViewToolDelegate, CommonCollectionViewToolDataSource>

/**
 就诊人CollectionView
 */
@property (weak, nonatomic) IBOutlet SimpleCollectionView *visitPersonCollectionView;
/**
 就诊卡CollectionView
 */
@property (weak, nonatomic) IBOutlet SimpleCollectionView *visitCardCollectionView;



@end

@implementation CollectionVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.estimatedItemSize = CGSizeMake(100, 32);
        layout.minimumLineSpacing = 10;
        self.visitPersonCollectionView.collectionViewLayout = layout;
        
        NSMutableArray <CommonCollectionViewSectionModel *>*sections = [NSMutableArray array];
        
        {   // 分区1
            CommonCollectionViewSectionModel *section = [CommonCollectionViewSectionModel new];
            
            OnlyLabelModel *model1 = [OnlyLabelModel new];
            model1.name = @"刘备";
            
            
            OnlyLabelModel *model2 = [OnlyLabelModel new];
            model2.name = @"关云长";
            
            
            OnlyLabelModel *model3 = [OnlyLabelModel new];
            model3.name = @"张飞";
            
            
            section.modelArray = @[model1, model2, model3];
            
            [sections addObject:section];
        }
        {   // 分区2
            CommonCollectionViewSectionModel *section = [CommonCollectionViewSectionModel new];
            
            OnlyLabelModel *model1 = [OnlyLabelModel new];
            model1.name = @"刘备";
            
            
            OnlyLabelModel *model2 = [OnlyLabelModel new];
            model2.name = @"关羽";
            
            
            OnlyLabelModel *model3 = [OnlyLabelModel new];
            model3.name = @"张飞";
            
            
            section.modelArray = @[model1, model2, model3];
            
            [sections addObject:section];
        }
            self.visitPersonCollectionView.dataArr = sections;
            [self.visitPersonCollectionView reloadData];
    }
    {
        /*
         
         其他卡  只能添加的是社保卡
         
         
         1. 其他卡  -> 添加社保卡 返回来变成 -> 社保卡
         
         2. 健康卡  其他卡  -> 添加社保卡 返回来变成 -> 健康卡  社保卡
         
         3. 社保卡
         
         4. 健康卡  社保卡
         
         */

        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.estimatedItemSize = CGSizeMake(100, 40);
        layout.minimumLineSpacing = 10;
        self.visitCardCollectionView.collectionViewLayout = layout;
        
        NSMutableArray <CommonCollectionViewSectionModel *>*sections = [NSMutableArray array];
        
        {   // 分区1
            CommonCollectionViewSectionModel *section = [CommonCollectionViewSectionModel new];
            
            VisitCardModel *model1 = [VisitCardModel new];
            model1.cardType = @"健康卡";
            model1.cardNum = @"123123213";
            
            OnlyLabelModel *model2 = [OnlyLabelModel new];
            model2.name = @"其他卡";

            section.modelArray = @[model1, model2];
            
            [sections addObject:section];
        }
        
        self.visitCardCollectionView.dataArr = sections;
        [self.visitCardCollectionView reloadData];
    }
}

/**
 这个方法一定要实现
 */
- (nonnull NSDictionary<NSString *,NSDictionary<NSString *,id> *> *)returnCell_Model_keyValues {
    return @{NSStringFromClass([OnlyLabelModel class]) : @{cellKEY : NSStringFromClass([OnlyLabelCell class]), isRegisterNibKEY: @YES},
             NSStringFromClass([VisitCardModel class]) : @{cellKEY : NSStringFromClass([VisitCardCell class]), isRegisterNibKEY: @YES}
             };
}

@end
