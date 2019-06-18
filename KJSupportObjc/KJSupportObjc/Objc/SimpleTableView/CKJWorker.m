//
//  CKJWorker.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/16.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJWorker.h"
#import "NSObject+WDYHFCategory.h"


NSString *_Nonnull const cellKEY = @"cellKEY";
NSString *_Nonnull const isRegisterNibKEY = @"isRegisterNibKEY";
NSString *_Nonnull const registerNibNameKEY = @"registerNibNameKEY";
NSString *_Nonnull const configDicKEY_ConfigModel = @"configDicKEY_ConfigModel";
NSString *_Nonnull const headerFooterKey = @"headerFooterKey";

NSString *_Nonnull const cNormalAttTitle = @"cNormalAttTitle";
NSString *_Nonnull const cSelectedAttTitle = @"cSelectedAttTitle";

NSString *_Nonnull const cNormalImage = @"cNormalImage";
NSString *_Nonnull const cSelectedImage = @"cSelectedImage";
NSString *_Nonnull const cNormalBgImage = @"cNormalBgImage";
NSString *_Nonnull const cSelectedBgImage = @"cSelectedBgImage";

NSString *_Nonnull const cBorderWidth = @"cBorderWidth";
NSString *_Nonnull const cBorderColor = @"cBorderColor";
NSString *_Nonnull const cCornerRadius = @"cCornerRadius";



@implementation CKJWorker

+ (NSAttributedString *_Nonnull)changeOriginAtt:(nullable NSAttributedString *)origin text:(nullable NSString *)text {
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:WDKJ_ConfirmAttString(origin)];
    [att replaceCharactersInRange:NSMakeRange(0, att.length) withString:WDKJ_ConfirmString(text)];
    return att;
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
        m.selectedAttTitle = dic[cSelectedAttTitle];
        m.normalImage = dic[cNormalImage];
        m.selectedImage = dic[cSelectedImage];
        m.normalBgImage = dic[cNormalBgImage];
        m.selectedBgImage = dic[cSelectedBgImage];
        
        m.selectedImage = dic[cSelectedImage];
        m.normalBgImage = dic[cNormalBgImage];
        m.selectedBgImage = dic[cSelectedBgImage];
        
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


@end
