//
//  OrderVisitPersonCell.m
//  HealthTaiZhou
//
//  Created by chenkaijie on 2018/6/29.
//  Copyright © 2018年 kingtang. All rights reserved.
//

#import "OrderVisitPersonCell.h"

@implementation OrderVisitPersonCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIView *shadow = self.shadow;
    
    shadow.layer.cornerRadius = 10;
    shadow.layer.shadowColor = [UIColor blackColor].CGColor;
    shadow.layer.shadowOffset = CGSizeMake(0, 1);
    shadow.layer.shadowOpacity = 0.2;
    shadow.layer.shadowRadius = 1;
}

- (void)setupData:(OrderVisitPersonModel *)model section:(NSInteger)section item:(NSInteger)item selectIndexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView collectionViewTool:(CommonCollectionViewTool *)tool {
    //    self.lab.backgroundColor = [UIColor arc4Color];
    self.nameLab.text = KJ_ConfirmString(model.name);
}


@end
