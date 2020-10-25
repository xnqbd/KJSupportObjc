//
//  YWUnlockView.m
//  YWUnlock
//
//  Created by dyw on 2017/2/24.
//  Copyright © 2017年 dyw. All rights reserved.
//

#import "CKJGesturesUnlockView.h"
#import <Masonry/Masonry.h>
#import "NSObject+CKJMasonry.h"
#import "CKJSecret.h"



//@interface CKJGesturesItemView : UIView
//
//@property (copy, nonatomic) void (^_initStatusBlock)(void);
//@property (copy, nonatomic) void (^_selecdBlock)(void);
//@property (copy, nonatomic) void (^_errorBlock)(void);
//
////@property (strong, nonatomic) UIColor *_selectBorderColor;
////@property (strong, nonatomic) UIColor *_errorBorderColor;
//
//@property (strong, nonatomic) UIButton *bigBtn;
//
//@property (strong, nonatomic) UIButton *smallBtn;
//
//@end
//
//
//@implementation CKJGesturesItemView
//
//- (instancetype)init {
//    self = [super init];
//    if (self) {
//
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn kjwd_masWithSuperView:self makeConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
//            make.edges.equalTo(superview);
//        }];
//        self.bigBtn = btn;
//
//
//        UIButton *centerSmallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        centerSmallBtn.userInteractionEnabled = NO;
//        [centerSmallBtn kjwd_masWithSuperView:self makeConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
//            make.center.equalTo(superview);
//            make.size.mas_equalTo(CGSizeMake(30, 30));
//        }];
//
//        self.smallBtn = centerSmallBtn;
//
//        KJ_typeweakself
//
//
//        self._selecdBlock = ^{
//
////            weakSelf.targetBtn = [];
//
////            weakSelf.targetBtn.selected = YES;
////            weakSelf.centerSmallBtn.selected = YES;
//
//            weakSelf.layer.borderColor = [UIColor colorWithRed:199/255.0 green:214/255.0 blue:255/255.0 alpha:1.0].CGColor;
////            [weakSelf setImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#>];
//        };
//        self._errorBlock = ^{
//            weakSelf.layer.borderColor = [UIColor redColor].CGColor;
//
//        };
//
//        self._initStatusBlock = ^{
//            weakSelf.bigBtn.layer.borderColor = [UIColor blueColor].CGColor;
//        };
//
//        self._initStatusBlock ? self._initStatusBlock() : nil;
//
//
////        self._selectBorderColor = [UIColor blueColor];
////        self._errorBorderColor = [UIColor redColor];
////        KJ_typeweakself
//
//
////        NSBundle *resourcesBundle = [CKJWorker kjbundle];
////        UIImage *error = [UIImage imageNamed:@"kj_gesture_error.png" inBundle:resourcesBundle compatibleWithTraitCollection:nil];
////        error = [error kjwd_scaleToSize:CGSizeMake(50, 50)];
//
//
////                    CGRect rect = CGRectMake(0, 0, 30, 30);
////                    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
////                    CGContextRef context = UIGraphicsGetCurrentContext();
////                    [[UIColor orangeColor] setFill];
////                    CGContextFillEllipseInRect(context, rect);
////                    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
////                    UIGraphicsEndImageContext();
////
////                    [self setImage:image forState:UIControlStateNormal];
//
//
//
////        [self setImage:error forState:<#(UIControlState)#>];
//
////        self.layer.borderWidth = 1;
////
//    }
//    return self;
//}
//
//
//@end
//
//
//@interface CKJGesturesViewStyle : NSObject
//
//@property (strong, nonatomic) NSArray <UIButton *>*btns;
//
//- (void)updateBtnsStyle:(void(^)(UIButton *btn))updateBtnsStyle;
//
//
//@end
//
//@implementation CKJGesturesViewStyle
//
//- (void)updateBtnsStyle:(void(^)(UIButton *btn))updateBtnsStyle {
//
//}
//
//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        NSMutableArray *res = [NSMutableArray array];
//        for (int i = 0; i < 9; i++) {
//            CKJGesturesButton *btn = [CKJGesturesButton buttonWithType:UIButtonTypeCustom];
//
//            __weak CKJGesturesButton *weakBtn = btn;
////            btn._selecdBlock = ^{
//////                weakBtn.
////            };
//
//            btn.userInteractionEnabled = NO;
////            btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
////            btn.layer.borderWidth = 1;
//
//            btn.layer.borderWidth = 1.5;
//
//
////            CGRect rect = CGRectMake(0, 0, 30, 30);
////            UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
////            CGContextRef context = UIGraphicsGetCurrentContext();
////            [[UIColor systemRedColor] setFill];
////            CGContextFillEllipseInRect(context, rect);
////            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
////            UIGraphicsEndImageContext();
////
////            [btn setImage:image forState:UIControlStateSelected];
//
//
//
//            [res addObject:btn];
//        }
//        self.btns = res;
//    }
//    return self;
//}
//
//@end


