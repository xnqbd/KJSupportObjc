//
//  SpaceLabel.h
//  KJProduct
//
//  Created by uback on 2018/3/19.
//  Copyright © 2018年 uback. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - -------------UILabel-------------
IB_DESIGNABLE

@interface SpaceLabel : UILabel
/**
 *  改变行间距
 */
- (void)changeLineSpace:(CGFloat)space;

/**
 *  改变字间距
 */
- (void)changeWordSpace:(CGFloat)space;

/**
 *  改变行间距和字间距
 */
- (void)changeLineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace;

/**
 *  可设计的 行间距
 */
@property (assign, nonatomic) IBInspectable CGFloat lineSpace;

/**
 *  可设计的 字间距
 */
@property (assign, nonatomic) IBInspectable CGFloat wordSpace;

@end


