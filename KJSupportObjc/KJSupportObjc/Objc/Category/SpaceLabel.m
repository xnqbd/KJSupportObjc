//
//  SpaceLabel.m
//  KJProduct
//
//  Created by uback on 2018/3/19.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "SpaceLabel.h"

#pragma mark - -------------UILabel-------------

@implementation SpaceLabel

/**
 *  改变行间距
 */
- (void)changeLineSpace:(CGFloat)space {
    [self line_Space:space];
}

/**
 *  改变字间距
 */
- (void)changeWordSpace:(CGFloat)space {
    [self word_Space:space];
}

/**
 *  改变行间距和字间距
 */
- (void)changeLineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace {
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}

#pragma mark - 可设计的方法
- (void)setLineSpace:(CGFloat)lineSpace {
    [self line_Space:lineSpace];
}
- (void)setWordSpace:(CGFloat)wordSpace {
    [self word_Space:wordSpace];
}

#pragma mark - 间距方法
- (void)line_Space:(CGFloat)lineSpace {
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}
- (void)word_Space:(CGFloat)wordSpace {
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}

@end



