//
//  CKJSimpleTableViewStyle.m
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/12/6.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJSimpleTableViewStyle.h"
#import "CKJInputCell.h"

//@implementation CKJShareStyle
//
//- (instancetype)init {
//    if (self = [super init]) {
//        self.title_MarginTo_SuperViewLeft = 15;
//        self.rightLabel_MarginTo_SuperViewRight = self.title_MarginTo_SuperViewLeft;
//    }
//    return self;
//}
//
//@end


@implementation CKJSectionCornerStyle

- (instancetype)init {
    if (self = [super init]) {
        self.sectionCornerEnable = YES;
        self.corner_Radius = 10;
        self.stroke_Color = [UIColor whiteColor];
    }
    return self;
}

@end


@implementation CKJInputTitleStyle

+ (instancetype)styleWithLeft:(NSNumber *_Nullable)left titleWidth:(NSNumber *_Nullable)titleWidth detail:(void(^_Nullable)(CKJInputTitleStyle *cs))detail {
    CKJInputTitleStyle *style = [[CKJInputTitleStyle alloc] init];
    if (!WDKJ_IsNull_Num(left)) {
        style.left = left.floatValue;
    }
    if (!WDKJ_IsNull_Num(titleWidth)) {
        style.titleWidth = titleWidth;
    }
    if (detail) {
        detail(style);
    }
    return style;
}

- (instancetype)init {
    if (self = [super init]) {
        self.left = kO_super_margin_title;
        self.titleAttributes = @{NSForegroundColorAttributeName : [UIColor kjwd_title], NSFontAttributeName : [UIFont systemFontOfSize:kOConst_Input_Tf_FontSize]};
    }
    return self;
}

@end


@interface CKJSimpleTableViewStyle ()

@property (weak, nonatomic) CKJSimpleTableView *readOnly_tableView;

@end


@implementation CKJSimpleTableViewStyle

- (instancetype)initWithTableView:(CKJSimpleTableView *)tableView {
    if (self = [super init]) {
        
        self.haveTitleStyle = [[CKJInputTitleStyle alloc] init];
        self.sectionFooterHeight = @10;
        self.sectionHeaderHeight = @0;
        self.lineEdge = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
        self.tfTextAttributed = @{NSForegroundColorAttributeName : [UIColor kjwd_title], NSFontAttributeName : [UIFont systemFontOfSize:kOConst_Input_Tf_FontSize]};
        self.tfPlaceHolderAttributed = @{NSForegroundColorAttributeName : [UIColor kjwd_r:190 g:190 b:190 alpha:1], NSFontAttributeName : [UIFont systemFontOfSize:kOConst_Input_Tf_FontSize]};
        self.tfAlignment = NSTextAlignmentLeft;
        self.tfStyle_Right = 15;
        self.cellBGConfig = [[CKJCommonCellBGImageViewConfig alloc] init];
        self.backgroundColor = [UIColor kjwd_rbg:247 alpha:1];
    
        tableView.backgroundColor = self.backgroundColor;
        
        self.readOnly_tableView = tableView;
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _backgroundColor = backgroundColor;
    self.readOnly_tableView.backgroundColor = backgroundColor;
}

- (void)setOnlyViewEdge:(NSValue *)onlyViewEdge {
    if (_onlyViewEdge == onlyViewEdge) return;
    if (!WDKJ_IsNullObj(onlyViewEdge, [NSValue class])) {
        _onlyViewEdge = onlyViewEdge;
        self.needUpdateOnlyViewConstraints = YES;
    }
}


@end