@interface CKJGesturesView : UIView

@property (nonatomic, strong) NSMutableArray *selectedBtns;
@property (nonatomic, assign) CGPoint currentPoint;
@property (nonatomic, copy) void(^drawRectFinishedBlock)(NSString *gesturePassword);

@end


#define YWUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define columns 3 //总列数
#define linColor 0xffc8ad //线条颜色
#define linWidth 8 //线条宽度

#define gesBtnColor [UIColor systemBlueColor]


@implementation CKJGesturesView

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

//为什么要在这个方法中布局子控件，因为只调用这个方法，就表示父控件的尺寸确定
- (void)layoutSubviews {
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    CGFloat x = 0,y = 0,w = 0,h = 0;
    if ([UIScreen mainScreen].bounds.size.width == 320) {
        w = 50;
        h = 50;
    }else {
        w = 58;
        h = 58;
    }
    
    CGFloat margin = (self.bounds.size.width - columns * w) / (columns + 1);//间距
    CGFloat col = 0;
    CGFloat row = 0;
    for (int i = 0; i < count; i++) {
        col = i%columns;
        row = i/columns;
        x = margin + (w+margin)*col;
        y = margin + (w+margin)*row;
        if ([UIScreen mainScreen].bounds.size.height == 480) {
            y = (w+margin)*row;
        }else {
            y = margin +(w+margin)*row;
        }
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake(x, y, w, h);
        btn.layer.cornerRadius = w / 2.0;
    }
}

//只要调用这个方法就会把之前绘制的东西清空 重新绘制
- (void)drawRect:(CGRect)rect {
    if (self.selectedBtns.count == 0) return;
    // 把所有选中按钮中心点连线
    UIBezierPath *path = [UIBezierPath bezierPath];
    NSUInteger count = self.selectedBtns.count;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.selectedBtns[i];
        if (i == 0) {
            [path moveToPoint:btn.center];
        }else {
            [path addLineToPoint:btn.center];
        }
    }
    [path addLineToPoint:_currentPoint ];
    
    [[gesBtnColor colorWithAlphaComponent:0.4] set];
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = linWidth;
    [path stroke];
}


#pragma mark - private
- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
    
    self.selectedBtns = [NSMutableArray array];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    //创建9个按钮
    for (int i = 0; i < 9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btn.layer.borderWidth = 1;
        btn.userInteractionEnabled = NO;
        
        CGRect rect = CGRectMake(0, 0, 30, 30);
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [gesBtnColor setFill];
        CGContextFillEllipseInRect(context, rect);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [btn setImage:image forState:UIControlStateSelected];
        btn.tag = 1000 + i;
        [self addSubview:btn];
    }
}

#pragma mark - action pan
- (void)pan:(UIPanGestureRecognizer *)pan {
    _currentPoint = [pan locationInView:self];
    [self setNeedsDisplay];
    for (UIButton *button in self.subviews) {
        if (CGRectContainsPoint(button.frame, _currentPoint) && button.selected == NO) {
            button.selected = YES;
            [self.selectedBtns addObject:button];
        }
    }
    [self layoutIfNeeded];
    if (pan.state == UIGestureRecognizerStateEnded) {
        //保存输入密码
        NSMutableString *gesturePwd = [NSMutableString string];
        for (UIButton *button in self.selectedBtns) {
            [gesturePwd appendFormat:@"%ld",button.tag-1000];
            button.selected = NO;
        }
        [self.selectedBtns removeAllObjects];
        //手势密码绘制完成后回调
        !self.drawRectFinishedBlock?:self.drawRectFinishedBlock(gesturePwd);
    }
}


