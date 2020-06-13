//
//  CKJBaseTableViewCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/5/27.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseTableViewCell.h"

@implementation CKJBaseTableViewCellModel


+ (instancetype)baseTableViewCellWithCellHeight:(nullable NSNumber *)cellHeight cellModel_id:(nullable NSString *)cellModel_id detailSettingBlock:(nullable CKJBaseTableViewCellRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJBaseTableViewCellRowBlock)didSelectRowBlock {
    return [self commonWithCellHeight:cellHeight cellModel_id:cellModel_id detailSettingBlock:detailSettingBlock didSelectRowBlock:didSelectRowBlock];
}

+ (NSMutableArray <__kindof CKJBaseTableViewCellModel *>*_Nonnull)tableViewCellWithExtensionObjs:(NSArray *)extensionObjs detailSetting:(void(^)(__kindof CKJBaseTableViewCellModel *_Nonnull m, id extensionObj))detailSetting {
    NSMutableArray *arr = [NSMutableArray array];
    for (id model in extensionObjs) {
        CKJBaseTableViewCellModel *m = [[self alloc] init];
        m.extension_Obj1 = model;
        if (detailSetting) {
            detailSetting(m, model);
        }
        [arr addObject:m];
    }
    return arr;
}



- (void)_setText:(nullable NSString *)text {
    self.attText = WDCKJAttributed2(text, [UIColor kjwd_colorWithHexString:@"333333"], @16);
}
- (instancetype)init {
    if (self = [super init]) {
        CGFloat topBottom = 10;
        CGFloat leftRight = 15;
        self.edge = UIEdgeInsetsMake(topBottom, leftRight, topBottom, leftRight);
        self.textAlignment = NSTextAlignmentLeft;
        self.numberOfLines = 1;
    }
    return self;
}

@end


@interface CKJBaseTableViewCell ()

@property (strong, nonatomic) UILabel *titleLab;

@end


@implementation CKJBaseTableViewCell


- (void)setupData:(CKJBaseTableViewCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    if ([model isKindOfClass:[CKJBaseTableViewCellModel class]] == NO) return;
    
    NSAttributedString *attText = model.attText;
    UIEdgeInsets edge = model.edge;
    NSInteger numberOfLines = model.numberOfLines;
    NSTextAlignment alignment = model.textAlignment;
    
    UILabel *titleLab = self.titleLab;
    
    titleLab.attributedText = WDKJ_ConfirmAttString(attText);
    [titleLab kjwd_mas_updateConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.edges.equalTo(superview).insets(edge);
    }];
    if (titleLab.numberOfLines != numberOfLines) {
        titleLab.numberOfLines = numberOfLines;
    }
    if (titleLab.textAlignment != alignment) {
        titleLab.textAlignment = alignment;
    }
}

- (void)setupSubViews {
    
    UILabel *title = [UILabel new];
    //    WDCKJBGColor_Arc4Color(title);
    title.textColor = [UIColor kjwd_title];
    title.font = [UIFont systemFontOfSize:15];
    
    [self.subviews_SuperView addSubview:title];
    self.titleLab = title;
}


@end
