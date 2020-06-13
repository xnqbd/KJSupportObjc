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

@implementation CKJStackCellConfig

- (instancetype)init {
    if (self = [super init]) {
        self.separatorViewColor = [UIColor kjwd_230Color];
    }
    return self;
}

@end

@implementation CKJStackCellModel

- (void)addItem:(id _Nullable)item {
    NSMutableArray *array = [NSMutableArray kjwd_arrayWithArray:self.stackItems];
    [array kjwd_addObject:item];
    self.stackItems = array;
}

+ (nonnull instancetype)stackWithCellHeight:(nullable NSNumber *)cellHeight cellModel_id:(nullable NSString *)cellModel_id detailSettingBlock:(nullable CKJStackCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJStackCellModelRowBlock)didSelectRowBlock {
    return [self commonWithCellHeight:cellHeight cellModel_id:cellModel_id detailSettingBlock:detailSettingBlock didSelectRowBlock:didSelectRowBlock];
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
 
    NSArray *data = model.stackItems;

    NSArray<__kindof UIView *> *views = self.views;

    __weak CKJStackCellConfig *config = self.configModel;
    __weak id <CKJStackCellDelegate>delegate = config.delegate;
    
    for (int i = 0; i < views.count; i++) {
        UIView *view = views[i];
        id itemData = [data kjwd_objectAtIndex:i];
        if ([delegate respondsToSelector:@selector(updateStackItemView:itemData:index:)]) {
            [delegate updateStackItemView:view itemData:itemData index:i];
        }
    }
    
    NSNumber *left = model.stackView_leftMargin;
    NSNumber *right = model.stackView_rightMargin;
    NSNumber *top = model.stackView_topMargin;
    NSNumber *bottom = model.stackView_bottomMargin;
    
//    UIEdgeInsets edge = model.stackView_Edge_SuperView;
    [self.stackView.superview kjwd_mas_updateConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
        make.edges.equalTo(superview).insets(UIEdgeInsetsMake(top.floatValue, left.floatValue, bottom.floatValue, right.floatValue));
    }];
}

- (void)setupSubViews {
    
//    __weak typeof(self) weakSelf = self;
    
    __weak CKJStackCellConfig *config = self.configModel;
    __weak id <CKJStackCellDelegate>delegate = config.delegate;
    
//    UIEdgeInsets edge = config.stackView_Edge_SuperView;
    UIEdgeInsets edge = UIEdgeInsetsZero;
    
    if (config == nil || ([config isKindOfClass:[CKJStackCellConfig class]] == NO)) {
        NSException *exception = [NSException exceptionWithName:@"未配置Config对象" reason:[NSString stringWithFormat:@"%@警告！请配置一个 CKJStackCellConfig或它的子类", self] userInfo:nil];
        [exception raise];
    }
    
    if (
        ([delegate respondsToSelector:@selector(createItemViewForCKJStackCell:)] == NO) ||
        ([delegate respondsToSelector:@selector(updateStackItemView:itemData:index:)] == NO)
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
//    stackView_superView.backgroundColor = [UIColor redColor];
    [self.subviews_SuperView addSubview:stackView_superView];
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
    
    if (config.detailSettingStackView_superView) {
        config.detailSettingStackView_superView(stackView_superView);
    }
    
    BOOL debug = NO;
    if (debug) {
        separatorView.backgroundColor = [UIColor clearColor];
        stackView_superView.backgroundColor = [UIColor redColor];
        [items enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.backgroundColor = [UIColor kjwd_arc4Color];
        }];
    }
}



@end