@end




@interface CKJGesturesSmallPreviewView : UIView

- (void)setGesturesPassword:(NSString *)gesturesPassword;

@property (nonatomic, strong) NSMutableArray *buttons;

@end


#define BTN_H 9
#define BTN_W 9


@implementation CKJGesturesSmallPreviewView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    int cols = 3;//总列数
    CGFloat x = 0,y = 0;//bounds
    CGFloat margin = (self.bounds.size.width - cols * BTN_W) / (cols + 1);//间距
    CGFloat col = 0;
    CGFloat row = 0;
    for (int i = 0; i < count; i++) {
        col = i%cols;
        row = i/cols;
        x = margin + (BTN_W+margin)*col;
        y = margin + (BTN_W+margin)*row;
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake(x, y, BTN_W, BTN_H);
    }
}

- (void)setup{
    CGSize size = CGSizeMake(8, 8);
    for (int i = 0; i < 9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.userInteractionEnabled = NO;
        
        [btn setImage:[UIImage kjwd_getStroke_ellipseWithSize:size color:[UIColor lightGrayColor] lineWidth:nil] forState:UIControlStateNormal];
        [btn setImage:[UIImage kjwd_getFill_ellipseWithSize:size color:gesBtnColor] forState:UIControlStateSelected];
        [self addSubview:btn];
        [self.buttons addObject:btn];
    }
}

- (void)setGesturesPassword:(NSString *)gesturesPassword{
    for (UIButton *button in self.buttons) {
        button.selected = NO;
    }
    for (int i = 0; i < gesturesPassword.length; i++) {
        NSInteger index = [gesturesPassword substringWithRange:NSMakeRange(i, 1)].integerValue;
        [self.buttons[index] setSelected:YES];
    }
}

- (NSMutableArray *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons ;
}

@end




#define kSD_Opened [CKJGesturesUnlockView  encryptBy_aes:@"opened"]
#define kSD_Closed [CKJGesturesUnlockView  encryptBy_aes:@"closed"]

#define kAccountPrefix(account)  [CKJGesturesUnlockView encryptBy_aes_md5:[NSString stringWithFormat:@"kSDGesturesData_%@", account]]

#define kSDGestures_Password [CKJGesturesUnlockView encryptBy_aes_md5:@"kSDGestures_Password"]          // 密码
#define kSDGestures_RemainingUnLockCount [CKJGesturesUnlockView encryptBy_aes_md5:@"kSDGestures_RemainingUnLockCount"] // 剩余解锁次数
#define kSDGestures_MaxUnLockCount [CKJGesturesUnlockView encryptBy_aes_md5:@"kSDGestures_MaxUnLockCount"] // 最大解锁次数
#define kSDGestures_SwitchStatus [CKJGesturesUnlockView encryptBy_aes_md5:@"kSDGestures_SwitchStatus"]         //UI界面上显示的开关状态

@interface CKJGesturesUnlockView ()

@property (copy, nonatomic) NSString *account;

/** 头像 */
@property (strong, nonatomic) UIImageView *iconImageView;
/** 绘制密码的状态label */
@property (strong, nonatomic) UILabel *statusLabel;
/** 重新绘制按钮 */
@property (strong, nonatomic) UIButton *resetGesturesPasswordButton;
/** 手势密码预览图 */
@property (strong, nonatomic) CKJGesturesSmallPreviewView *smallPreviewView;
/** 手势密码绘制视图 */
@property (strong, nonatomic) CKJGesturesView *gesturesUnlockView;
/** 当前创建的手势密码 */
@property (nonatomic, copy) NSString *curentGesturePassword;
/** 操作结果 回调 */
@property (nonatomic, copy) void (^block)(BOOL result);



#pragma mark - 验证手势 --- 忘记密码 相关

/// 达到失败最大次数回调
@property (copy, nonatomic) CKJOverMaxUnlockCount overMaxUnlockCount;

/// 最大失败次数
@property (strong, nonatomic) NSNumber *maxVerifyFailCount;

/// 你的登录密码
@property (copy, nonatomic) NSString *yourTruePwd;

/// 输入你真实密码成功
@property (copy, nonatomic) CKJInput_yourTruePwd_success input_yourTruePwd_success;



