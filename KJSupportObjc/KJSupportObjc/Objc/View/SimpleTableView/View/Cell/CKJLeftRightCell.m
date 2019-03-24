//
//  CKJLeftRightCell.m
//  Masonry
//
//  Created by chenkaijie on 2019/1/7.
//

#import "CKJLeftRightCell.h"

#import <Masonry/Masonry.h>
#import "NSObject+WDYHFCategory.h"

@implementation CKJLeftRightCellModel

+ (instancetype)modelWithLeftMargin:(CGFloat)leftMargin centerMargin:(CGFloat)centerMargin rightMargin:(CGFloat)rightMargin {
    CKJLeftRightCellModel *model = [[self alloc] init];
    model.leftLab_MarginTo_SuperView = leftMargin;
    model.centerMargin = centerMargin;
    model.rightLab_MarginTo_SuperView = rightMargin;
    return model;
}

+ (instancetype)modelWithCellHeight:(CGFloat)cellHeight cellModel_id:(nullable NSNumber *)cellModel_id detailSettingBlock:(nullable CKJLeftRightCellModelRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJLeftRightCellModelRowBlock)didSelectRowBlock {
    return [super modelWithCellHeight:cellHeight cellModel_id:cellModel_id detailSettingBlock:detailSettingBlock didSelectRowBlock:didSelectRowBlock];
}

- (instancetype)init {
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.leftLab_textAlignment = NSTextAlignmentLeft;
        self.rightLab_textAlignment = NSTextAlignmentLeft;
    }
    return self;
}

@end


@implementation CKJLeftRightCell

- (void)setupData:(CKJCommonCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    if ([model isKindOfClass:[CKJLeftRightCellModel class]] == NO) return;
    
    CKJLeftRightCellModel *_model = (CKJLeftRightCellModel *)model;
    
    if (_model.showLine) {
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    } else {
        self.separatorInset = UIEdgeInsetsMake(0, self.bounds.size.width + 1000, 0, 0);
    }
    
    NSString *leftStr = _model.leftStr;
    NSString *rightStr = _model.rightStr;
    
    NSAttributedString *leftAttStr = _model.leftAttStr;
    NSAttributedString *rightAttStr = _model.rightAttStr;
    
    if ([leftStr isKindOfClass:[NSString class]]) {
        self.leftLab.text = leftStr;
    }
    if ([rightStr isKindOfClass:[NSString class]]) {
        self.rightLab.text = rightStr;
    }
    
    if ([leftAttStr isKindOfClass:[NSAttributedString class]]) {
        self.leftLab.attributedText = leftAttStr;
    }
    if ([rightAttStr isKindOfClass:[NSAttributedString class]]) {
        self.rightLab.attributedText = rightAttStr;
    }
    self.leftLab.textAlignment = _model.leftLab_textAlignment;
    self.rightLab.textAlignment = _model.rightLab_textAlignment;
    
    CGFloat leftMargin = _model.leftLab_MarginTo_SuperView;
    CGFloat centerMargin = _model.centerMargin;
    CGFloat rightMargin = _model.rightLab_MarginTo_SuperView;
    
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
    [title setContentHuggingPriority:500 forAxis:(UILayoutConstraintAxisHorizontal)];
    [self.bgV addSubview:title];
    self.leftLab = title;
    
    UILabel *subTitle = [UILabel new];
    subTitle.numberOfLines = 0;
    //    WDCKJBGColor_Arc4Color(subTitle);
    subTitle.textColor = [UIColor kjwd_subTitleColor969696];
    subTitle.font = [UIFont systemFontOfSize:15];
    [self.bgV addSubview:subTitle];
    self.rightLab = subTitle;
    
    NSNumber *widthNumber = WDKJ_ConfirmDic(self.configDic)[configDicKEY_leftLab_width];
    CGFloat width = WDKJ_ConfirmNumber(widthNumber).doubleValue;
    
    NSNumber *multipliedNumber = WDKJ_ConfirmDic(self.configDic)[configDicKEY_leftLab_width_MultipliedBySuperView];
    CGFloat multiplied = WDKJ_ConfirmNumber(multipliedNumber).doubleValue;
    
    NSNumber *topMargin = WDKJ_ConfirmDic(self.configDic)[configDicKEY_leftLabel_TopMarginToSuperView];
    
    [title kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(superview);
        if (WDKJ_IsNull_Num(topMargin)) {
            make.centerY.equalTo(superview);
        } else {
            CGFloat margin = topMargin.floatValue;
            make.top.equalTo(superview).offset(margin);
        }
        if (multiplied > 0) {
            make.width.equalTo(superview).multipliedBy(multiplied);
        } else {
            if (width > 0) {
                make.width.equalTo(@(width));
            }
        }
    }];
    
    NSNumber *leftRightAlignment = WDKJ_ConfirmDic(self.configDic)[configDicKEY_leftRightAlignment];
    
    NSNumber *bottomMargin = WDKJ_ConfirmDic(self.configDic)[configDicKEY_rightLabel_BottomMarginToSuperView];
    
    [subTitle kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.equalTo(title.mas_right);
        
        if (WDKJ_IsNull_Num(bottomMargin)) {
            make.bottom.equalTo(superview).offset(-5);
        } else {
            make.bottom.equalTo(superview).offset(-(bottomMargin.floatValue));
        }
        
        if (WDKJ_ConfirmNumber(leftRightAlignment).integerValue == CKJEnum_LeftRightAlignment_Top) {
            make.top.equalTo(title);
        } else {
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
