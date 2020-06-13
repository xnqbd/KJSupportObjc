//
//  CKJPayCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/7/8.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJPayCell.h"
#import "CKJSimpleTableView.h"

@implementation CKJPayCellConfig

- (instancetype)init {
    if (self = [super init]) {
//        self.leftImageView_MarginToSuperViewLeft = 15;
//        self.leftImageSize = CGSizeMake(40, 40);
//
//        self.image_margin_title = 10;
//        self.title_margin_subTitle = 7;
//        self.radioBtn_leftMargin = 5;
//        self.radioBtn_rightMargin = 12;
    }
    return self;
}

+ (nonnull instancetype)appearanceForProject {
    CKJPayCellConfig *radioConfig = [CKJPayCellConfig configWithDetail:^(CKJPayCellConfig * _Nonnull m) {
        
        m.fiveLabelViewEdge = UIEdgeInsetsMake(10, 12, 10, 0);
        [m updateImgConfig:^(CKJImageViewConfig * _Nonnull c) {
            c.imageSize = CGSizeMake(30, 30);
        }];
        
        CGSize size = CGSizeMake(22, 22);
        m.normal_Image = [[UIImage kjwd_imageNamed:@"wdyhfsdk勾选空"] kjwd_scaleToSize:size];
        m.selected_Image = [[UIImage kjwd_imageNamed:@"wdyhfsdk勾选"] kjwd_scaleToSize:size];
        m.radioBtnSize = CGSizeMake(50, 44);
        m.triggerStyle = CKJRadioCellTriggerStyle_SelectRow;
        
    }];
    return radioConfig;
}


@end


@implementation CKJPayCellModel

+ (nonnull instancetype)payWithCellHeight:(nullable NSNumber *)cellHeight cellModel_id:(nullable NSString *)cellModel_id detailSettingBlock:(nullable CKJPayCellRowBlock)detailSettingBlock didSelectRowBlock:(nullable CKJPayCellRowBlock)didSelectRowBlock {
    return [self commonWithCellHeight:cellHeight cellModel_id:cellModel_id detailSettingBlock:detailSettingBlock didSelectRowBlock:didSelectRowBlock];
}

- (instancetype)init {
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.extension_Interger = 216372;
    }
    return self;
}

@end

@implementation CKJPayCell

- (void)setupData:(__kindof CKJPayCellModel *)model section:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath tableView:(CKJSimpleTableView *)tableView {
    [super setupData:model section:section row:row selectIndexPath:indexPath tableView:tableView];
    if ([model isKindOfClass:[CKJPayCellModel class]] == NO) return;
    self.radioBtn.selected = model.radio_Selected;
}


- (void)setupSubViews {
    [super setupSubViews];
    
    CKJPayCellConfig *config = self.configModel;
    

    UIButton *wrapperBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [wrapperBtn addTarget:self action:@selector(click_RadioBtn) forControlEvents:UIControlEventTouchUpInside];
    wrapperBtn.backgroundColor = [UIColor clearColor];
    [self.onlyView addSubview:wrapperBtn];
    [wrapperBtn kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.edges.equalTo(superview);
    }];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(click_RadioBtn) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor clearColor];
    [self.subviews_SuperView addSubview:btn];
    self.radioBtn = btn;

    [btn kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.left.centerY.equalTo(superview);
        make.size.mas_equalTo(config.radioBtnSize);
        make.right.equalTo(superview).offset(-(config.radioBtn_rightMargin));
    }];
    
    CKJRadioCellTriggerStyle triggerStyle = config.triggerStyle;
    
    switch (triggerStyle) {
        case CKJRadioCellTriggerStyle_SelectRow:
            wrapperBtn.userInteractionEnabled = YES;
            self.radioBtn.userInteractionEnabled = NO;
            break;
        default:
            wrapperBtn.userInteractionEnabled = NO;
            self.radioBtn.userInteractionEnabled = YES;
            break;
    }
    
    UIImage *normal_Image = config.normal_Image;
    if (WDKJ_IsNullObj(normal_Image, [UIImage class])) {
        normal_Image = nil;
    }
    
    UIImage *selected_Image = config.selected_Image;
    if (WDKJ_IsNullObj(selected_Image, [UIImage class])) {
        selected_Image = nil;
    }
    
    
    [btn  setContentHuggingPriority:255 forAxis:UILayoutConstraintAxisHorizontal];
    [btn  setContentCompressionResistancePriority:755 forAxis:UILayoutConstraintAxisHorizontal];
    
    
    [btn setImage:normal_Image forState:UIControlStateNormal];
    [btn setImage:selected_Image forState:UIControlStateSelected];
}

- (void)click_RadioBtn {
    [self.simpleTableView triggerRadioActionWithCellModel:self.cellModel];
}

@end