/// 忘记手势按钮
@property (strong, nonatomic, nullable) UIButton *forgetBtn;
/// 增加忘记密码按钮
- (void)addForgetGesturesBtnWithDetail:(void (^)(UIButton *forgetBtn))forgetBtnDetailBlock;

@end

@implementation CKJGesturesUnlockView

static NSString *udid = nil;

+ (nullable instancetype)createGesturePasswordForAccount:(NSString *)account detail:(void(^_Nullable)(CKJGesturesUnlockView *v))detail success:(CKJUnlockSuccess)success {
    if (WDKJ_IsEmpty_Str(account)) {
        return nil;
    }
    CKJGesturesUnlockView *v = [[CKJGesturesUnlockView alloc] init];
    v.statusLabel.text = @"创建手势密码";
    __weak CKJGesturesUnlockView *weakV = v;
    v.type = CKJGesturesUnlockType_Create; //创建密码
    v.account = account;
    v.block = ^(BOOL result) {
        if (result) {  // 创建手势密码成功
            // 应该设置最大解锁次数到沙盒
            if (success) success(weakV);
        }
    };
    if (detail) {
        detail(v);
    }
    
    return v;
}

+ (nullable instancetype)verifyGesturePasswordForAccount:(NSString *)account statusInitText:(NSString *_Nullable)statusInitText detail:(void(^_Nullable)(__weak CKJGesturesUnlockView *v))detail overMaxUnlockCount:(CKJOverMaxUnlockCount)overMaxUnlockCount success:(CKJUnlockSuccess)success {
    if (WDKJ_IsEmpty_Str(account)) {
        return nil;
    }
    NSString *pwd = [CKJGesturesUnlockView _getPasswordSecretByAccount:account];
    if (WDKJ_IsEmpty_Str(pwd)) {
        return nil;
    }
    NSString *count = [CKJGesturesUnlockView getGesturesRemainingUnLockCount:account];
    
    CKJGesturesUnlockView *v = [[CKJGesturesUnlockView alloc] init];
    __weak CKJGesturesUnlockView *weakV = v;
    
    if (WDKJ_IsEmpty_Str(statusInitText)) {
        statusInitText = @"验证手势密码";
    }
    v.statusLabel.text = statusInitText;
    
    if (count.integerValue <= 0) {
        v.statusLabel.text = @"超过最大验证次数";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (overMaxUnlockCount) {
                overMaxUnlockCount(v);
            }
        });
    }
    
    v.type = CKJGesturesUnlockType_Verify;
    v.account = account;
    v.overMaxUnlockCount = overMaxUnlockCount;
    v.block = ^(BOOL result) {
        if (result) { // 解锁成功
            // 应该解锁次数，重置为最大次数
            if (success) success(weakV);
        } else {
        }
    };
    if (detail) {
        detail(v);
    }
    
    return v;
}

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            udid = [[[CKJKeyChain alloc] init] readUDID];
        });
        
        
        self.maxVerifyFailCount = @5;
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *iconImageView = [[UIImageView alloc] init];
        
        NSBundle *resourcesBundle = [CKJWorker kjbundle];
        UIImage *head = [UIImage imageNamed:@"kj_gesture_headIcon.png" inBundle:resourcesBundle compatibleWithTraitCollection:nil];
        head = [head kjwd_scaleToSize:CGSizeMake(50, 50)];
        iconImageView.image = head;
        
        [iconImageView kjwd_masWithSuperView:self makeConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
            make.top.greaterThanOrEqualTo(superview.kjwdMas_safeAreaTop).offset(80);
            make.centerX.equalTo(superview);
        }];
        
        UILabel *statusLabel = [[UILabel alloc] init];
        statusLabel.textColor = [UIColor kjwd_colorWithHexString:@"FF3A00"];
        statusLabel.text = @"请绘制手势密码";
        [statusLabel kjwd_masWithSuperView:self makeConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
            make.centerX.equalTo(iconImageView);
            make.top.equalTo(iconImageView.mas_bottom).offset(30);
        }];
        
        CKJGesturesSmallPreviewView *smallPreviewView = [[CKJGesturesSmallPreviewView alloc] init];
        [smallPreviewView kjwd_masWithSuperView:self makeConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
            make.left.right.top.bottom.equalTo(iconImageView);
        }];
        
        CKJGesturesView *gesturesUnlockView = [[CKJGesturesView alloc] initWithFrame:CGRectZero];
        [gesturesUnlockView kjwd_masWithSuperView:self makeConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
            make.top.equalTo(statusLabel.mas_bottom).offset(30);
            
            make.centerX.equalTo(iconImageView);
            make.width.equalTo(superview).multipliedBy(0.7);
            make.top.equalTo(statusLabel.mas_bottom).offset(30);
            make.centerY.equalTo(superview).priority(700);
            make.height.equalTo(gesturesUnlockView.mas_width);
        }];
        
        UIButton *resetGesturesPasswordButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [resetGesturesPasswordButton setTitle:@"重新绘制" forState:UIControlStateNormal];
        [resetGesturesPasswordButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [resetGesturesPasswordButton addTarget:self action:@selector(resetGesturePassword:) forControlEvents:UIControlEventTouchUpInside];
        [resetGesturesPasswordButton kjwd_masWithSuperView:self makeConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
            make.centerX.equalTo(iconImageView);
            make.bottom.equalTo(superview).offset(-20);
        }];
        
        self.iconImageView = iconImageView;
        self.statusLabel = statusLabel;
        self.smallPreviewView = smallPreviewView;
        self.gesturesUnlockView = gesturesUnlockView;
        self.resetGesturesPasswordButton = resetGesturesPasswordButton;
        
        self.type = CKJGesturesUnlockType_Create;//默认是创建密码
    }
    return self;
}

