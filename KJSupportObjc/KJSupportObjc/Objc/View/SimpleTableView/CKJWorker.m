//
//  CKJWorker.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/16.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJWorker.h"
#import "NSObject+WDYHFCategory.h"

@implementation CKJWorker

+ (NSAttributedString *_Nonnull)changeOriginAtt:(nullable NSAttributedString *)origin text:(nullable NSString *)text {
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:WDKJ_ConfirmAttString(origin)];
    [att replaceCharactersInRange:NSMakeRange(0, att.length) withString:WDKJ_ConfirmString(text)];
    return att;
}

@end
