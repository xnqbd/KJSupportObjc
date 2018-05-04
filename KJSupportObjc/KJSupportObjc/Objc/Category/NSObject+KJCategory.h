//
//  NSObject+KJCategory.h
//  KJProduct
//
//  Created by uback on 2018/3/19.
//  Copyright © 2018年 uback. All rights reserved.
//

#import <UIKit/UIKit.h>


int getRandomNumber(int from, int to);


#import <Foundation/Foundation.h>

@interface NSObject (KJCategory)

/*
 让一段代码在一段时间内只能执行一次， 这个方法就算很频繁执行， 但在指定时间内block中的代码也只会执行一次
 */
- (void)executedOnceInTimeInterval:(NSTimeInterval)timeInterval block:(void(^)(void))block;

@end

#pragma mark - -----------------NSData-----------------
@interface NSData (KJCategory)

- (NSString *)utf8String;

@end


#pragma mark - -----------------NSTimer-----------------
@interface NSTimer (Category)
+ (NSTimer *)kj_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)(void))block
                                       repeats:(BOOL)repeats nowPerform:(BOOL)boo;
@end


#pragma mark - -----------------NSArray-----------------
@interface NSArray (KJCategory)

- (id)kj_objectAtIndex:(NSUInteger)index;

- (NSString *)arrayString;

@end

#pragma mark - -----------------NSMutableArray-----------------
// 关于NSMutableArray线程安全的思考和实现 http://blog.csdn.net/kongdeqin/article/details/53171189
@interface NSMutableArray (KJCategory)

- (BOOL)kj_addObject:(id)object;

- (BOOL)kj_addObjectsFromArray:(NSArray *)array;

- (BOOL)kj_insertObject:(id)object atIndex:(NSUInteger)index;

- (BOOL)kj_removeObjectAtIndex:(NSUInteger)index;

/**
 *  当向数组里的第一个位置插入数据时， 建议用这个
 */
- (BOOL)kj_insertAt_FirstIndex_Of_Object:(id)object;

- (BOOL)kj_replaceObjectAtIndex:(NSUInteger)index withObject:(id)object;

@end

#pragma mark - -----------------NSDictionary-----------------
@interface NSDictionary (KJCategory)

/**
 *  转成JSON格式的字符串
 */
- (NSString *)kj_returnJsonString;
/**
 *  转成字符串（不是JSON格式）
 */
- (NSString *)kj_returnString;

@end

#pragma mark - -----------------UIAlertController-----------------
@interface UIAlertController (KJCategory)

+ (instancetype)kj_alertTitle:(NSString *)alertTitle message:(NSString *)message alertAction_Left:(NSString *)leftActionTitle leftBlock:(void(^)(void))leftBlock right:(NSString *)rightActionTitle rightBlock:(void(^)(void))rightBlock presentingVC:(UIViewController *)presentingVC;

+ (instancetype)kj_alertTitle:(NSString *)alertTitle message:(NSString *)message actionSheet_top:(NSString *)topSheetTitle topBlock:(void(^)(void))topBlock centerSheet:(NSString *)centerSheetTitle centerBlock:(void(^)(void))centerBlock buttomSheet:(NSString *)buttomSheetTitle buttomBlock:(void(^)(void))buttomBlock presentingVC:(UIViewController *)presentingVC;

@end

#pragma mark - -----------------UITabBar-----------------
@interface UITabBar (KJCategory)

- (void)kj_setTopImage:(UIImage *)image;

@end

#pragma mark - -----------------UIColor-----------------
@interface UIColor (KJCategory)

+ (UIColor *)arc4Color;

+ (UIColor *)r:(NSInteger)r g:(NSInteger)g b:(NSInteger)b alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)color;

@end


@interface NSURL (KJ_Category)

/**
 *  解决 有中文 会导致转换失败的问题
 */
+ (NSURL *)kj_URLWithString:(NSString *)urlString;

@end

#pragma mark - -----------------UIViewController-----------------
@interface UIViewController (KJCategory)

