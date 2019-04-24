//
//  CKJCommonCellModel.m
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/7/4.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "CKJCommonCellModel.h"

@interface CKJCommonCellModel ()

@property (weak, nonatomic) __kindof CKJCommonTableViewCell *cell;

@end

@implementation CKJCommonCellModel

- (instancetype)init {
    if (self = [super init]) {
        self.displayInTableView = YES;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.showLine = YES;
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}


+ (instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJCommonCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJCommonCellModelRowBlock)didSelectRowBlock {
    CKJCommonCellModel *model = [[self alloc] init];
    model.cellHeight = cellHeight;
    if ([cellModel_id isKindOfClass:[NSNumber class]]) {
        model.cellModel_id = cellModel_id.integerValue;
    }
    if (detailSettingBlock) {
        detailSettingBlock(model);
    }
    model.didSelectRowBlock = didSelectRowBlock;
    return model;
}

- (void)_privateMethodWithCell:(nonnull CKJCommonTableViewCell *)cell {
    self.cell = cell;
}


- (__kindof CKJCommonTableViewCell *)cell {
    return _cell;
}


@end
