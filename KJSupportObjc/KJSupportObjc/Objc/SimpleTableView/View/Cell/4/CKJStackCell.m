//
//  CKJStackCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/14.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJStackCell.h"
#import "CKJSimpleTableView.h"
#import "CKJBaseBtnsCell.h"

@implementation CKJStackCellItemData

@end

@implementation CKJStackCellConfig

- (instancetype)init {
    if (self = [super init]) {
        self.separatorViewColor = [UIColor kjwd_230Color];
    }
    return self;
}

@end

@implementation CKJStackCellModel

- (void)addItem:(__kindof CKJStackCellItemData *)item {
    if ([item isKindOfClass:[CKJStackCellItemData class]] == NO) return;
    NSMutableArray *array = [NSMutableArray kjwd_arrayWithArray:self.data];
    [array addObject:item];
    self.data = array;
}

+ (nonnull instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJStackCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJStackCellModelRowBlock)didSelectRowBlock {
    return [super modelWithCellHeight:cellHeight cellModel_id:cellModel_id detailSettingBlock:detailSettingBlock didSelectRowBlock:didSelectRowBlock];
}

- (instancetype)init {
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end


@interface CKJStackCell ()

@property (strong, nonatomic) UIStackView *stackView;

@property (strong, nonatomic) NSArray *views;

@end

@implementation CKJStackCell


- (void)setupData:(__kindof CKJStackCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    if ([model isKindOfClass:[CKJStackCellModel class]] == NO) return;
 
    NSArray <__kindof CKJStackCellItemData *>*data = model.data;

    NSArray<__kindof UIView *> *views = self.views;

    __weak CKJStackCellConfig *config = self.configModel;
    __weak id <CKJStackCellDelegate>delegate = config.delegate;
    
    for (int i = 0; i < views.count; i++) {
        UIView *view = views[i];
        CKJStackCellItemData *itemData = [data kjwd_objectAtIndex:i];
        if ([delegate respondsToSelector:@selector(updateItemView:itemData:index:)]) {
            [delegate updateItemView:view itemData:itemData index:i];
        }
    }
}

- (void)setupSubViews {
    
//    __weak typeof(self) weakSelf = self;
    
    __weak CKJStackCellConfig *config = self.configModel;
    __weak id <CKJStackCellDelegate>delegate = config.delegate;
    
    UIEdgeInsets edge = config.stackView_Edge_SuperView;
    
    
    if (config == nil || ([config isKindOfClass:[CKJStackCellConfig class]] == NO)) {
        NSException *exception = [NSException exceptionWithName:@"未配置Config对象" reason:[NSString stringWithFormat:@"%@警告！请配置一个 CKJStackCellConfig或它的子类", self] userInfo:nil];
        [exception raise];
    }
    
    if (
        ([delegate respondsToSelector:@selector(createItemViewForCKJStackCell:)] == NO) ||
        ([delegate respondsToSelector:@selector(updateItemView:itemData:index:)] == NO)
        ) {
        NSException *exception = [NSException exceptionWithName:@"必须实现CKJStackCellDataSource协议中的方法" reason:[NSString stringWithFormat:@"%@警告！必须实现CKJStackCellDataSource协议中的方法", self] userInfo:nil];
        [exception raise];
    }
    
    
    NSArray <__kindof UIView *>*items = [delegate createItemViewForCKJStackCell:self];
    self.views = items;

    for (UIView *temp in items) {
        if ([temp isKindOfClass:[UIView class]] == NO) {
            NSException *exception = [NSException exceptionWithName:@"添加到CKJStackCell上的必须都是UIView或UIView子类" reason:[NSString stringWithFormat:@"%@警告！添加到CKJStackCell上的必须都是UIView或UIView子类", self] userInfo:nil];
            [exception raise];
        }
    }
    
    
    UIView *stackView_superView = [[UIView alloc] init];
    stackView_superView.backgroundColor = [UIColor whiteColor];
    [self.bgV addSubview:stackView_superView];
    [stackView_superView kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.edges.equalTo(superview).insets(edge);
    }];
    
    
    UIView *separatorView = [[UIView alloc] init];
    [stackView_superView addSubview:separatorView];
    
    
    CGFloat h_itemSpacing = config.h_itemSpacing;
    
    UIStackView *stackV = [[UIStackView alloc] init];
    stackV.spacing = h_itemSpacing;
    stackV.axis = UILayoutConstraintAxisHorizontal;
    stackV.distribution = UIStackViewDistributionFillEqually;
    stackV.alignment = UIStackViewAlignmentFill;
    [stackView_superView addSubview:stackV];
    self.stackView = stackV;
    [stackV kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.edges.equalTo(superview);
    }];
    for (UIView *temp in items) {
        [stackV addArrangedSubview:temp];
    }
    
    
    NSNumber *separatorViewHeight = WDKJ_ConfirmNumber(config.separatorViewHeight);
    NSNumber *multiHeightByStackView = WDKJ_ConfirmNumber(config.multiHeightByStackView);

    UIColor *separatorViewColor = config.separatorViewColor;
    if (WDKJ_IsNullObj(separatorViewColor, [UIColor class]) == NO) {
        separatorView.backgroundColor = separatorViewColor;
    }
    
    [separatorView kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.center.width.equalTo(stackV);
        
        if (separatorViewHeight.floatValue > 0) {
            make.height.equalTo(separatorViewHeight);
        } else if (multiHeightByStackView.floatValue > 0) { make.height.equalTo(stackV).multipliedBy(multiHeightByStackView.floatValue);
        } else {
            make.height.equalTo(@0);
        }
    }];
    
    if (config.detailSetting) {
        config.detailSetting(stackView_superView);
    }
}



@end