/** 得到当前控制器 被 哪一个控制器 推过来的 控制器 */
- (UIViewController *)previous_PushedVC;

/** 从MainStoryBoard加载同名的控制器 */
+ (instancetype)instanceInMain;

/** 从MainStoryBoard加载 标示 的控制器 */
+ (instancetype)instanceInMainWithIdentifier:(NSString *)identifier;

/**
 *  pop到指定控制器
 *  如果当前导航控制器包含所想要pop到的控制器，那么直接pop，
 *  如果当前导航控制器不包含所想要pop到的控制器，那么先pop到RootViewController，再用当前控制器push想要指定的控制器
 *  @param vcClass 类名 (例如[ViewController class])
 */
- (void)popToSpecifyVC:(Class)vcClass;
/**
 *  通过动画切换根视图控制器
 */
- (void)settoRootVCWithAnimation:(BOOL)animation;


@end



#pragma mark - -----------------UINavigationController-----------------
@interface UINavigationController (KJCategory)

- (UIViewController *)kj_rootViewController;

/**
 *  将navigationBar设置为透明
 */
- (void)kj_setClearNavigationBar;

/**
 *  设置标题颜色字体等等
 */
- (void)kj_setTitleColorFontDic:(NSDictionary *)dic;
/**
 *  设置左右item颜色
 */
- (void)kj_setLeftRightBarButtonItemColor:(UIColor *)color;

@end

#pragma mark - -----------------UIBarButtonItem-----------------
@interface UIBarButtonItem (KJCategory)

+ (UIBarButtonItem *)kj_itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;


+ (UIBarButtonItem *)kj_itemWithTarget:(id)target action:(SEL)action bgImage:(NSString *)bgImage text:(NSString *)text;




@end






























#pragma mark - -----------------UIView-----------------
@interface UIView (KJCategory)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;


/**
 *  返回当前View和另外一个View中心点连线的中间point
 */
- (CGPoint)centerPointToOtherView:(UIView *)otherView;


/**
 * 便利构造器
 * 说明 创建并使用XIB文件初始视图控制器, 默认使用与控制器相同名字的XIB文件
 * 参数 nibName, XIB文件名
 */
+ (instancetype)instanceUsingAutoNib;
+ (instancetype)instanceWithNibName:(NSString *)nibName;

/**
 * 视图转化成图片
 */
- (UIImage *)shotImage;



#pragma mark - 下面三个不建议使用
/** 为View增加手势 */
- (UITapGestureRecognizer *)kj_touchesBeganBlock:(void(^)(void))touchesBeganBlock touchesBeganRemoveFromSuperview:(BOOL)boo;

/** 从底部向上钻， 类似UIActionSheet的效果 */
- (void)animateFromScreenButtomWithDuration:(NSTimeInterval)duration completion:(void(^)(BOOL finished))completion coverViewColor:(UIColor *_Nullable)coverViewColor;

/** 这个和上面的向上钻的效果是配合使用 */
- (void)tapBackGroundView;


#pragma mark - 手势相关

// 平移
@property (assign, nonatomic) BOOL enablePanEdgeInset;
@property (assign, nonatomic) UIEdgeInsets panGestureRecognizer_EdgeInset;
/** 发生平移事件之后，处理平移事件 */
- (void)disposePanGestureRecognizer:(UIPanGestureRecognizer *)pan;
- (void)addPanGestureRecognizerWithTarget:(id)target selector:(SEL)selector enableEdgeInset:(BOOL)enableEdgeInset edgeInset:(UIEdgeInsets)edgeInset;



@end



#pragma mark - -----------------NSDate-----------------
@interface NSDate (KJCategory)
+ (NSDate *)returnDate:(NSString *)dateString withDateFormat:(NSString *)format;
+ (NSString *)currentDateString; //  yyyy-MM-dd HH:mm:ss
+ (NSString *)currentYear;        // 2016
+ (NSString *)currentMonth;       // 03
+ (NSString *)currentDay;         // 04
+ (NSString *)currentHour;        // 16
+ (NSString *)currentMinute;      // 15
+ (NSString *)currentSecond;      // 50

