//
//  RJExpertItemView.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/6/13.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "RJDemoExpertItemView.h"
#import "UIView+CKJDesingable.h"

@implementation RJDemoExpertItemData

@end

@implementation RJDemoExpertItemView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.wrapper.backgroundColor = [UIColor whiteColor];
    [self.wrapper kjwd_cornerRadius:4 shadowColor:nil shadowOffset:CGSizeZero shadowOpacity:nil shadowRadius:@5];
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    RJDemoExpertItemData *itemData = self.itemData;
    if (itemData.tapBlock) {
        itemData.tapBlock();
    }
}


@end
