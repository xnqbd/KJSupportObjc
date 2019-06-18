//
//  CKJStackCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/14.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJStackCell.h"
#import "CKJSimpleTableView.h"
#import "CKJBtnsCell.h"

@implementation CKJStackCellItemData

@end

@implementation CKJStackCellConfig


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

@end

@implementation CKJStackCell


- (void)setupData:(__kindof CKJStackCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    if ([model isKindOfClass:[CKJStackCellModel class]] == NO) return;
 
    NSArray <__kindof CKJStackCellItemData *>*data = model.data;

    NSArray<__kindof UIView *> *arrangedSubviews = self.stackView.arrangedSubviews;

    __weak CKJStackCellConfig *config = self.configModel;
    __weak id <CKJStackCellDelegate>delegate = config.delegate;
    
    for (int i = 0; i < arrangedSubviews.count; i++) {
        UIView *view = arrangedSubviews[i];
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

    for (UIView *temp in items) {
        if ([temp isKindOfClass:[UIView class]] == NO) {
            NSException *exception = [NSException exceptionWithName:@"添加到CKJStackCell上的必须都是UIView或UIView子类" reason:[NSString stringWithFormat:@"%@警告！添加到CKJStackCell上的必须都是UIView或UIView子类", self] userInfo:nil];
            [exception raise];
        }
    }
    
    CGFloat h_itemSpacing = config.h_itemSpacing;
    
    UIStackView *stackV = [[UIStackView alloc] init];
    stackV.spacing = h_itemSpacing;
    stackV.axis = UILayoutConstraintAxisHorizontal;
    stackV.distribution = UIStackViewDistributionFillEqually;
    stackV.alignment = UIStackViewAlignmentFill;
    [self.bgV addSubview:stackV];
    self.stackView = stackV;
    [stackV kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.edges.equalTo(superview).insets(edge);
    }];
    
    for (UIView *temp in items) {
        [stackV addArrangedSubview:temp];
    }
}



@end