#pragma mark - private methods
/** 根据不同的类型处理 */
- (void)handleWithType:(CKJGesturesUnlockType)type password:(NSString *)gesturePassword{
    switch (type) {
        case CKJGesturesUnlockType_Create://创建手势密码
            [self createGesturesPassword:gesturePassword];
            break;
        case CKJGesturesUnlockType_Verify://验证手势密码
            [self validateGesturesPassword:gesturePassword];
            break;
    }
}

//创建手势密码
- (void)createGesturesPassword:(NSString *)gesturesPassword {
    if (self.curentGesturePassword.length == 0) {
        if (gesturesPassword.length <4) {
            self.statusLabel.text = @"至少连接四个点，请重新输入";
            [self shakeAnimationForView:self.statusLabel];
            return;
        }
        if (self.resetGesturesPasswordButton.hidden == YES) {
            self.resetGesturesPasswordButton.hidden = NO;
        }
        self.curentGesturePassword = gesturesPassword;
        [self.smallPreviewView setGesturesPassword:gesturesPassword];
        self.statusLabel.text = @"请再次绘制解锁图案";
        return;
    }
    if ([self.curentGesturePassword isEqualToString:gesturesPassword]) {//绘制成功
        //保存手势密码
        [self saveGesturesPassword:gesturesPassword];
        
        if (self.block) self.block(YES);
    } else {
        self.statusLabel.text = @"与上一次绘制不一致，请重新绘制";
        [self shakeAnimationForView:self.statusLabel];
    }
}

//验证手势密码
- (void)validateGesturesPassword:(NSString *)gesturesPassword {
    
    NSString *count = [CKJGesturesUnlockView _getGesturesRemainingUnLockCountByAccount:self.account];
    
    NSInteger errorCount = count.integerValue;
    if ([CKJGesturesUnlockView _verifyPwd:gesturesPassword account:self.account]) {
        [CKJGesturesUnlockView __private__setRemainingUnLockCount:self.maxVerifyFailCount.integerValue forAccount:self.account]; // 重置最大次数
        if (self.block) self.block(YES);
    } else {
       
        --errorCount;
        
        if (errorCount <= 0) {
            [CKJGesturesUnlockView __private__setRemainingUnLockCount:0 forAccount:self.account];
            self.statusLabel.text = @"超过最大验证次数";
            [self shakeAnimationForView:self.statusLabel];
            if (self.overMaxUnlockCount) self.overMaxUnlockCount(self);
        } else {
            [CKJGesturesUnlockView __private__setRemainingUnLockCount:errorCount forAccount:self.account];
            self.statusLabel.text = [NSString stringWithFormat:@"密码错误，还可以再输入%ld次", errorCount];
            [self shakeAnimationForView:self.statusLabel];
        }
    }
}


