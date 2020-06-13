//
//  CKJCommonCellModel.m
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/7/4.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "CKJCommonCellModel.h"
#import "NSObject+WDYHFCategory.h"

@implementation CKJCommonCellBGImageViewConfig

- (instancetype)init {
    if (self = [super init]) {
        self.bgColor = [UIColor whiteColor];
        self.contentMode = UIViewContentModeScaleToFill;
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    if (_image == image) return;
    if (!WDKJ_IsNullObj(image, [UIImage class])) {
        _image = image;
    }
}
- (void)setBgColor:(UIColor *)bgColor {
    if (_bgColor == bgColor) return;
    if (!WDKJ_IsNullObj(bgColor, [UIColor class])) {
        _bgColor = bgColor;
    }
}


@end





@interface CKJCommonCellModel ()

@property (weak, nonatomic) __kindof CKJCommonTableViewCell *cell;

@property (strong, nonatomic, nullable) NSArray <NSString *>*groupIds;

@end

@implementation CKJCommonCellModel

- (instancetype)init {
    if (self = [super init]) {
        self.displayInTableView = YES;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.bgConfig = [[CKJCommonCellBGImageViewConfig alloc] init];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)updateBGConfig:(void(^_Nullable)(CKJCommonCellBGImageViewConfig *bg))BGConfig {
    if (BGConfig) {
        BGConfig(self.bgConfig);
    }
}

- (void)_showLine:(BOOL)show {
    if (show) {
        self.lineEdge = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    } else {
        self.lineEdge = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 2000, 0, 0)];
    }
}


+ (instancetype)commonWithCellHeight:(nullable NSNumber *)cellHeight cellModel_id:(nullable NSString *)cellModel_id detailSettingBlock:(nullable CKJCommonCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJCommonCellModelRowBlock)didSelectRowBlock {
    CKJCommonCellModel *model = [[self alloc] init];
    if ([cellHeight isEqualToNumber:@0]) {
        model.cellHeight = @(UITableViewAutomaticDimension);
    } else {
        model.cellHeight = cellHeight;
    }
    
    model.cellModel_id = cellModel_id;
    
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
