//
//  CKJDatePickerView.m
//  WDYHFSDK
//
//  Created by chenkaijie on 2018/9/15.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CKJDatePickerView.h"
#import "NSObject+WDYHFCategory.h"
#import <Masonry/Masonry.h>

@implementation CKJDatePickerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.targetView = ({
            UIDatePicker *pick = [[UIDatePicker alloc] init];
            pick.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
            pick.datePickerMode = UIDatePickerModeDate;
            [self.bottomContentView addSubview:pick];
            [pick kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
                make.edges.equalTo(superview);
            }];
            pick;
        });
    }
    return self;
}

- (void)setDefaultDate:(NSDate *)defaultDate {
    _defaultDate = defaultDate;
    if ([defaultDate isKindOfClass:NSDate.class]) {
        [self.targetView setDate:defaultDate animated:YES];
    }
}

- (void)doneAction:(UIBarButtonItem *)sender {
    if (self.confirmBlock == nil) {
        return;
    }
    self.confirmBlock(self.targetView.date, self);
}

- (void)dealloc {
    NSLog(@"%@  dealloc", self);
}


@end