#pragma mark - getters and setters
/** 设置密码的操作类型 */
- (void)setType:(CKJGesturesUnlockType)type{
    _type = type;
    self.smallPreviewView.hidden = _type != CKJGesturesUnlockType_Create;
    self.iconImageView.hidden = _type == CKJGesturesUnlockType_Create;
    self.resetGesturesPasswordButton.hidden = _type != CKJGesturesUnlockType_Create;
    
    __weak __typeof(self)weakSelf = self;
    [self.gesturesUnlockView setDrawRectFinishedBlock:^(NSString *gesturePassword) {
        [weakSelf handleWithType:type password:gesturePassword];
    }];
}

/** 保存手势密码 */
- (void)saveGesturesPassword:(NSString *)gesturesPassword {
  
    
    NSString *account = self.account;
    NSMutableDictionary *result = [NSMutableDictionary kjwd_dictionaryWithDictionary:[CKJGesturesUnlockView __getGesturesDataByAccount:account]];
    result[kSDGestures_RemainingUnLockCount] = [CKJGesturesUnlockView encryptBy_aes:[NSString stringWithFormat:@"%@", self.maxVerifyFailCount]]; // 剩余解锁次数
    result[kSDGestures_MaxUnLockCount] = [CKJGesturesUnlockView encryptBy_aes:[NSString stringWithFormat:@"%@", self.maxVerifyFailCount]]; // 最大解锁次数
    result[kSDGestures_Password]     = [CKJGesturesUnlockView encryptBy_aes_md5:gesturesPassword];   // 需要加密
    result[kSDGestures_SwitchStatus] = kSD_Opened;
    
    
    
    //    NSLog(@"保存手势数据  %@   %@   ", account,  result);
    
    [[NSUserDefaults standardUserDefaults] setObject:result forKey:kAccountPrefix(account)];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/** 获取手势密码(密文) */
+ (NSString *_Nullable)_getPasswordSecretByAccount:(NSString *)account {
    NSDictionary *dic = [CKJGesturesUnlockView __getGesturesDataByAccount:account];
    NSString *pwd = dic[kSDGestures_Password];
    return pwd;
}

/** 验证密码 */
+ (BOOL)_verifyPwd:(NSString *)pwd account:(NSString *)account {
    NSDictionary *dic = [CKJGesturesUnlockView __getGesturesDataByAccount:account];
    
    NSString *sandBoxPwd = dic[kSDGestures_Password];
    
    BOOL result = [[self encryptBy_aes_md5:pwd] isEqualToString:sandBoxPwd];
    return result;
}

/** 获取剩余解锁次数 */
+ (NSString *)getGesturesRemainingUnLockCount:(NSString *)account {
    NSDictionary *dic = [CKJGesturesUnlockView __getGesturesDataByAccount:account];
    
    NSString *count = dic[kSDGestures_RemainingUnLockCount];
    count = [self decryptBy_aes:count];
    
    return count;
}

/** 获取最大解锁次数 */
+ (NSString *)_getMaxUnLockCount:(NSString *)account {
    NSDictionary *dic = [CKJGesturesUnlockView __getGesturesDataByAccount:account];
    
    NSString *count = dic[kSDGestures_MaxUnLockCount];
    count = [self decryptBy_aes:count];
    
    return count;
}

+ (BOOL)_getGesturesSwitchStatusForAccount:(NSString *)account {
    NSDictionary *dic = [CKJGesturesUnlockView __getGesturesDataByAccount:account];
    
    NSString *switchStatus = dic[kSDGestures_SwitchStatus];
//    switchStatus = [self decryptBy_aes:switchStatus];
    
    if (WDKJ_IsEmpty_Str(switchStatus)) {
        return NO;
    }
    BOOL result = [switchStatus isEqualToString:kSD_Opened];
    return result;
}

+ (BOOL)_moreThanMaxFailCountForAccount:(NSString *)account {
    // 剩余解锁次数
    NSString *remainingUnLockCount = [self getGesturesRemainingUnLockCount:account];
    if (WDKJ_IsEmpty_Str(remainingUnLockCount)) {
        return NO;
    }
    NSInteger shengyuCount = remainingUnLockCount.integerValue;
    if (shengyuCount <= 0) {
        return YES;
    }
    return NO;
}




+ (NSDictionary *)__getGesturesDataByAccount:(NSString *)account {
    if (account == nil) return nil;
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:kAccountPrefix(account)];
//    NSString *pwd = dic[kSDGestures_Password];
//    pwd = [self decrypt1_forText:pwd];
    
    NSString *remainingCount = dic[kSDGestures_RemainingUnLockCount];
    remainingCount = [self decryptBy_aes:remainingCount];
    
    NSString *maxCount = dic[kSDGestures_MaxUnLockCount];
    maxCount = [self decryptBy_aes:maxCount];
    
    NSString *switchStatus = dic[kSDGestures_SwitchStatus];
    switchStatus = [self decryptBy_aes:switchStatus];
    
    WDCKJ_ifDEBUG(^{
        NSLog(@"只在DEBUG状态下打印 手势信息 --- 账户:%@  手势密码:因为是不可逆的加密方式所以不能获取到  最大解锁次数:%@  剩余解锁次数:%@  switchStatus:%@", account, maxCount, remainingCount, switchStatus);
    }, nil);
    
    return dic;
}

