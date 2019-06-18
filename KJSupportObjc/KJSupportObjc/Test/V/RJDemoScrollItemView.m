//
//  RJHomeScrollItem.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/6/13.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "RJDemoScrollItemView.h"
#import "UIView+CKJDesingable.h"

@implementation RJDemoScrollItemData

@end


@implementation RJDemoScrollItemView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageV.kBorderColor = [UIColor kjwd_r:220 g:220 b:220 alpha:1];
//    self.imageV.kBorderColor = [UIColor redColor];
    self.imageV.kBorderWidth = 1;
    self.imageV.kCornerRadius = 5;
}


- (IBAction)tap:(UITapGestureRecognizer *)sender {
    RJDemoScrollItemData *itemData = self.itemData;
    if (itemData.tapBlock) {
        itemData.tapBlock();
    }
}


@end
