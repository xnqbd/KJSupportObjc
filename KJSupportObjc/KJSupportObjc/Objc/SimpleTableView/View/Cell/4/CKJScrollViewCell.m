//
//  CKJBaseFunctionCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/14.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJScrollViewCell.h"

@implementation CKJScrollViewCellItemData


+ (NSArray <__kindof CKJScrollViewCellItemData *>*_Nonnull)scrollViewCellItemsWithDics:(NSArray <NSDictionary *>*_Nullable)dics detailSetting:(void(^_Nullable)(__kindof __weak CKJScrollViewCellItemData *_Nonnull itemData, NSUInteger index))detailSetting {
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 0; i < dics.count; i++) {
        NSDictionary *dic = dics[i];
        CKJScrollViewCellItemData *m = [[self alloc] init];
        [m kjwd_setValuesForKeysWithDictionary:dic];
        if (detailSetting) {
            detailSetting(m, i);
        }
        [result addObject:m];
    }
    return result;
}


@end

@implementation CKJScrollViewCellItemView
@end

@implementation CKJScrollViewCellConfig

- (instancetype)init {
    if (self = [super init]) {
        self.showIndicator = NO;
    }
    return self;
}

@end


@implementation CKJScrollViewCellModel


- (instancetype)init {
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)addItem:(__kindof CKJScrollViewCellItemData *)item {
    if ([item isKindOfClass:[CKJScrollViewCellItemData class]] == NO) return;
    NSMutableArray *array = [NSMutableArray kjwd_arrayWithArray:self.data];
    [array addObject:item];
    self.data = array;
}

@end




@interface CKJScrollViewCell ()

@property (strong, nonatomic) NSArray <__kindof CKJScrollViewCellItemView *>*viewArrs;

@end


@implementation CKJScrollViewCell

- (void)setupData:(__kindof CKJScrollViewCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    if ([model isKindOfClass:[CKJScrollViewCellModel class]] == NO) return;
    
    NSArray <__kindof CKJScrollViewCellItemData *>*data = model.data;
    
    NSArray <__kindof CKJScrollViewCellItemView *> *viewArrs = self.viewArrs;
    
    __weak CKJScrollViewCellConfig *config = self.configModel;
    __weak id <CKJScrollViewCellDelegate>delegate = config.delegate;
    
    
    for (int i = 0; i < viewArrs.count; i++) {
        CKJScrollViewCellItemData *itemData = [data kjwd_objectAtIndex:i];
        CKJScrollViewCellItemView *view = viewArrs[i];
        view.itemData = itemData;

        if ([delegate respondsToSelector:@selector(updateItemView:itemData:index:)]) {
            [delegate updateItemView:view itemData:itemData index:i];
        }
    }
}

- (void)setupSubViews {
    
   __weak CKJScrollViewCellConfig *config = self.configModel;
    __weak id <CKJScrollViewCellDelegate>delegate = config.delegate;

    
    WDCKJ_ifDEBUG(^{
        if (config == nil || ([config isKindOfClass:[CKJScrollViewCellConfig class]] == NO)) {
            NSException *exception = [NSException exceptionWithName:@"未配置Config对象" reason:[NSString stringWithFormat:@"%@必须配置一个继承于CKJScrollViewCellConfig的对象", self] userInfo:nil];
            [exception raise];
        }
    }, nil);
    
    
    if (
        ([delegate respondsToSelector:@selector(createItemViewForCKJScrollViewCell:)] == NO)
        ||
        ([delegate respondsToSelector:@selector(updateItemView:itemData:index:)] == NO)
        ) {
        NSException *exception = [NSException exceptionWithName:@"必须实现CKJScrollViewCellDelegate协议中的方法" reason:[NSString stringWithFormat:@"%@警告！必须实现CKJScrollViewCellDelegate协议中的方法", self] userInfo:nil];
        [exception raise];
    }
    
    UIScrollView *scrollV = [[UIScrollView alloc] init];
    scrollV.showsHorizontalScrollIndicator = config.showIndicator;
//    WDCKJBGColor_Arc4Color(scrollV);
    [self.subviews_SuperView addSubview:scrollV];
    [scrollV kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.edges.equalTo(superview).insets(config.scrollView_Edge_SuperView);
    }];
    
    NSArray <__kindof CKJScrollViewCellItemView *>*viewArrs = [delegate createItemViewForCKJScrollViewCell:self];
    self.viewArrs = viewArrs;
    
    UIEdgeInsets edge = config.items_Edge_ScrollView;
    
    CGFloat top = edge.top;
    CGFloat left = edge.left;
    CGFloat bottom = edge.bottom;
    CGFloat right = edge.right;
    
    
    CGFloat itemSpace = config.itemSpace ? config.itemSpace : 0;
    CGFloat itemWidth = config.itemWidth ? config.itemWidth : 0;
 
    [scrollV kjwd_viewsOfHorizontal:viewArrs viewWidth:itemWidth itemSpacing:itemSpace leftSpacing:left rightSpacing:right vorizontalConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.top.equalTo(superview).offset(top);
        make.bottom.equalTo(superview).offset(-(bottom));
    }];
}


@end