- (NSString *)dateString;
- (NSString *)dateYear;
- (NSString *)dateMonth;
- (NSString *)dateDay;
- (NSString *)dateHour;
- (NSString *)dateMinute;
- (NSString *)dateSecond;
/**
 *  通过 格式 返回当前时间
 */
+ (NSString *)currentDateStringWithFormatter:(NSString *)formatterStr;
+ (NSString *)dateStringFrom1970second:(double)second withFormatter:(NSString *)formatterStr;
+ (NSString *)dateStringFrom1970second:(double)second;
- (NSString *)dateStringWithFormatter:(NSString *)formatterStr;

/**
 *  20160621111325124 精确到毫秒
 */
+ (NSString *)currentDateUnsigned_Milliseconds;

/**
 *  判断是否是同一天
 */
- (BOOL)isSameDayToDate2:(NSDate *)date2;

/**
 *  明天
 */
+ (NSDate *)tomorrowDate;
/**
 *  昨天
 */
+ (NSDate *)yesterdayDate;

/**
 * 返回 1小时前 这样的字符 (传入2017-12-21 20:53:00.0  这样的字符串)
 */
+ (NSString *)returnWordsForTime:(NSString *)str;


@end


#pragma mark - -----------------UIImage-----------------

@interface UIImage (KJCategory)

/**
 * 加载图片过滤空字符串
 */
+ (nullable UIImage *)kj_imageNamed:(nonnull NSString *)name;

+ (UIImage *)imageWithColor:(UIColor *)color imageWidth:(CGFloat)width imageHeight:(CGFloat)height;

- (instancetype)lx_circleImage;
// 生成一个圆形图片
+ (instancetype)lx_circleImageNamed:(NSString *)name;

// 给定一个不要渲染的图片名称,生成一个最原始的图片
+ (UIImage *)imageWithOriginalImageName:(NSString *)imageName;

//// 模糊效果(渲染很耗时间,建议在子线程中渲染)
//- (UIImage *)blurImage;
//- (UIImage *)blurImageWithMask:(UIImage *)maskImage;
//- (UIImage *)blurImageWithRadius:(CGFloat)radius;
//- (UIImage *)blurImageAtFrame:(CGRect)frame;

// 灰度效果
- (UIImage *)grayScale;

// 固定宽度与固定高度
- (UIImage *)scaleWithFixedWidth:(CGFloat)width;
- (UIImage *)scaleWithFixedHeight:(CGFloat)height;

// 平均的颜色
- (UIColor *)averageColor;

// 裁剪图片的一部分
- (UIImage *)croppedImageAtFrame:(CGRect)frame;

// 将自身填充到指定的size
- (UIImage *)fillClipSize:(CGSize)size;

// 对图片进行滤镜处理
- (UIImage *)filterImageWithfilterName:(NSString *)name;


// 对图片进行模糊处理(毛玻璃效果)
- (UIImage *)blurImageWithBlurName:(NSString *)name
                            radius:(NSInteger)radius;



// 创建一张实时模糊效果 View (毛玻璃效果)
//Avilable in iOS 8.0 and later
+ (UIVisualEffectView *)effectViewWithFrame:(CGRect)frame;


// 通过给定颜色和大小生成图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
// 文字转成图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size title:(NSString *)title titleColor:(UIColor *)titleColor;
// 从View中生成图片
+ (UIImage *)shotImage:(UIView *)view;
// 屏幕截图
+ (UIImage *)shotImage;
@end

#pragma mark - -----------------NSString-----------------

@interface NSString (KJCategory)

/*
 self.lab.attributedText = [self.lab.text changeToAttributedStringWithString:self.lab.text color:[UIColor greenColor] attributedSize:30 fromIndex:3 toIndex:4];
 */

- (NSAttributedString *)changeToAttributedStringWithString:(NSString *)string color:(UIColor *)color attributedSize:(CGFloat)attributedSize fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

