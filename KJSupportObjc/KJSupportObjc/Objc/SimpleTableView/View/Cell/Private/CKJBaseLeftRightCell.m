//
//  CKJLeftRightCell.m
//  Masonry
//
//  Created by chenkaijie on 2019/1/7.
//

#import "CKJBaseLeftRightCell.h"
#import "NSObject+WDYHFCategory.h"
#import "CKJLeftRightTopEqualCell.h"


@implementation CKJBaseLeftRightCellConfig

- (instancetype)init {
    if (self = [super init]) {
        self.rightLabel_BottomMarginToSuperView = 5;
    }
    return self;
}

@end



@implementation CKJBaseLeftRightCellModel

+ (instancetype)modelWithLeftMargin:(CGFloat)leftMargin centerMargin:(CGFloat)centerMargin rightMargin:(CGFloat)rightMargin {
    CKJBaseLeftRightCellModel *model = [[self alloc] init];
    model.leftLab_MarginTo_SuperViewLeft = leftMargin;
    model.centerMargin = centerMargin;
    model.rightLab_MarginTo_SuperViewRight = rightMargin;
    return model;
}

+ (instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJBaseLeftRightCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJBaseLeftRightCellModelRowBlock)didSelectRowBlock {
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


@implementation CKJBaseLeftRightCell

- (void)setupData:(CKJCommonCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    if ([model isKindOfClass:[CKJBaseLeftRightCellModel class]] == NO) return;
    
    CKJBaseLeftRightCellModel *_model = (CKJBaseLeftRightCellModel *)model;
    
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

    
    CKJBaseLeftRightCellConfig *config = self.configModel;
   
    WDCKJ_ifDEBUG(^{
        if (config == nil || ([config isKindOfClass:[CKJBaseLeftRightCellConfig class]] == NO)) {
            NSException *exception = [NSException exceptionWithName:@"未配置Config对象" reason:[NSString stringWithFormat:@"%@必须配置一个继承于CKJBaseLeftRightCellConfig的对象，推荐使用CKJLeftRightTopEqualCellConfig或者CKJLeftRightCenterEqualCellConfig", self] userInfo:nil];
            [exception raise];
        }
    }, nil);
  
    

    CGFloat width = config.leftLab_width;
    
    CGFloat multiplied = config.leftLab_width_MultipliedBySuperView;
    
    
    [title kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(superview);
        
        if ([config isKindOfClass:[CKJLeftRightTopEqualCellConfig class]])  { // 顶部对齐
            CKJLeftRightTopEqualCellConfig *temp = (CKJLeftRightTopEqualCellConfig *)config;
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
        if ([config isKindOfClass:[CKJLeftRightTopEqualCellConfig class]])  { // 顶部对齐
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

