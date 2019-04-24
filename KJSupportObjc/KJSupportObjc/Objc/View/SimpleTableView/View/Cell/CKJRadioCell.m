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
        self.radioBtn_rightMargin = 15;
    }
    return self;
}

@end

@implementation CKJRadioCellModel

- (instancetype)init {
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.kj_enumValue = 216372;
    }
    return self;
}

@end

@implementation CKJRadioCell

- (void)setupSubViews {
    [super setupSubViews];
    
    
    CKJRadioCellConfig *config = self.configDic[configDicKEY_ConfigModel];
    if ([config isKindOfClass:[CKJRadioCellConfig class]] == NO) {
        NSLog(@"警告！请使用CKJRadioCellConfig或它的子类");
        return;
    }
    
    UIButton *wrapperBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [wrapperBtn addTarget:self action:@selector(radioBtnAction) forControlEvents:UIControlEventTouchUpInside];
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

- (void)radioBtnAction {
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
