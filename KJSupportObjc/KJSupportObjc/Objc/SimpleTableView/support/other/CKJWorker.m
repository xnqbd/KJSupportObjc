//
//  CKJWorker.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/16.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJWorker.h"
#import "NSObject+WDYHFCategory.h"
#import "CKJCommonTableViewCell.h"
#import "CKJBaseBtnsCell.h"
#import "UIView+CKJDesingable.h"

NSString *_Nonnull const KJPrefix_cellKEY = @"KJPrefix_cellKEY";
NSString *_Nonnull const KJPrefix_isRegisterNibKEY = @"KJPrefix_isRegisterNibKEY";
NSString *_Nonnull const KJPrefix_configDicKEY_ConfigModel = @"KJPrefix_configDicKEY_ConfigModel";
NSString *_Nonnull const KJPrefix_headerFooterKey = @"KJPrefix_headerFooterKey";



NSString *_Nonnull const KJPrefix_cNormalAttTitle = @"KJPrefix_cNormalAttTitle";
NSString *_Nonnull const KJPrefix_cNormalImage = @"KJPrefix_cNormalImage";
NSString *_Nonnull const KJPrefix_cNormalBgImage = @"KJPrefix_cNormalBgImage";

NSString *_Nonnull const KJPrefix_cSelectedAttTitle = @"KJPrefix_cSelectedAttTitle";
NSString *_Nonnull const KJPrefix_cSelectedImage = @"KJPrefix_cSelectedImage";
NSString *_Nonnull const KJPrefix_cSelectedBgImage = @"KJPrefix_cSelectedBgImage";


NSString *_Nonnull const KJPrefix_cHighlightedAttTitle = @"KJPrefix_cHighlightedAttTitle";
/** 高亮时候的image */
NSString *_Nonnull const KJPrefix_cHighlightedImage = @"KJPrefix_cHighlightedImage";
/** 高亮时候的bgImage */
NSString *_Nonnull const KJPrefix_cHighlightedBgImage = @"KJPrefix_cHighlightedBgImage";


NSString *_Nonnull const KJPrefix_cBorderWidth = @"KJPrefix_cBorderWidth";
NSString *_Nonnull const KJPrefix_cBorderColor = @"KJPrefix_cBorderColor";
NSString *_Nonnull const KJPrefix_cCornerRadius = @"KJPrefix_cCornerRadius";



@implementation CKJWorker

+ (NSAttributedString *_Nonnull)changeOriginAtt:(nullable NSAttributedString *)origin text:(nullable NSString *)text {
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:WDKJ_ConfirmAttString(origin)];
    [att replaceCharactersInRange:NSMakeRange(0, att.length) withString:WDKJ_ConfirmString(text)];
    return att;
}

+ (NSBundle *_Nonnull)kjbundle {
    NSBundle *mainBundle = [NSBundle bundleForClass:[CKJCommonTableViewCell class]];
    
    NSBundle *resourcesBundle = [NSBundle bundleWithPath:[mainBundle pathForResource:@"KJSupportObjc" ofType:@"bundle"]];
    
    if (resourcesBundle == nil) {
        resourcesBundle = mainBundle;
    }
    return resourcesBundle;
}


