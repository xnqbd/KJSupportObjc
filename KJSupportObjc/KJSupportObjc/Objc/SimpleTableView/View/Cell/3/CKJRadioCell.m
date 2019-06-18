//
//  CKJPayCell.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/3/24.
//  Copyright © 2019年 Lyc. All rights reserved.
//

#import "CKJRadioCell.h"
#import "NSObject+WDYHFCategory.h"
#import "CKJSimpleTableView.h"


@implementation CKJRadioCellConfig

+ (nonnull instancetype)configWithDetailSettingBlock:(nullable CKJRadioCellConfigBlock)detailSettingBlock {
    return [super configWithDetailSettingBlock:detailSettingBlock];
}

- (instancetype)init {
    if (self = [super init]) {
        self.leftImageView_MarginToSuperViewLeft = 15;
        self.leftImageSize = CGSizeMake(40, 40);
        
        self.image_margin_title = 10;
        self.title_margin_subTitle = 7;
        self.radioBtn_leftMargin = 5;
        self.radioBtn_rightMargin = 12;
    }
    return self;
}

+ (nonnull instancetype)appearanceForProject {
    CKJRadioCellConfig *radioConfig = [CKJRadioCellConfig configWithDetailSettingBlock:^(CKJRadioCellConfig * _Nonnull m) {
        // 下面这注释的设置了默认值， 需要修改的话可以自己设置
        //        m.leftImageView_MarginToSuperViewLeft = 15;
        //        m.leftImageSize = CGSizeMake(30, 30);
        //        m.image_margin_title = 12;
        //        m.title_margin_subTitle = 7;
        
        //        m.radioBtn_leftMargin = 5;
        //        m.radioBtn_rightMargin = 15;
        
        CGSize size = CGSizeMake(22, 22);
        
        m.normal_Image = [[UIImage imageNamed:@"wdyhfsdk勾选空"] kjwd_scaleToSize:size];
        m.selected_Image = [[UIImage imageNamed:@"wdyhfsdk勾选"] kjwd_scaleToSize:size];
        m.radioBtnSize = CGSizeMake(50, 44);
    }];
    return radioConfig;
}



@end

@implementation CKJRadioCellModel

- (instancetype)init {
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.extension_Interger = 216372;
    }
    return self;
}

@end

@implementation CKJRadioCell

- (void)setupSubViews {
    [super setupSubViews];
    
    
    CKJRadioCellConfig *config = self.configModel;
    
    WDCKJ_ifDEBUG(^{
        if (config == nil || ([config isKindOfClass:[CKJRadioCellConfig class]] == NO)) {
            NSException *exception = [NSException exceptionWithName:@"未配置Config对象" reason:[NSString stringWithFormat:@"%@警告！请配置一个 CKJRadioCellConfig或它的子类", self] userInfo:nil];
            [exception raise];
        }
    }, nil);
    
    
    
    UIButton *wrapperBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [wrapperBtn addTarget:self action:@selector(click_RadioBtn) forControlEvents:UIControlEventTouchUpInside];
    wrapperBtn.backgroundColor = [UIColor clearColor];
    [self.bgV addSubview:wrapperBtn];
    [wrapperBtn kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.edges.equalTo(superview);
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
    
    CGFloat right = config.radioBtn_rightMargin;
    CGFloat left = config.radioBtn_leftMargin;
    CGSize size = config.radioBtnSize;
    
    
    [self.radioBtn  setContentHuggingPriority:255 forAxis:UILayoutConstraintAxisHorizontal];
    [self.radioBtn  setContentCompressionResistancePriority:755 forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.radioBtn kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
        make.centerY.equalTo(superview);
        make.left.equalTo(superview).offset(left);
        make.right.equalTo(superview).offset(-(right));
        make.width.equalTo(@(size.width));
        make.height.equalTo(@(size.height));
    }];
    
    [self.radioBtn setImage:normal_Image forState:UIControlStateNormal];
    [self.radioBtn setImage:selected_Image forState:UIControlStateSelected];
}

- (void)click_RadioBtn {
    NSMutableArray <NSIndexPath *>*array = [NSMutableArray array];
    
    [self.simpleTableView.radioCellModels enumerateObjectsUsingBlock:^(__kindof CKJRadioCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.radio_Selected = NO;
        [array addObject:[NSIndexPath indexPathForRow:obj.cell.row inSection:obj.cell.section]];
    }];
    
    self.cellModel.radio_Selected = YES;

    WDCKJdispatch_async_main_queue(^{
        [UIView performWithoutAnimation:^{
            [self.simpleTableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationNone];
        }];
    });
}




@end