/*
 NSString *str = @"kasdcA属性dcdwqd";
 self.lab.attributedText = [self.lab.text changeToAttributedStringWithString:str specialChar:@"s" color:[UIColor redColor] attributedSize:30 toIndex:str.length - 1];
 */
- (NSAttributedString *)changeToAttributedStringWithString:(NSString *)string specialChar:(NSString *)specialChar color:(UIColor *)color attributedSize:(CGFloat)attributedSize toIndex:(NSInteger)toIndex;





// 邮箱
- (BOOL)validateEmail;

// 手机号码验证
- (BOOL)validateMobile;

// 车牌号验证
- (BOOL)validateCarNo;

// 车型
- (BOOL)validateCarType;

// 用户名
- (BOOL)validateUserName;

/**
 * 密码
 * 说明 密码验证数字与字母组合, 默认6-12位
 * 参数 min, 最少位
 * 参数 max, 最大位
 */
- (BOOL)validatePassword;
- (BOOL)validatePasswordWithMin:(unsigned int)min max:(unsigned int)max;

/**
 * 昵称
 * 说明 以中文开头, 默认4-8位
 * 参数 min, 最少位
 * 参数 max, 最大位
 */
- (BOOL)validateNickname;
- (BOOL)validateNicknameWithMin:(unsigned int)min max:(unsigned int)max;

// 身份证号
- (BOOL) validateIdentityCard;

/**
 * 验证码
 * 说明 纯数字验证码, 默认5位
 * 参数 size, 位数
 */
- (BOOL)validateVerifyCode;
- (BOOL)validateVerifyCodeWithSize:(unsigned int)size;


/** 是否全是大写或数字 */
- (BOOL)inputShouldUpperAndNumber;

/** 是否全是字母或数字 */
- (BOOL)isCharAndNumber;

/**
 * MD5加密
 * 说明 MD5是消息摘要算法
 * 返回 16位字符串类型的 MD5 hash值
 */
- (NSString *)MD5;

// 过滤首尾的空格和换行
- (NSString *)trimWhiteAndNewline;
// 过滤首尾的空格
- (NSString *)trimWhite;
// 过滤所有的空格和换行
- (NSString *)trimAllWhiteAndNewline;
// 过滤所有的空格
- (NSString *)trimAllWhite;

+ (NSString *)uuidString;







typedef NS_ENUM(NSInteger, Arc4randomType) {
    /**
     *  0-9
     */
    Arc4randomType_Number,
    /**
     *  0-9 和 a-z A-Z
     */
    Arc4randomType_Number_Up_Low_Char,
    
    /**
     *  A_Z
     */
    Arc4randomType_Up_Char,
    
    /**
     *  a-z
     */
    Arc4randomType_Low_Char,
    
    /**
     *  0-9 和 a-z
     */
    Arc4randomType_Number_Low_Char,
    /**
     *  0-9 和 A-Z
     */
    Arc4randomType_Number_Up_Char
};


/**
 *  这个在时间很短时， 得到多个随机数， 可能得到的随机数是相同的
 */
+ (NSString *)returnGetArc4randomWithNum:(NSUInteger)num type:(Arc4randomType)type;

+ (NSString *)returnArc4randomWithNum:(NSUInteger)num type:(Arc4randomType)type;


+ (NSString *)arrayStringWithStringArray:(NSArray *)array;

#pragma mark - 字符串操作
- (NSString *)kj_substringFromIndex:(NSUInteger)from;
- (NSString *)kj_substringToIndex:(NSUInteger)to;
- (NSString *)kj_substringWithRange:(NSRange)range;
- (NSString *)kj_stringByAppendingString:(NSString *)aString;

@end


#pragma mark - -----------------CALayer-----------------
@interface CALayer (KJCategory)

/**
 *  暂停 layer 层的动画
 */
- (void)pauseAnimation;
/**
 *  继续 layer 层的动画
 */
- (void)goonAnimation;

@end

