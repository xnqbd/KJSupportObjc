//
//  ChooseVisitPersonView.m
//  HealthTaiZhou
//
//  Created by chenkaijie on 2018/6/29.
//  Copyright © 2018年 kingtang. All rights reserved.
//

#import "ChooseVisitPersonView.h"
#import "OrderVisitPersonModel.h"
#import "OrderVisitPersonCell.h"

#import "VisitCardCell.h"

#import "OrderVisitPersonLastCell.h"
#import "OrderVisitPersonLastView.h"

@interface ChooseVisitPersonView () <CommonCollectionViewToolDelegate, CommonCollectionViewToolDataSource>

@end

@implementation ChooseVisitPersonView

- (void)awakeFromNib {
    [super awakeFromNib];

    
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(100, 60);
        layout.minimumLineSpacing = 10;
        self.visitPersonCollectionView.collectionViewLayout = layout;
        

        
        NSMutableArray <CommonCollectionViewSectionModel *>*sections = [NSMutableArray array];
        
        {   // 分区1
            CommonCollectionViewSectionModel *section = [CommonCollectionViewSectionModel new];
            
            OrderVisitPersonModel *model1 = [OrderVisitPersonModel new];
            model1.name = @"刘备";
            
            
            OrderVisitPersonModel *model2 = [OrderVisitPersonModel new];
            model2.name = @"关云长";
            
            
            OrderVisitPersonModel *model3 = [OrderVisitPersonModel new];
            model3.name = @"张飞";
            
            
            section.modelArray = @[model1, model2, model3];
            
            [sections addObject:section];
        }
        {   // 分区2
            CommonCollectionViewSectionModel *section = [CommonCollectionViewSectionModel new];
            
            OrderVisitPersonModel *model1 = [OrderVisitPersonModel new];
            model1.name = @"刘备";
            
            
            OrderVisitPersonModel *model2 = [OrderVisitPersonModel new];
            model2.name = @"关羽";
            
            
            OrderVisitPersonModel *model3 = [OrderVisitPersonModel new];
            model3.name = @"张飞";
            
            
            
            section.modelArray = @[model1, model2, model3];
            
            
            OrderVisitPersonLastModel *lastModel = [OrderVisitPersonLastModel new];
            section.footerModel = lastModel;
            section.footerSize = CGSizeMake(50, 100);
            
            
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
        layout.itemSize = CGSizeMake(100, 60);
        layout.minimumLineSpacing = 10;
        self.visitCardCollectionView.collectionViewLayout = layout;

        NSMutableArray <CommonCollectionViewSectionModel *>*sections = [NSMutableArray array];

        self.visitCardCollectionView.dataArr = sections;
        [self.visitCardCollectionView reloadData];
    }
}

/**
 这个方法一定要实现
 */
- (nonnull NSDictionary<NSString *,NSDictionary<NSString *,id> *> *)cl_returnCell_Model_keyValues {
    return @{NSStringFromClass([OrderVisitPersonModel class]) : @{cellKEY : NSStringFromClass([OrderVisitPersonCell class]), isRegisterNibKEY: @YES}
             };
}
- (NSDictionary<NSString *,NSDictionary<NSString *,id> *> *)cl_returnFooter_Model_keyValues {
    return @{NSStringFromClass([OrderVisitPersonLastModel class]) : @{cellKEY : NSStringFromClass([OrderVisitPersonLastView class]), isRegisterNibKEY : @YES}};
}




- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtSection:(NSInteger)section item:(NSInteger)item selectIndexPath:(NSIndexPath *)indexPath model:(CommonCellModel *)model commonCollectionViewTool:(CommonCollectionViewTool *)commonCollectionViewTool {
 
}


@end
