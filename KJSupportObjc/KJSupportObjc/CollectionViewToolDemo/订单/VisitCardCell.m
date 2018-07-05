//
//  VisitCardCell.m
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/6/25.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "VisitCardCell.h"

@implementation VisitCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIView *shadow = self.shadow;
    
    shadow.layer.cornerRadius = 10;
    shadow.layer.shadowColor = [UIColor blackColor].CGColor;
    shadow.layer.shadowOffset = CGSizeMake(0, 1);
    shadow.layer.shadowOpacity = 0.2;
    shadow.layer.shadowRadius = 1;
}

- (void)setupData:(CommonCellModel *)model section:(NSInteger)section item:(NSInteger)item selectIndexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView collectionViewTool:(CommonCollectionViewTool *)tool {
    
}
@end
