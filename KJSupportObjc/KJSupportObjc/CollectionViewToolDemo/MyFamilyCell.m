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

- (void)setupData:(MyFamilyCellModel *)model section:(NSInteger)section item:(NSInteger)item selectIndexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView collectionViewTool:(CommonCollectionViewTool *)tool {
//    self.contentView.backgroundColor = [UIColor arc4Color];
    self.avatarImageV.image = [UIImage kj_imageNamed:model.imageUrl];
    CertifiedStatus certifiedStatus = model.certifiedStatus;
    
    NSString *status = nil;
    switch (certifiedStatus) {
        case CertifiedStatus_verified:
            status = @"已认证";
            break;
        case CertifiedStatus_noVerified:
            status = @"待实名认证";
            break;
            
        default:
            break;
    }
    
    [self.certifiedBtn setTitle:status forState:UIControlStateNormal];
}



@end
