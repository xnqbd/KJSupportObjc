//
//  CKJTwoLabelAsCompleteView.h
//  Demo
//
//  Created by admin2 on 2020/4/7.
//  Copyright © 2020 admin2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKJCountingLabel.h"

NS_ASSUME_NONNULL_BEGIN


/*

 //    _twoLab.leftLabel.format = @"%d";
     _twoLab.leftLabel.attributedFormatBlock = ^NSAttributedString *(CGFloat value) {
     NSLog(@"%f   ", value);
     return WDCKJAttBold([NSString stringWithFormat:@"%ld /", (NSUInteger)value], [UIColor whiteColor], @50);
     };
     [_twoLab.leftLabel countFrom:0 to:142];
     
     
 //    _twoLab.rightLabel.format = @"%d";
     _twoLab.rightLabel.attributedFormatBlock = ^NSAttributedString *(CGFloat value) {
     NSLog(@"%f   ", value);
         return WDCKJAttBold([NSString stringWithFormat:@" %ld", (NSUInteger)value], [UIColor whiteColor], @50);
     };
     [_twoLab.rightLabel countFrom:0 to:78];
     
 */







// 只需要指定 origin位置，size大小根据两个label自适应， 在xib里可以直接看到效果，亲测
@interface CKJTwoLabelAsCompleteView : UIView

@property (strong, nonatomic) CKJCountingLabel *leftLabel;
@property (strong, nonatomic) CKJCountingLabel *rightLabel;

@end

NS_ASSUME_NONNULL_END
