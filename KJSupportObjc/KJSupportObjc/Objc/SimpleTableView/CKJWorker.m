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


NSString *_Nonnull const cellKEY = @"cellKEY";
NSString *_Nonnull const isRegisterNibKEY = @"isRegisterNibKEY";
NSString *_Nonnull const configDicKEY_ConfigModel = @"configDicKEY_ConfigModel";
NSString *_Nonnull const headerFooterKey = @"headerFooterKey";



NSString *_Nonnull const cNormalAttTitle = @"cNormalAttTitle";
NSString *_Nonnull const cNormalImage = @"cNormalImage";
NSString *_Nonnull const cNormalBgImage = @"cNormalBgImage";

NSString *_Nonnull const cSelectedAttTitle = @"cSelectedAttTitle";
NSString *_Nonnull const cSelectedImage = @"cSelectedImage";
NSString *_Nonnull const cSelectedBgImage = @"cSelectedBgImage";


NSString *_Nonnull const cHighlightedAttTitle = @"cHighlightedAttTitle";
/** 高亮时候的image */
NSString *_Nonnull const cHighlightedImage = @"cHighlightedImage";
/** 高亮时候的bgImage */
NSString *_Nonnull const cHighlightedBgImage = @"cHighlightedBgImage";


NSString *_Nonnull const cBorderWidth = @"cBorderWidth";
NSString *_Nonnull const cBorderColor = @"cBorderColor";
NSString *_Nonnull const cCornerRadius = @"cCornerRadius";



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
        
        
        m.normalAttTitle = dic[cNormalAttTitle];
        m.normalImage = dic[cNormalImage];
        m.normalBgImage = dic[cNormalBgImage];
        
        m.selectedAttTitle = dic[cSelectedAttTitle];
        m.selectedImage = dic[cSelectedImage];
        m.selectedBgImage = dic[cSelectedBgImage];
        
        m.highlightedAttTitle = dic[cHighlightedAttTitle];
        m.highlightedImage = dic[cHighlightedImage];
        m.highlightedBgImage = dic[cHighlightedBgImage];
        
        m.borderWidth = WDKJ_ConfirmNumber(dic[cBorderWidth]).floatValue;
        m.borderColor = dic[cBorderColor];
        m.cornerRadius = WDKJ_ConfirmNumber(dic[cCornerRadius]).floatValue;
        
        if (detailSetting) {
            detailSetting(m, i);
        }
        
        [result addObject:m];
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