/// 设置 剩余解锁次数
+ (void)__private__setRemainingUnLockCount:(NSInteger)count forAccount:(NSString *)account {
    if (account) {
        NSMutableDictionary *data = [NSMutableDictionary kjwd_dictionaryWithDictionary:[self __getGesturesDataByAccount:account]];
        data[kSDGestures_RemainingUnLockCount] =  [self encryptBy_aes:[NSString stringWithFormat:@"%ld", count]];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kAccountPrefix(account)];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [CKJGesturesUnlockView getGesturesRemainingUnLockCount:account];
    }
}

/// 获取手势剩余解锁次数
+ (NSString *_Nullable)_getGesturesRemainingUnLockCountByAccount:(NSString *)account {
    NSMutableDictionary *data = [NSMutableDictionary kjwd_dictionaryWithDictionary:[self __getGesturesDataByAccount:account]];
    NSString *de = data[kSDGestures_RemainingUnLockCount];
    NSString *clearCount = [self decryptBy_aes:de];
    return clearCount;
}


//抖动动画
- (void)shakeAnimationForView:(UIView *)view{
    CALayer *viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    CGPoint left = CGPointMake(position.x - 10, position.y);
    CGPoint right = CGPointMake(position.x + 10, position.y);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:left]];
    [animation setToValue:[NSValue valueWithCGPoint:right]];
    [animation setAutoreverses:YES]; // 平滑结束
    [animation setDuration:0.08];
    [animation setRepeatCount:3];
    [viewLayer addAnimation:animation forKey:nil];
}

//点击重新绘制按钮
- (void)resetGesturePassword:(UIButton *)sender {
    self.curentGesturePassword = nil;
    self.statusLabel.text = @"请绘制手势密码";
    self.resetGesturesPasswordButton.hidden = YES;
    [self.smallPreviewView setGesturesPassword:@""];
}


///// Window已经有了手势视图
//+ (BOOL)windowHaveGesturesUnlockView {
//    UIWindow *window = [UIWindow kjwd_appdelegateWindow];
//    for (UIView *v in window.subviews) {
//        if ([v isKindOfClass:[self class]]) {
//            return YES;
//        }
//    }
//    return NO;
//}

#pragma mark - 动画
- (void)showFromWindowWithAnimation:(BOOL)animation {
    UIView *view = [UIWindow kjwd_appdelegateWindow];

    for (UIView *v in view.subviews) {
        if ([v isKindOfClass:[CKJGesturesUnlockView class]]) {
            [v removeFromSuperview];
        }
    }
    
    [view addSubview:self];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    if (animation) {
        self.frame = CGRectMake(0, size.height, size.width, size.height);
        
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = CGRectMake(0, 0, size.width, size.height);
        }];
    } else {
        self.frame = CGRectMake(0, 0, size.width, size.height);
    }
}

- (void)hideFromWindowWithAnimation:(BOOL)animation {
    CGSize size = [UIScreen mainScreen].bounds.size;
    if (animation) {
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = CGRectMake(0, size.height, size.width, size.height);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    } else {
        [self removeFromSuperview];
    }
}