+ (void)reloadWithBtnModel:(CKJBaseBtnModel *)btn5Model btn:(UIButton *)btn5 emptyHandle:(void(^)(__kindof CKJBaseBtnModel *btnM))emptyHandle noEmptyHandle:(void(^)(__kindof CKJBaseBtnModel *btnM))noEmptyHandle  {
    
    [btn5 setAttributedTitle:btn5Model.normalAttributedTitle forState:UIControlStateNormal];
    [btn5 setAttributedTitle:btn5Model.selectedAttributedTitle forState:UIControlStateSelected];
    
    UIImage *normalBackgroundImage =  btn5Model.normalBackgroundImage;
    UIImage *selectedBackgroundImage = btn5Model.selectedBackgroundImage;
    UIImage *normalImage = btn5Model.normalImage;
    UIImage *selectedImage = btn5Model.selectedImage;
    
    normalBackgroundImage = WDKJ_IsNullObj(normalBackgroundImage, [UIImage class]) ? nil : normalBackgroundImage;
    selectedBackgroundImage = WDKJ_IsNullObj(selectedBackgroundImage, [UIImage class]) ? nil : selectedBackgroundImage;
    normalImage = WDKJ_IsNullObj(normalImage, [UIImage class]) ? nil : normalImage;
    selectedImage =  WDKJ_IsNullObj(selectedImage, [UIImage class]) ? nil : selectedImage;
    
    [btn5 setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
    [btn5 setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
    [btn5 setImage:normalImage forState:UIControlStateNormal];
    [btn5 setImage:selectedImage forState:UIControlStateSelected];
    
    BOOL emptyAttributedTitle = WDKJ_IsEmpty_Str(btn5.currentAttributedTitle.string);
    BOOL emptyImage = btn5.currentImage == nil;
    BOOL emptyBackgroundImage = btn5.currentBackgroundImage == nil;
    // 如果什么都没有， 那么就width = 0
    
    // [subTitle4  btn5  View5  tfWrapperView  kjSwitch6   btn7]
    
    if ((emptyAttributedTitle && emptyImage && emptyBackgroundImage) || btn5Model.btnHidden) {
        if (emptyHandle) {
            emptyHandle(btn5Model);
        }
    } else {
        if (noEmptyHandle) {
            noEmptyHandle(btn5Model);
        }
        
        if (btn5Model.cornerRadius > 0) {
            btn5.layer.cornerRadius = btn5Model.cornerRadius;
            btn5.clipsToBounds = YES;
        } else {
            btn5.layer.cornerRadius = 0;
            btn5.clipsToBounds = NO;
        }
        btn5.layer.borderColor = btn5Model.borderColor.CGColor;
        btn5.layer.borderWidth = btn5Model.borderWidth;
        btn5.selected = btn5Model.selected;
        btn5.userInteractionEnabled = btn5Model.userInteractionEnabled;
        
        if (btn5Model.layoutButton) {
            btn5Model.layoutButton(btn5);
        }
    }
    
    [btn5 kjwd_setHidden:btn5Model.btnHidden];
}

+ (void)reloadBtn:(UIButton *)btn btnData:(CKJBtnItemData *)itemData {
    // 这里的 itemData是 CKJBtnItemData 或者 CKJBtnItemData类型的
    
    if (![itemData isKindOfClass:[CKJBtnItemData class]]) return;
    
    btn.selected = itemData.selected;
    btn.highlighted = itemData.highlighted;
    btn.enabled = itemData.enabled;
    
    NSAttributedString *normalAttTitle = itemData.normalAttTitle;
    UIImage *normalImage = itemData.normalImage;
    UIImage *normalBgImage = itemData.normalBgImage;
    
    NSAttributedString *selectedAttTitle = itemData.selectedAttTitle;
    UIImage *selectedImage = itemData.selectedImage;
    UIImage *selectedBgImage = itemData.selectedBgImage;
    
    NSAttributedString *highlightedAttTitle = itemData.highlightedAttTitle;
    UIImage *highlightedImage = itemData.highlightedImage;
    UIImage *highlightedBgImage = itemData.highlightedBgImage;
    
    // 请确保 title 是 NSAttributedString 类型的，不然会崩溃
    
    // normal
    [btn setAttributedTitle:normalAttTitle forState:UIControlStateNormal];
    [self btn:btn image:normalImage forState:UIControlStateNormal];
    [self btn:btn bgImage:normalBgImage forState:UIControlStateNormal];
    
    // select
    [btn setAttributedTitle:selectedAttTitle forState:UIControlStateSelected];
    [self btn:btn image:selectedImage forState:UIControlStateSelected];
    [self btn:btn bgImage:selectedBgImage forState:UIControlStateSelected];
    
    // highlighted
    [btn setAttributedTitle:highlightedAttTitle forState:UIControlStateHighlighted];
    [self btn:btn image:highlightedImage forState:UIControlStateHighlighted];
    [self btn:btn bgImage:highlightedBgImage forState:UIControlStateHighlighted];
    
    if (btn.kBorderWidth != itemData.borderWidth) {
        btn.kBorderWidth = itemData.borderWidth;
    }
    if (btn.kBorderColor != itemData.borderColor) {
        btn.kBorderColor = itemData.borderColor;
    }
    if (btn.kCornerRadius != itemData.cornerRadius) {
        btn.kCornerRadius = itemData.cornerRadius;
    }
    
    if (itemData.layout_Button) {
        itemData.layout_Button(btn);
    }
}

+ (void)btn:(UIButton *)btn image:(UIImage *)image forState:(UIControlState)state {
    if (WDKJ_IsNullObj(image, [UIImage class])) {
        // 重置图片
        [btn setImage:nil forState:state];
    } else {
        [btn setImage:image forState:state];
    }
}
+ (void)btn:(UIButton *)btn bgImage:(UIImage *)bgImage forState:(UIControlState)state {
    if (WDKJ_IsNullObj(bgImage, [UIImage class])) {
        // 重置图片
        [btn setBackgroundImage:nil forState:state];
    } else {
        [btn setBackgroundImage:bgImage forState:state];
    }
}




@end


@implementation CKJCommonItemData
@end

@implementation CKJCommonItemView
@end


@interface CKJBtnItemData ()

@end

@implementation CKJBtnItemData


- (instancetype)init {
    if (self = [super init]) {
        self.enabled = YES;
    }
    return self;
}


+ (NSArray <__kindof CKJBtnItemData *>*_Nonnull)returnItemsWithDics:(NSArray <NSDictionary *>*_Nullable)dics detailSetting:(void(^_Nullable)(__kindof CKJBtnItemData *__weak _Nonnull itemData, NSUInteger index))detailSetting {
    
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 0; i < dics.count; i++) {
        NSDictionary *dic = dics[i];
        CKJBtnItemData *m = [[self alloc] init];
        
        
        m.normalAttTitle = dic[KJPrefix_cNormalAttTitle];
        m.normalImage = dic[KJPrefix_cNormalImage];
        m.normalBgImage = dic[KJPrefix_cNormalBgImage];
        
        m.selectedAttTitle = dic[KJPrefix_cSelectedAttTitle];
        m.selectedImage = dic[KJPrefix_cSelectedImage];
        m.selectedBgImage = dic[KJPrefix_cSelectedBgImage];
        
        m.highlightedAttTitle = dic[KJPrefix_cHighlightedAttTitle];
        m.highlightedImage = dic[KJPrefix_cHighlightedImage];
        m.highlightedBgImage = dic[KJPrefix_cHighlightedBgImage];
        
        m.borderWidth = WDKJ_ConfirmNumber(dic[KJPrefix_cBorderWidth]).floatValue;
        m.borderColor = dic[KJPrefix_cBorderColor];
        m.cornerRadius = WDKJ_ConfirmNumber(dic[KJPrefix_cCornerRadius]).floatValue;
        
        if (detailSetting) {
            detailSetting(m, i);
        }
        
        [result addObject:m];
    }
    return result;
}

+ (NSArray <NSArray <CKJBtnItemData *> *>*_Nonnull)returnItemsWithDicsnew:(NSArray <NSArray <NSDictionary *> *>*_Nullable)dics detailSetting:(void(^_Nullable)(CKJBtnItemData *__weak _Nonnull itemData, NSUInteger index))detailSetting {
    NSMutableArray *result = [NSMutableArray array];
    for (NSArray *temp in dics) {
        NSArray <CKJBtnItemData *>*res = [self returnItemsWithDics:temp detailSetting:detailSetting];
        [result addObject:res];
    }
    return result;
}



- (void)setNormalAttTitle:(NSAttributedString *)normalAttTitle {
    if (WDKJ_IsEmpty_AttributedStr(normalAttTitle)) {
        _normalAttTitle = nil;
    } else {
        _normalAttTitle = normalAttTitle;
    }
}
- (void)setSelectedAttTitle:(NSAttributedString *)selectedAttTitle {
    if (WDKJ_IsEmpty_AttributedStr(selectedAttTitle)) {
        _selectedAttTitle = nil;
    } else {
        _selectedAttTitle = selectedAttTitle;
    }
}
- (void)setHighlightedAttTitle:(NSAttributedString *)highlightedAttTitle {
    if (WDKJ_IsEmpty_AttributedStr(highlightedAttTitle)) {
        _highlightedAttTitle = nil;
    } else {
        _highlightedAttTitle = highlightedAttTitle;
    }
}





@end



@implementation CKJBaseBtnModel


- (void)changeNormalText:(nullable NSString *)text {
    self.normalAttributedTitle = [CKJWorker changeOriginAtt:self.normalAttributedTitle text:text];
}
- (void)changeSelectedText:(nullable NSString *)text {
    self.selectedAttributedTitle = [CKJWorker changeOriginAtt:self.selectedAttributedTitle text:text];
}


- (instancetype)init {
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

@end




@implementation CKJMyVCItem

+ (instancetype)itemWithImage:(nullable id)image title:(id)title click:(CKJMyVCItemClick)click {
    CKJMyVCItem *item = [[self alloc] init];
    item.image = image;
    item.title = title;
    item.click = click;
    return item;
}

@end
