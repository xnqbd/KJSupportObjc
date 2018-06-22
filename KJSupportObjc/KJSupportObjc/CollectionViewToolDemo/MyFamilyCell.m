//
//  MyFamilyCell.m
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/6/22.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "MyFamilyCell.h"

@implementation MyFamilyCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setupData:(MyFamilyCellModel *)cellModel section:(NSInteger)section item:(NSInteger)item collectionView:(UICollectionView *)collectionView {
    self.contentView.backgroundColor = [UIColor arc4Color];
    self.avatarImageV.image = [UIImage kj_imageNamed:cellModel.imageUrl];
    CertifiedStatus certifiedStatus = cellModel.certifiedStatus;

    
    [self.certifiedBtn setTitle:certifiedStatus ? @"已认证" : @"待实名认证" forState:UIControlStateNormal];
}



@end