+ (void)_setSwitchStatus:(BOOL)openStatus forAccount:(NSString *)account {
    if (WDKJ_IsEmpty_Str(account)) {
        return;
    }
    
    NSMutableDictionary *result = [NSMutableDictionary kjwd_dictionaryWithDictionary:[CKJGesturesUnlockView __getGesturesDataByAccount:account]];
    result[kSDGestures_SwitchStatus] = openStatus ? kSD_Opened : kSD_Closed;
    
    [[NSUserDefaults standardUserDefaults] setObject:result forKey:kAccountPrefix(account)];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self _getPasswordSecretByAccount:account];
}

- (void)addInputPwdAlertWithYourTruePwd:(NSString *)yourTruePwd input_yourTruePwd_success:(CKJInput_yourTruePwd_success)input_yourTruePwd_success {
    
    if (self.type != CKJGesturesUnlockType_Verify) return;
    
    if (WDKJ_IsEmpty_Str(yourTruePwd)) {
        return;
    }
    self.yourTruePwd = yourTruePwd;
    self.input_yourTruePwd_success = input_yourTruePwd_success;
}

+ (void)_setRemainingUnLockCountToMaxCountByAccount:(NSString *)account {
    if (WDKJ_IsEmpty_Str(account)) {
        return;
    }
    NSString *maxCount = [CKJGesturesUnlockView _getMaxUnLockCount:account];
    [CKJGesturesUnlockView __private__setRemainingUnLockCount:maxCount.integerValue forAccount:account];
}

- (void)addForgetGesturesBtnWithDetail:(void (^)(UIButton *forgetBtn))forgetBtnDetailBlock {

    if (self.type != CKJGesturesUnlockType_Verify) return;

    UIButton *forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [forgetPwdBtn setTitle:@"忘记手势?" forState:UIControlStateNormal];
    [forgetPwdBtn kjwd_masWithSuperView:self makeConstraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
        make.centerX.equalTo(superview);
        make.bottom.equalTo(superview.kjwdMas_safeAreaBottom).offset(-30);
    }];
    [forgetPwdBtn addTarget:self action:@selector(showInputPwdAlert) forControlEvents:UIControlEventTouchUpInside];
    if (forgetBtnDetailBlock) {
        forgetBtnDetailBlock(forgetPwdBtn);
    }
}

- (void)showInputPwdAlert {
    KJ_typeweakself
    __weak UIViewController *vc = nil;
    if (self.kjwd_currentViewController) {
        vc = self.kjwd_currentViewController;
    } else {
        vc = [UIWindow kjwd_appdelegateWindow].rootViewController;
    }
    
    [UIAlertController kjwd_alertTitle:@"请输入密码" message:nil alertAction_Left:@"取消" leftBlock:^(UIAlertController *__weak  _Nonnull a) {
        
    } right:@"确定" rightBlock:^(UIAlertController *__weak  _Nonnull a) {
        NSString *text = a.textFields.firstObject.text;
        if ([text isEqualToString:weakSelf.yourTruePwd]) {
            if (weakSelf.input_yourTruePwd_success) {
                weakSelf.input_yourTruePwd_success(weakSelf);
            }
        } else {
            [CKJHUD kjwd_showMessageAutoHide:@"密码输入错误"];
            [weakSelf.kjwd_currentViewController presentViewController:a animated:YES completion:nil];
        }
    } detail:^(UIAlertController *__weak  _Nonnull a) {
        [a addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入密码";
        }];
    } presentingVC:vc];
}



+ (NSString *)decryptBy_aes:(NSString *)str {
    NSString *res = [CKJAES AES128Decrypt:str key:udid];
    return res;
}

+ (NSString *)encryptBy_aes:(NSString *)str { // AES
    NSString *res = [CKJAES AES128Encrypt:str key:udid];
    return res;
}

+ (NSString *)encryptBy_aes_md5:(NSString *)str {  // EN
    NSString *res = [[self encryptBy_aes:str] kjwd_md5];
    return res;
}


//+ (NSString *)

//  EN()  代表   MD5( AES() )

//    @{
//        @"EN(手机号)" : @{
//                @"EN(pwd)" : @"EN(123456)",
//                @"EN(剩余解锁次数)" : @"AES(4)",
//                @"EN(最大解锁次数)" : @"AES(5)",
//                @"EN(switchStatus)" :  AES(@"opened"/@"closed")  // 只能通过手动切换Switch切换 UI界面上显示的开关状态
//        }
//    };




@end





