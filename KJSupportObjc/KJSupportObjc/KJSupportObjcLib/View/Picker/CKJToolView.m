//
//  CKJToolView.m
//  WDYHFSDK
//
//  Created by chenkaijie on 2018/9/15.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CKJToolView.h"
#import <Masonry/Masonry.h>
#import "NSObject+WDYHFCategory.h"



@interface CKJFlagView : UIView
@end

@implementation CKJFlagView
@end



@interface CKJToolView ()

@property (strong, nonatomic) UIBarButtonItem *titleItem;

@end

@implementation CKJToolView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *bgV = [[UIView alloc] init];
        [self addSubview:bgV];
        
#warning 是“所有”添加到bgV上的视图，如果有约束冲突，我一般设置右边和下面约束优先级
        
        [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgV.superview);
            make.top.equalTo(bgV.superview);
            make.right.equalTo(bgV.superview);
            make.bottom.equalTo(bgV.superview);
        }];
        
        UIColor *grayColor = [UIColor grayColor];
        
        self.toolBar = ({
            UIToolbar *bar = [[UIToolbar alloc] init];
            bar.tintColor = grayColor;
            [bgV addSubview:bar];
            [bar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(bar.superview).offset(20);
                make.top.equalTo(bar.superview);
                make.right.equalTo(bar.superview).offset(-20).priority(999);
                make.height.equalTo(@50).priority(999);
            }];
            
            UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStyleDone) target:self action:@selector(cancelAction:)];
            UIBarButtonItem *confirm = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:(UIBarButtonItemStyleDone) target:self action:@selector(doneAction:)];
            UIBarButtonItem *date = ({
                UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"选择时间" style:(UIBarButtonItemStyleDone) target:self action:nil];
                [item setTitleTextAttributes:@{NSForegroundColorAttributeName : grayColor} forState:(UIControlStateDisabled)];
                item.enabled = NO;
                self.titleItem = item;
                item;
            });
            
            UIBarButtonItem *fix1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:nil action:nil];
            
            bar.items = @[cancel, fix1, date, fix1, confirm];
            bar;
        });
        self.bottomContentView = ({
            UIView *bottomV = [[CKJFlagView alloc] init];
            [self addSubview:bottomV];
            [bottomV kjwd_mas_makeConstraints:^(MASConstraintMaker *make, UIView *superview) {
                make.left.equalTo(superview);
                make.top.equalTo(self.toolBar.mas_bottom);
                make.right.equalTo(superview).priority(999);
                make.bottom.equalTo(superview).priority(999);
            }];
            bottomV;
        });
    }
    return self;
}

- (void)cancelAction:(UIBarButtonItem *)sender {
    self.cancelBlock ? self.cancelBlock(self) : nil;
}
- (void)doneAction:(UIBarButtonItem *)sender {
//    self.confirmBlock ? self.confirmBlock(nil, self) : nil;
    NSLog(@"需要子类处理该事件");
}

- (void)setTitle:(NSString *)title {
    _title = title;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.titleItem.title = title;
    });
}

@end
