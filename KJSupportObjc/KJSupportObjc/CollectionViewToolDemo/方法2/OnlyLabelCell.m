//
//  OnlyLabelCell.m
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/6/25.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "OnlyLabelCell.h"
#import "OnlyLabelModel.h"

@implementation OnlyLabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupData:(OnlyLabelModel *)model section:(NSInteger)section item:(NSInteger)item selectIndexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView collectionViewTool:(CommonCollectionViewTool *)tool {
//    self.lab.backgroundColor = [UIColor arc4Color];
    self.lab.text = KJ_ConfirmString(model.name);
}

@end
