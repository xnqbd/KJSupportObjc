//
//  CKJLeftRightCell.m
//  Masonry
//
//  Created by chenkaijie on 2019/1/7.
//

#import "CKJBaseLeftRightCell.h"
#import "NSObject+WDYHFCategory.h"
#import "CKJLeftRightTopEqualCell.h"
#import "CKJSimpleTableView.h"

NSString *_Nonnull const kOLR_Left_Title = @"kOLR_Left_Title";
NSString *_Nonnull const kOLR_Right_Title = @"kOLR_Right_Title";


@implementation CKJBaseLeftLabelSetting

- (instancetype)init {
    if (self = [super init]) {
        self.leftLab_MarginTo_SuperViewLeft = @(kOCell_Left_Margin);
    }
    return self;
}

@end

@implementation CKJBaseRightLabelSetting

- (instancetype)init {
    if (self = [super init]) {
        self.rightLab_MarginTo_SuperViewRight = @(kOCell_Left_Margin);
    }
    return self;
}


@end

@implementation CKJBaseLeftRightCellModel


- (void)setLeftAttStr:(NSAttributedString *)leftAttStr {
    if ([leftAttStr isKindOfClass:[NSString class]]) {
        _leftAttStr = WDAttTitle((NSString *)leftAttStr);
    } else if ([leftAttStr isKindOfClass:[NSAttributedString class]]) {
        _leftAttStr = leftAttStr;
    } else if (leftAttStr == nil) {
        _leftAttStr = nil;
    }
    self.readOnly_leftLabel.attributedText = _leftAttStr;
}

- (void)setRightAttStr:(NSAttributedString *)rightAttStr {
    if ([rightAttStr isKindOfClass:[NSString class]]) {
        _rightAttStr = WDAttSubTitle((NSString *)rightAttStr);
    } else if ([rightAttStr isKindOfClass:[NSAttributedString class]]) {
        _rightAttStr = rightAttStr;
    } else if (rightAttStr == nil) {
        _rightAttStr = nil;
    }
    self.readOnly_rightLabel.attributedText = _leftAttStr;
}


- (instancetype)init {
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self _showLine:NO];
        self.leftLab_textAlignment = NSTextAlignmentLeft;
        self.rightLab_textAlignment = NSTextAlignmentRight;
    }
    return self;
}

+ (NSMutableArray <__kindof CKJBaseLeftRightCellModel *>*)lrWithdics:(NSArray <NSDictionary <NSString *, id> *>*)dics detail:(void(^)(__kindof CKJBaseLeftRightCellModel *))detail {
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 0; i < dics.count; i++) {
        NSDictionary *dic = WDKJ_ConfirmDic(dics[i]);
        CKJBaseLeftRightCellModel *m = [[self alloc] init];
        m.leftAttStr = dic[kOLR_Left_Title];
        m.rightAttStr = dic[kOLR_Right_Title];
        if (detail) {
            detail(m);
        }
        [result addObject:m];
    }
    return result;
}

- (void)updateLeftRightMargin:(CGFloat)leftRightMargin {
    self.leftLabelSetting.leftLab_MarginTo_SuperViewLeft = @(leftRightMargin);
    self.rightLabelSetting.rightLab_MarginTo_SuperViewRight = @(leftRightMargin);
}


@end


@implementation CKJBaseLeftRightCell

- (void)setupData:(CKJCommonCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    if ([model isKindOfClass:[CKJBaseLeftRightCellModel class]] == NO) return;
    
    CKJBaseLeftRightCellModel *_model = (CKJBaseLeftRightCellModel *)model;
    
    _model.readOnly_leftLabel = _leftLab;
    _model.readOnly_rightLabel = _rightLab;
    
    NSAttributedString *leftAttStr = _model.leftAttStr;
    NSAttributedString *rightAttStr = _model.rightAttStr;
    
    
    self.leftLab.attributedText = WDKJ_SpaceAttString(leftAttStr);
    self.rightLab.attributedText = WDKJ_SpaceAttString(rightAttStr);
    
    self.leftLab.textAlignment = _model.leftLab_textAlignment;
    self.rightLab.textAlignment = _model.rightLab_textAlignment;
    
    // 重布局左右Label的代码在子类
}

- (void)setupSubViews {
    
    UILabel *title = [UILabel new];
    //    title.numberOfLines = 0;
    //    WDCKJBGColor_Arc4Color(title);
    title.textColor = [UIColor kjwd_title];
    title.font = [UIFont systemFontOfSize:15];
    
    [self.subviews_SuperView addSubview:title];
    self.leftLab = title;
    
    UILabel *subTitle = [UILabel new];
    subTitle.numberOfLines = 0;
    //    WDCKJBGColor_Arc4Color(subTitle);
    subTitle.textColor = [UIColor kjwd_subTitle];
    subTitle.font = [UIFont systemFontOfSize:15];
    [self.subviews_SuperView addSubview:subTitle];
    self.rightLab = subTitle;
    
    
    [subTitle setContentHuggingPriority:240 forAxis:UILayoutConstraintAxisHorizontal];
    [subTitle setContentCompressionResistancePriority:740 forAxis:UILayoutConstraintAxisHorizontal];

    

//    CGFloat width = 0;
//    
//    CGFloat multiplied = 0;
//    
//    
//    [title kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
//        make.left.equalTo(superview);
//        
//        if ([config isKindOfClass:[CKJLeftRightTopEqualCellConfig class]])  { // 顶部对齐
//            CKJLeftRightTopEqualCellConfig *temp = (CKJLeftRightTopEqualCellConfig *)config;
//            make.top.equalTo(superview).offset(temp.leftLabel_TopMarginToSuperView);
//        } else { // 默认中心对齐
//            make.centerY.equalTo(superview);
//        }
//        
//        if (multiplied > 0) {
//            make.width.equalTo(superview).multipliedBy(multiplied);
//        } else {
//            if (width > 0) {
//                make.width.equalTo(@(width));
//            }
//        }
//    }];
//    
//    
//    [subTitle kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
//        make.left.equalTo(title.mas_right);
//        make.bottom.equalTo(superview).offset(0);
//        if ([config isKindOfClass:[CKJLeftRightTopEqualCellConfig class]])  { // 顶部对齐
//            make.top.equalTo(title);
//        } else { // 默认中心对齐
//            make.centerY.equalTo(title);
//        }
//        make.right.equalTo(superview);
//    }];
//    
    
    BOOL debug = NO;
    if (debug) {
        self.leftLab.backgroundColor = [UIColor redColor];
        self.rightLab.backgroundColor = [UIColor brownColor];
    }
}


@end

