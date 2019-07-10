//
//  CKJLeftRightCell.m
//  Masonry
//
//  Created by chenkaijie on 2019/1/7.
//

#import "CKJLeftRightCell.h"
#import "NSObject+WDYHFCategory.h"


@implementation CKJLeftRightCellBaseConfig

- (instancetype)init {
    if (self = [super init]) {
        self.rightLabel_BottomMarginToSuperView = 5;
    }
    return self;
}

@end

@implementation CKJLeftRightCellTopEqualConfig



+ (nonnull instancetype)configWithLeftLabelTopMargin:(CGFloat)LeftLabelTopMargin detailSettingBlock:(nullable CKJLeftRightCellTopEqualConfigBlock)detailSettingBlock {
    CKJLeftRightCellTopEqualConfig *config = [[CKJLeftRightCellTopEqualConfig alloc] init];
    config.leftLabel_TopMarginToSuperView = LeftLabelTopMargin;
    if (detailSettingBlock) {
        detailSettingBlock(config);
    }
    return config;
}

@end

@implementation CKJLeftRightCellCenterEqualConfig

+ (nonnull instancetype)configWithDetailSettingBlock:(nullable CKJLeftRightCellCenterEqualConfigBlock)detailSettingBlock {
    return [super configWithDetailSettingBlock:detailSettingBlock];
}

@end



@implementation CKJLeftRightCellModel

+ (instancetype)modelWithLeftMargin:(CGFloat)leftMargin centerMargin:(CGFloat)centerMargin rightMargin:(CGFloat)rightMargin {
    CKJLeftRightCellModel *model = [[self alloc] init];
    model.leftLab_MarginTo_SuperViewLeft = leftMargin;
    model.centerMargin = centerMargin;
    model.rightLab_MarginTo_SuperViewRight = rightMargin;
    return model;
}

+ (instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJLeftRightCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJLeftRightCellModelRowBlock)didSelectRowBlock {
    return [super modelWithCellHeight:cellHeight cellModel_id:cellModel_id detailSettingBlock:detailSettingBlock didSelectRowBlock:didSelectRowBlock];
}


- (instancetype)init {
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.showLine = NO;
        self.leftLab_textAlignment = NSTextAlignmentLeft;
        self.rightLab_textAlignment = NSTextAlignmentRight;
    }
    return self;
}

@end


@implementation CKJLeftRightCell

- (void)setupData:(CKJCommonCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    if ([model isKindOfClass:[CKJLeftRightCellModel class]] == NO) return;
    
    CKJLeftRightCellModel *_model = (CKJLeftRightCellModel *)model;
    
    NSAttributedString *leftAttStr = _model.leftAttStr;
    NSAttributedString *rightAttStr = _model.rightAttStr;
    
    self.leftLab.attributedText = WDKJ_SpaceAttString(leftAttStr);
    self.rightLab.attributedText = WDKJ_SpaceAttString(rightAttStr);
    
    self.leftLab.textAlignment = _model.leftLab_textAlignment;
    self.rightLab.textAlignment = _model.rightLab_textAlignment;
    
    CGFloat leftMargin = _model.leftLab_MarginTo_SuperViewLeft;
    CGFloat centerMargin = _model.centerMargin;
    CGFloat rightMargin = _model.rightLab_MarginTo_SuperViewRight;
    
    [self.leftLab kjwd_mas_updateConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(superview).offset(leftMargin);
    }];
    [self.rightLab kjwd_mas_updateConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(self.leftLab.mas_right).offset(centerMargin);
        make.right.equalTo(superview).offset(-(rightMargin));
    }];
}

- (void)setupSubViews {
    
    UILabel *title = [UILabel new];
    //    title.numberOfLines = 0;
    //    WDCKJBGColor_Arc4Color(title);
    title.textColor = [UIColor kjwd_titleColor333333];
    title.font = [UIFont systemFontOfSize:15];
    
    [self.subviews_SuperView addSubview:title];
    self.leftLab = title;
    
    UILabel *subTitle = [UILabel new];
    subTitle.numberOfLines = 0;
    //    WDCKJBGColor_Arc4Color(subTitle);
    subTitle.textColor = [UIColor kjwd_subTitleColor969696];
    subTitle.font = [UIFont systemFontOfSize:15];
    [self.subviews_SuperView addSubview:subTitle];
    self.rightLab = subTitle;
    
    
    [subTitle setContentHuggingPriority:240 forAxis:UILayoutConstraintAxisHorizontal];
    [subTitle setContentCompressionResistancePriority:740 forAxis:UILayoutConstraintAxisHorizontal];

    
    CKJLeftRightCellBaseConfig *config = self.configModel;
   
    WDCKJ_ifDEBUG(^{
        if (config == nil || ([config isKindOfClass:[CKJLeftRightCellBaseConfig class]] == NO)) {
            NSException *exception = [NSException exceptionWithName:@"未配置Config对象" reason:[NSString stringWithFormat:@"%@必须配置一个继承于CKJLeftRightCellBaseConfig的对象，推荐使用CKJLeftRightCellTopEqualConfig或者CKJLeftRightCellCenterEqualConfig", self] userInfo:nil];
            [exception raise];
        }
    }, nil);
  
    

    CGFloat width = config.leftLab_width;
    
    CGFloat multiplied = config.leftLab_width_MultipliedBySuperView;
    
    
    [title kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(superview);
        
        if ([config isKindOfClass:[CKJLeftRightCellTopEqualConfig class]])  { // 顶部对齐
            CKJLeftRightCellTopEqualConfig *temp = (CKJLeftRightCellTopEqualConfig *)config;
            make.top.equalTo(superview).offset(temp.leftLabel_TopMarginToSuperView);
        } else { // 默认中心对齐
            make.centerY.equalTo(superview);
        }
        
        if (multiplied > 0) {
            make.width.equalTo(superview).multipliedBy(multiplied);
        } else {
            if (width > 0) {
                make.width.equalTo(@(width));
            }
        }
    }];
    
    
    [subTitle kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(title.mas_right);
        make.bottom.equalTo(superview).offset(-(config.rightLabel_BottomMarginToSuperView));
        if ([config isKindOfClass:[CKJLeftRightCellTopEqualConfig class]])  { // 顶部对齐
            make.top.equalTo(title);
        } else { // 默认中心对齐
            make.centerY.equalTo(title);
        }
        make.right.equalTo(superview);
    }];
    
    
    BOOL debug = NO;
    if (debug) {
        self.leftLab.backgroundColor = [UIColor redColor];
        self.rightLab.backgroundColor = [UIColor brownColor];
    }
}


@end

