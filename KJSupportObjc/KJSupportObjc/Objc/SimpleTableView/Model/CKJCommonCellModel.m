//
//  CKJCommonCellModel.m
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/7/4.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "CKJCommonCellModel.h"
#import "NSObject+WDYHFCategory.h"

@interface CKJCommonCellModel ()

@property (weak, nonatomic) __kindof CKJCommonTableViewCell *cell;

@property (strong, nonatomic, nullable) NSArray <NSString *>*groupIds;

@end

@implementation CKJCommonCellModel

- (instancetype)init {
    if (self = [super init]) {
        self.displayInTableView = YES;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.showLine = YES;
        self.bgVColor = [UIColor whiteColor];
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

- (void)addGroupId:(nonnull NSString *)groupId {
    if (WDKJ_IsEmpty_Str(groupId)) {
        return;
    }
    NSMutableArray *arr = [NSMutableArray kjwd_arrayWithArray:self.groupIds];
    [arr addObject:groupId];
    self.groupIds = arr;
}
- (void)removeGroupId:(nonnull NSString *)groupId {
    if (WDKJ_IsEmpty_Str(groupId)) {
        return;
    }
    NSMutableArray *arr = [NSMutableArray kjwd_arrayWithArray:self.groupIds];
    [arr removeObject:groupId];
    self.groupIds = arr;
}



@end
