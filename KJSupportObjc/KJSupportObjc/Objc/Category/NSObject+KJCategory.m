//
//  NSObject+KJCategory.m
//  KJProduct
//
//  Created by uback on 2018/3/19.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "NSObject+KJCategory.h"

#import <CommonCrypto/CommonDigest.h>
#import <objc/message.h>


int getRandomNumber(int from, int to) {
    int temp = to - from + 1;
    int num = (arc4random() % temp);
    return from + num;
}


@implementation NSObject (KJCategory)


/*
 让一段代码在一段时间内只能执行一次， 这个方法就算很频繁执行， 但在指定时间内block中的代码也只会执行一次
 */
- (void)executedOnceInTimeInterval:(NSTimeInterval)timeInterval block:(void(^)(void))block {
    NSLog(@"进来比较");
    NSDate *currentDate = [NSDate date];
    NSTimeInterval interval = [currentDate timeIntervalSinceDate:self.markDate];
    
    if (interval < timeInterval) {
        return;
    }
    
    self.markDate = [NSDate date];
    
    if (block) {
        block();
    }
}

- (void)setMarkDate:(NSDate *)markDate {
    if (markDate == nil) {
        return;
    }
    objc_setAssociatedObject(self, @"markDate", markDate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDate *)markDate {
    NSDate *date = objc_getAssociatedObject(self, @"markDate");
    return date;
}


@end

#pragma mark - -----------------NSData-----------------
@implementation NSData (KJCategory)

- (NSString *)utf8String {
    NSString *string = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    if (string == nil) {
        string = [[NSString alloc] initWithData:[self UTF8Data] encoding:NSUTF8StringEncoding];
    }
    return string;
}

//              https://zh.wikipedia.org/wiki/UTF-8
//              https://www.w3.org/International/questions/qa-forms-utf-8
//
//            $field =~
//                    m/\A(
//            [\x09\x0A\x0D\x20-\x7E]            # ASCII
//            | [\xC2-\xDF][\x80-\xBF]             # non-overlong 2-byte
//            |  \xE0[\xA0-\xBF][\x80-\xBF]        # excluding overlongs
//            | [\xE1-\xEC\xEE\xEF][\x80-\xBF]{2}  # straight 3-byte
//            |  \xED[\x80-\x9F][\x80-\xBF]        # excluding surrogates
//            |  \xF0[\x90-\xBF][\x80-\xBF]{2}     # planes 1-3
//            | [\xF1-\xF3][\x80-\xBF]{3}          # planes 4-15
//            |  \xF4[\x80-\x8F][\x80-\xBF]{2}     # plane 16
//            )*\z/x;

- (NSData *)UTF8Data {
    //保存结果
    NSMutableData *resData = [[NSMutableData alloc] initWithCapacity:self.length];
    
    NSData *replacement = [@"�" dataUsingEncoding:NSUTF8StringEncoding];
    
    uint64_t index = 0;
    const uint8_t *bytes = self.bytes;
    
    long dataLength = (long) self.length;
    
    while (index < dataLength) {
        uint8_t len = 0;
        uint8_t firstChar = bytes[index];
        
        // 1个字节
        if ((firstChar & 0x80) == 0 && (firstChar == 0x09 || firstChar == 0x0A || firstChar == 0x0D || (0x20 <= firstChar && firstChar <= 0x7E))) {
            len = 1;
        }
        // 2字节
        else if ((firstChar & 0xE0) == 0xC0 && (0xC2 <= firstChar && firstChar <= 0xDF)) {
            if (index + 1 < dataLength) {
                uint8_t secondChar = bytes[index + 1];
                if (0x80 <= secondChar && secondChar <= 0xBF) {
                    len = 2;
                }
            }
        }
        // 3字节
        else if ((firstChar & 0xF0) == 0xE0) {
            if (index + 2 < dataLength) {
                uint8_t secondChar = bytes[index + 1];
                uint8_t thirdChar = bytes[index + 2];
                
                if (firstChar == 0xE0 && (0xA0 <= secondChar && secondChar <= 0xBF) && (0x80 <= thirdChar && thirdChar <= 0xBF)) {
                    len = 3;
                } else if (((0xE1 <= firstChar && firstChar <= 0xEC) || firstChar == 0xEE || firstChar == 0xEF) && (0x80 <= secondChar && secondChar <= 0xBF) && (0x80 <= thirdChar && thirdChar <= 0xBF)) {
                    len = 3;
                } else if (firstChar == 0xED && (0x80 <= secondChar && secondChar <= 0x9F) && (0x80 <= thirdChar && thirdChar <= 0xBF)) {
                    len = 3;
                }
            }
        }
        // 4字节
        else if ((firstChar & 0xF8) == 0xF0) {
            if (index + 3 < dataLength) {
                uint8_t secondChar = bytes[index + 1];
                uint8_t thirdChar = bytes[index + 2];
                uint8_t fourthChar = bytes[index + 3];
                
                if (firstChar == 0xF0) {
                    if ((0x90 <= secondChar & secondChar <= 0xBF) && (0x80 <= thirdChar && thirdChar <= 0xBF) && (0x80 <= fourthChar && fourthChar <= 0xBF)) {
                        len = 4;
                    }
                } else if ((0xF1 <= firstChar && firstChar <= 0xF3)) {
                    if ((0x80 <= secondChar && secondChar <= 0xBF) && (0x80 <= thirdChar && thirdChar <= 0xBF) && (0x80 <= fourthChar && fourthChar <= 0xBF)) {
                        len = 4;
                    }
                } else if (firstChar == 0xF3) {
                    if ((0x80 <= secondChar && secondChar <= 0x8F) && (0x80 <= thirdChar && thirdChar <= 0xBF) && (0x80 <= fourthChar && fourthChar <= 0xBF)) {
                        len = 4;
                    }
                }
            }
        }
        // 5个字节
        else if ((firstChar & 0xFC) == 0xF8) {
            len = 0;
        }
        // 6个字节
        else if ((firstChar & 0xFE) == 0xFC) {
            len = 0;
        }
        
        if (len == 0) {
            index++;
            [resData appendData:replacement];
        } else {
            [resData appendBytes:bytes + index length:len];
            index += len;
        }
    }
    
    return resData;
}

@end


#pragma mark - -----------------NSTimer-----------------
@implementation NSTimer (Category)
+ (NSTimer *)kj_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)(void))block
                                       repeats:(BOOL)repeats nowPerform:(BOOL)boo {
    if (boo) {
        if (block) {
            block();
        }
    }
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(kj_blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}
+ (void)kj_blockInvoke:(NSTimer *)timer {
    void (^block)(void) = timer.userInfo;
    if(block) {
        block();
    }
}

@end
#pragma mark - -----------------NSArray-----------------
@implementation NSArray (KJCategory)

- (id)kj_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        NSLog(@"位置 %ld 越界, 当前数组个数是 %ld", index, self.count);
        return nil;
    } else {
        id value = [self objectAtIndex:index];
        if (value == [NSNull null]) {
            NSLog(@"第%ld元素为NULL  个数是 %ld  数组是%@ ", index, self.count, self);
            return nil;
        }
        return [self objectAtIndex:index];
    }
}
- (NSArray *)kj_reverseArray {
    NSArray *array = [[self reverseObjectEnumerator] allObjects];
    return array;
}

- (NSString *)arrayString {
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < self.count; i++) {
        NSString *str = self[i];
        if (i != 0) {
            [string appendString:[NSString stringWithFormat:@", %@", str]];
        } else {
            [string appendString:[NSString stringWithFormat:@"%@", str]];
        }
    }
    return string;
}

@end

#pragma mark - -----------------NSMutableArray-----------------
@implementation NSMutableArray (KJCategory)

- (BOOL)kj_addObject:(id)object {
    if (object == nil || [object isKindOfClass:[NSNull class]]) {
        NSLog(@"kj_addObject 对象不能被加入 因为对象为空");
        return NO;
    } else {
        [self addObject:object];
        return YES;
    }
}
- (BOOL)kj_addObjectsFromArray:(NSArray *)array {
    if (array == nil || [array isKindOfClass:[NSNull class]]) {
        NSLog(@"kj_addObjectsFromArray 数组不能被加入 因为对象为空");
        return NO;
    } else {
        [self addObjectsFromArray:array];
        return YES;
    }
}
- (BOOL)kj_insertObject:(id)object atIndex:(NSUInteger)index {
    if (object == nil || [object isKindOfClass:[NSNull class]]) {
        NSLog(@"kj_insertObject 对象不能被插入 因为对象为空");
        return NO;
    }
    if (index >= self.count) {
        NSLog(@"kj_insertObject 位置 %ld 越界, 当前数组个数是 %ld", index, self.count);
        return NO;
    } else {
        [self insertObject:object atIndex:index];
        return YES;
    }
}
- (BOOL)kj_removeObjectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        NSLog(@"kj_removeObjectAtIndex 位置 %ld 越界, 当前数组个数是 %ld", index, self.count);
        return NO;
    } else {
        [self removeObjectAtIndex:index];
        return YES;
    }
}
- (BOOL)kj_insertAt_FirstIndex_Of_Object:(id)object {
    if (object == nil || [object isKindOfClass:[NSNull class]]) {
        NSLog(@"kj_insertAt_FirstIndex_Of_Object 此对象不能被插入到firstIndex位置 因为对象为空");
        return NO;
    }
    if (self.count == 0) {
        [self addObject:object];
        return YES;
    } else {
        [self insertObject:object atIndex:0];
        return YES;
    }
}
- (BOOL)kj_replaceObjectAtIndex:(NSUInteger)index withObject:(id)object {
    if (index >= self.count) {
        NSLog(@"kj_replaceObjectAtIndex 替换失败 位置 %ld 越界, 当前数组个数是 %ld", index, self.count);
        return NO;
    }
    if (object == nil || [object isKindOfClass:[NSNull class]]) {
        NSLog(@"kj_replaceObjectAtIndex 替换失败 此对象不能被插入到 %lu 位置 因为对象为空", index);
        return NO;
    }
    [self replaceObjectAtIndex:index withObject:object];
    return YES;
}


@end


#pragma mark - -----------------NSDictionary-----------------
@implementation NSDictionary (KJCategory)

- (NSString *)kj_returnJsonString {
    NSString *jsonString = nil;
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (!jsonData) {
        NSLog(@"字典传JSON字符串失败 %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
- (NSString *)kj_returnString {
    NSMutableString *returnValue = [[NSMutableString alloc]initWithCapacity:0];
    
    NSArray *paramsAllKeys = [self allKeys];
    
    for(int i = 0;i < paramsAllKeys.count;i++) {
        
        /*
         
         在此进行处理
         
         */
        NSString *str = [self objectForKey:[paramsAllKeys objectAtIndex:i]];
        
        // //特殊字符处理
        NSString *temp = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)str, NULL, (__bridge CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
        
        [returnValue appendFormat:@"%@=%@",[paramsAllKeys objectAtIndex:i], temp];
        
        if(i < paramsAllKeys.count - 1) {
            [returnValue appendString:@"&"];
        }
    }
    return returnValue;
}
- (NSArray <NSArray *>*)kj_returnKeysArrayValuesArray {
    
    NSMutableArray *result = [NSMutableArray array];
    NSMutableArray *keyArr = [NSMutableArray array];
    NSMutableArray *valueArr = [NSMutableArray array];
    for (id objc in self.allKeys) {
        [keyArr kj_addObject:objc];
        [valueArr kj_addObject:self[objc]];
    }
    [result kj_addObject:keyArr];
    [result kj_addObject:valueArr];
    return result;
}



@end


#pragma mark - -----------------UIAlertController-----------------

@implementation UIAlertController (KJCategory)


+ (instancetype)kj_alertTitle:(NSString *)alertTitle message:(NSString *)message alertAction_Left:(NSString *)leftActionTitle leftBlock:(void(^)(void))leftBlock right:(NSString *)rightActionTitle rightBlock:(void(^)(void))rightBlock presentingVC:(UIViewController *)presentingVC {
    
    UIAlertController *alert = [self alertControllerWithTitle:alertTitle message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (leftActionTitle) {
        UIAlertAction *left = [UIAlertAction actionWithTitle:leftActionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (leftBlock) {
                leftBlock();
            }
        }];
        [alert addAction:left];
    }
    if (rightActionTitle) {
        UIAlertAction *right = [UIAlertAction actionWithTitle:rightActionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (rightBlock) {
                rightBlock();
            }
        }];
        [alert addAction:right];
    }
    if (presentingVC == nil) {
        presentingVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    [presentingVC presentViewController:alert animated:YES completion:nil];
    return alert;
}

+ (instancetype)kj_alertTitle:(NSString *)alertTitle message:(NSString *)message actionSheet_top:(NSString *)topSheetTitle topBlock:(void(^)(void))topBlock centerSheet:(NSString *)centerSheetTitle centerBlock:(void(^)(void))centerBlock buttomSheet:(NSString *)buttomSheetTitle buttomBlock:(void(^)(void))buttomBlock presentingVC:(UIViewController *)presentingVC {
    
    UIAlertController *alert = [self alertControllerWithTitle:alertTitle message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    if (topSheetTitle) {
        UIAlertAction *top = [UIAlertAction actionWithTitle:topSheetTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (topBlock) {
                topBlock();
            }
        }];
        [alert addAction:top];
    }
    if (centerSheetTitle) {
        UIAlertAction *center = [UIAlertAction actionWithTitle:centerSheetTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (centerBlock) {
                centerBlock();
            }
        }];
        [alert addAction:center];
    }
    if (buttomSheetTitle) {
        UIAlertAction *buttom = [UIAlertAction actionWithTitle:buttomSheetTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (buttomBlock) {
                buttomBlock();
            }
        }];
        [alert addAction:buttom];
    }
    if (presentingVC == nil) {
        presentingVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    [presentingVC presentViewController:alert animated:YES completion:nil];
    return alert;
}






@end

#pragma mark - -----------------UITabBar-----------------

@implementation UITabBar (KJCategory)

- (void)kj_setTopImage:(UIImage *)image {
    [self setShadowImage:image];
    [self setBackgroundImage:[[UIImage alloc]init]];
}

@end


#pragma mark - -----------------UIColor-----------------
@implementation UIColor (KJCategory)

+ (UIColor *)arc4Color {
    return [UIColor r:arc4random_uniform(256) g:arc4random_uniform(256) b:arc4random_uniform(256) alpha:1];
}
+ (UIColor *)r:(NSInteger)r g:(NSInteger)g b:(NSInteger)b alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:alpha];
}
+ (UIColor *)colorWithHexString:(NSString *)color {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
@end



@implementation NSURL (KJ_Category)

+ (NSURL *)kj_URLWithString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    if (url) {
        return url;
    }
    
    NSCharacterSet *encode_set= [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *urlString_encode = [urlString stringByAddingPercentEncodingWithAllowedCharacters:encode_set];
    url = [NSURL URLWithString:urlString_encode];
    return url;
}

@end

#pragma mark - -----------------UIViewController-----------------
@implementation UIViewController (KJCategory)
/** 得到当前控制器 被 哪一个控制器 推过来的 控制器 */
- (UIViewController *)previous_PushedVC {
    UINavigationController *navc = self.navigationController;
    if (navc.viewControllers.count == 1) return nil;
    UIViewController *vc = [navc.viewControllers objectAtIndex:navc.viewControllers.count - 2];
    return vc;
}

/** 从MainStoryBoard加载同名的控制器 */
+ (instancetype)instanceInMain {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
}

/** 从MainStoryBoard加载 标示 的控制器 */
+ (instancetype)instanceInMainWithIdentifier:(NSString *)identifier {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}

/**
 *  pop到指定控制器
 *  如果当前导航控制器包含所想要pop到的控制器，会调用currentStackBlock
 *  如果当前导航控制器不包含所想要pop到的控制器，那么先pop到RootViewController，再用当前控制器push想要指定的控制器，newAllocVC要传入创建好的控制启
 *  @param vcClass 类名 (例如[ViewController class])
 */
- (void)popToSpecifyVC:(Class)vcClass currentStackBlock:(void(^)(__kindof UIViewController *vc))currentStackBlock newAllocVC:(__kindof UIViewController *)newVc {
    BOOL boo = NO;
    
    UINavigationController *navc = self.navigationController;
    
    NSArray *stackArray = navc.viewControllers;
    NSArray *array = [stackArray kj_reverseArray];
    
    for (UIViewController *vc in array) {
        if ([vc isKindOfClass:vcClass]) {
            if (currentStackBlock) {
                currentStackBlock(vc);
            }
            [navc popToViewController:vc animated:YES];
            return;
        }
    }
    if (boo == NO) {
        if (newVc == nil) {
            NSLog(@"想要pop push到新控制器，newVc不能为nil");
            return;
        }
        [navc popToRootViewControllerAnimated:NO];
        [navc pushViewController:newVc animated:YES];
    }
}
- (void)settoRootVCWithAnimation:(BOOL)animation {

    id appdelegate = [UIApplication sharedApplication].delegate;
    
    id (*kj_sengMsg)(id, SEL) = (id (*)(id, SEL))objc_msgSend;

    UIWindow *window = kj_sengMsg(appdelegate, sel_registerName("window"));
    
    if (animation == NO) {
        window.rootViewController = self;
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        void (^animation)(void)  = ^{
            BOOL oldState = [UIView areAnimationsEnabled];
            [UIView setAnimationsEnabled:NO];
            window.rootViewController = self;
            [UIView setAnimationsEnabled:oldState];
        };
        
        [UIView transitionWithView:window
                          duration:0.5f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:animation
                        completion:nil];
    });
}


@end

#pragma mark - -----------------UINavigationController-----------------




@implementation UINavigationController (KJCategory)

- (UIViewController *)kj_rootViewController {
    NSArray *vcArray = self.viewControllers;
    NSUInteger count = vcArray.count;
    if (count == 0) return nil;
    return [vcArray kj_objectAtIndex:0];
}
- (void)kj_setClearNavigationBar {
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
}
- (void)kj_setTitleColorFontDic:(NSDictionary *)dic {
    self.navigationBar.titleTextAttributes= dic;
}

- (void)kj_setLeftRightBarButtonItemColor:(UIColor *)color {
    self.navigationBar.tintColor = color;
}

@end

#pragma mark - -----------------UIBarButtonItem-----------------

@implementation UIBarButtonItem (KJCategory)


+ (UIBarButtonItem *)kj_itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    if (image) {
        [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if (highImage) {
        [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    }
    // 设置尺寸
    //btn.size = btn.currentBackgroundImage.size;
    
    CGRect rect = btn.frame;
    rect.size = btn.currentBackgroundImage.size;
    btn.frame = rect;
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


+ (UIBarButtonItem *)kj_itemWithTarget:(id)target action:(SEL)action bgImage:(NSString *)bgImage text:(NSString *)text {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    if (bgImage) {
        [btn setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    }
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    // 设置尺寸
    //btn.size = btn.currentBackgroundImage.size;
    
    CGRect rect = btn.frame;
    rect.size = btn.currentBackgroundImage.size;
    btn.frame = rect;
    if (bgImage == nil || btn.currentBackgroundImage == nil) {
        [btn sizeToFit];
    }
    
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


@end




@implementation UITableView (KJCategory)

- (void)kj_reloadData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}

@end


@implementation UICollectionView (KJCategory)

- (void)kj_reloadData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}

@end




#pragma mark - -----------------UIView-----------------

@interface UIView (Property)

@property (nonatomic, copy) void (^touchesBeganBlock)(void);
@property (assign, nonatomic) BOOL touchesBeganRemoveFromSuperview;



@end


@implementation UIView (KJCategory)

- (id)kj_safeArea {
    if (@available(iOS 11.0, *)) {
        return self.safeAreaLayoutGuide;
    } else {
        return self;
    }
}
- (MASViewAttribute *)kjMas_safeAreaTop {
    if (@available(iOS 11.0, *)) {
        return self.mas_safeAreaLayoutGuideTop;
    } else {
        return self.mas_top;
    }
}
- (MASViewAttribute *)kjMas_safeAreaBottom {
    if (@available(iOS 11.0, *)) {
        return self.mas_safeAreaLayoutGuideBottom;
    } else {
        return self.mas_bottom;
    }
}
- (MASViewAttribute *)kjMas_safeAreaLeft {
    if (@available(iOS 11.0, *)) {
        return self.mas_safeAreaLayoutGuideLeft;
    } else {
        return self.mas_left;
    }
}
- (MASViewAttribute *)kjMas_safeAreaRight {
    if (@available(iOS 11.0, *)) {
        return self.mas_safeAreaLayoutGuideRight;
    } else {
        return self.mas_right;
    }
}


- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)x {
    return self.frame.origin.x;
}
- (CGFloat)y {
    return self.frame.origin.y;
}
- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerX {
    return self.center.x;
}
- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerY {
    return self.center.y;
}
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height {
    return self.frame.size.height;
}
- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size {
    return self.frame.size;
}
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGPoint)origin {
    return self.frame.origin;
}


- (CGPoint)centerPointToOtherView:(UIView *)otherView {
    
    CGFloat otherCenterX = otherView.center.x;
    CGFloat otherCenterY = otherView.center.y;
    CGFloat selfCenterX = self.center.x;
    CGFloat selfCenterY = self.center.y;
    
    CGPoint point = CGPointMake(selfCenterX + (otherCenterX - selfCenterX) * 0.5, selfCenterY + (otherCenterY - selfCenterY) * 0.5);
    return point;
}


/**
 * 便利构造器
 * 说明 创建并使用XIB文件初始视图控制器, 默认使用与控制器相同名字的XIB文件
 * 参数 nibName, XIB文件名
 */
+ (instancetype)instanceUsingAutoNib {
    return [self instanceWithNibName:NSStringFromClass(self.class)];
}
+ (instancetype)instanceWithNibName:(NSString *)nibName {
    return [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] firstObject];
}

- (UIImage *)shotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO,   0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //把当前的整个画面导入到context中，然后通过context输出UIImage，这样就可以把整个屏幕转化为图片
    [self.layer renderInContext:context];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}




#pragma mark - 下面三个不建议使用

/** 为View增加手势 */
- (UITapGestureRecognizer *)kj_touchesBeganBlock:(void(^)(void))touchesBeganBlock touchesBeganRemoveFromSuperview:(BOOL)boo {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchesBeganAction)];
    [self addGestureRecognizer:tap];
    self.touchesBeganBlock = touchesBeganBlock;
    self.touchesBeganRemoveFromSuperview = boo;
    return tap;
}
- (void)touchesBeganAction {
    if (self.touchesBeganBlock) {
        self.touchesBeganBlock();
    }
    if (self.touchesBeganRemoveFromSuperview) {
        [self removeFromSuperview];
    }
}


NSTimeInterval _duration = 0;

static UIView *_backGroundView = nil;

/** 从底部向上钻， 类似UIActionSheet的效果 */

- (void)animateFromScreenButtomWithDuration:(NSTimeInterval)duration completion:(void(^)(BOOL finished))completion coverViewColor:(UIColor *_Nullable)coverViewColor {
    
    _duration = duration;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window endEditing:YES];
    
    window.userInteractionEnabled = NO;
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGRect frame = self.frame;
    frame.origin.y = screenHeight;
    self.frame = frame;
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - self.frame.size.height)];
    if (coverViewColor) {
        backGroundView.backgroundColor = coverViewColor;
    }
    [window addSubview:backGroundView];
    [window addSubview:self];
    
    _backGroundView = backGroundView;
    
    {//添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackGroundView)];
        [backGroundView addGestureRecognizer:tap];
    }
    
    [UIView animateWithDuration:duration animations:^{
        
        self.transform = CGAffineTransformMakeTranslation(0, -self.frame.size.height);
        
        backGroundView.alpha = 1;
        
    } completion:^(BOOL finished) {
        window.userInteractionEnabled = YES;
        if (completion) {
            completion(finished);
        }
    }];
}

/** 这个和上面的向上钻的效果是配合使用 */
- (void)tapBackGroundView {
    [UIView animateWithDuration:_duration animations:^{
        _backGroundView.backgroundColor = [UIColor clearColor];
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [_backGroundView removeFromSuperview];
        _backGroundView = nil;
        [self removeFromSuperview];
    }];
}


- (void)addPanGestureRecognizerWithTarget:(id)target selector:(SEL)selector enableEdgeInset:(BOOL)enableEdgeInset edgeInset:(UIEdgeInsets)edgeInset {
    self.userInteractionEnabled = YES;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:selector];
    self.panGestureRecognizer_EdgeInset = edgeInset;
    self.enablePanEdgeInset = enableEdgeInset;
    [self addGestureRecognizer:pan];
}
/** 发生平移事件之后，处理平移事件 */
- (void)disposePanGestureRecognizer:(UIPanGestureRecognizer *)pan {
    
    if (pan.view != self) {
        NSLog(@"发生问题! 手势view != 当前view");
        return;
    }
    
    
    NSLog(@"触发平移事件");
    
    UIView *eventView = self;
    CGFloat SCREEN_WIDTH = [UIScreen mainScreen].bounds.size.width;
    CGFloat SCREEN_HEIGHT = [UIScreen mainScreen].bounds.size.height;
    
    
    CGPoint transP = [pan translationInView:eventView];
    
    CGFloat offsetX = transP.x;
    
    CGFloat offsetY = transP.y;
    
    
    
    eventView.frame = CGRectMake(eventView.frame.origin.x+offsetX, eventView.frame.origin.y+offsetY, eventView.frame.size.width, eventView.frame.size.height);
    
    [pan setTranslation:CGPointZero inView:eventView];
    
    
    
    if (self.enablePanEdgeInset == NO) return;
    
    UIEdgeInsets edge = self.panGestureRecognizer_EdgeInset;
    
    CGFloat minX = edge.left;
    
    CGFloat maxX = SCREEN_WIDTH - eventView.frame.size.width - edge.right;
    
    CGFloat minY = edge.top;
    
    CGFloat maxY = SCREEN_HEIGHT - eventView.frame.size.height - edge.bottom;
    
    CGFloat curX = 0,curY = 0;
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        //x
        
        if (eventView.frame.origin.x >=minX&& eventView.frame.origin.x <=maxX) {
            
            curX = eventView.frame.origin.x+offsetX;
            
        }else if (eventView.frame.origin.x <minX){
            
            curX = minX;
            
        }else {
            
            curX = maxX;
            
        }
        
        //y
        
        if (eventView.frame.origin.y >=minY&& eventView.frame.origin.y <=maxY) {
            
            curY = eventView.frame.origin.y+offsetY;
            
        }else if (eventView.frame.origin.y <minY){
            
            curY = minY;
            
        }else {
            
            curY = maxY;
            
        }
        
        
        
        [UIView animateWithDuration:0.25 animations:^{
            
            eventView.frame = CGRectMake(curX, curY,eventView.frame.size.width,eventView.frame.size.height);
            
        } completion:^(BOOL finished) {
            
        }];
        
    }
}


// ----------------- runtime ------------

// touchesBeganBlock
- (void)setTouchesBeganBlock:(void(^)(void))touchesBeganBlock {
    objc_setAssociatedObject(self, @"touchesBeganBlock", touchesBeganBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void(^)(void))touchesBeganBlock {
    return objc_getAssociatedObject(self, @"touchesBeganBlock");
}

// touchesBeganRemoveFromSuperview
- (void)setTouchesBeganRemoveFromSuperview:(BOOL)touchesBeganRemoveFromSuperview {
    objc_setAssociatedObject(self, @"touchesBeganRemoveFromSuperview", @(touchesBeganRemoveFromSuperview), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)touchesBeganRemoveFromSuperview {
    NSNumber *boo = objc_getAssociatedObject(self, @"touchesBeganRemoveFromSuperview");
    return boo.boolValue;
}

// panGestureRecognizer_EdgeInset
- (void)setPanGestureRecognizer_EdgeInset:(UIEdgeInsets)panGestureRecognizer_EdgeInset {
    objc_setAssociatedObject(self, @"panGestureRecognizer_EdgeInset", [NSValue valueWithUIEdgeInsets:panGestureRecognizer_EdgeInset], OBJC_ASSOCIATION_RETAIN);
}
- (UIEdgeInsets)panGestureRecognizer_EdgeInset {
    NSValue *value = objc_getAssociatedObject(self, @"panGestureRecognizer_EdgeInset");
    return value.UIEdgeInsetsValue;
}

// enablePanEdgeInset
- (void)setEnablePanEdgeInset:(BOOL)enablePanEdgeInset {
    objc_setAssociatedObject(self, @"enablePanEdgeInset", @(enablePanEdgeInset), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)enablePanEdgeInset {
    NSNumber *boo = objc_getAssociatedObject(self, @"enablePanEdgeInset");
    return boo.boolValue;
}



@end


#pragma mark - -----------------NSDate-----------------
@implementation NSDate (KJCategory)

+ (NSDate *)returnDate:(NSString *)dateString withDateFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    //    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    //    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    //    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    return date;
}
+ (NSString *)currentDateString {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = [NSString stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

+ (NSString *)currentYear {
    NSString *dateString = [NSDate currentDateString];
    return [dateString substringToIndex:4];
}
+ (NSString *)currentMonth {
    NSString *dateString = [NSDate currentDateString];
    return [NSString stringWithFormat:@"%@", [dateString substringWithRange:NSMakeRange(5, 2)]];
}
+ (NSString *)currentDay {
    NSString *dateString = [NSDate currentDateString];
    return [NSString stringWithFormat:@"%@", [dateString substringWithRange:NSMakeRange(8, 2)]];
}
+ (NSString *)currentHour {
    NSString *dateString = [NSDate currentDateString];
    return [NSString stringWithFormat:@"%@", [dateString substringWithRange:NSMakeRange(11, 2)]];
}
+ (NSString *)currentMinute {
    NSString *dateString = [NSDate currentDateString];
    return [NSString stringWithFormat:@"%@", [dateString substringWithRange:NSMakeRange(14, 2)]];
}
+ (NSString *)currentSecond {
    NSString *dateString = [NSDate currentDateString];
    return [NSString stringWithFormat:@"%@", [dateString substringWithRange:NSMakeRange(17, 2)]];
}
- (NSString *)dateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = [NSString stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:self];
    return dateStr;
}
- (NSString *)dateYear {
    return [[self dateString] substringToIndex:4];
}
- (NSString *)dateMonth {
    NSString *str = [self dateString];
    return [NSString stringWithFormat:@"%@", [str substringWithRange:NSMakeRange(5, 2)]];
}
- (NSString *)dateDay {
    NSString *str = [self dateString];
    return [NSString stringWithFormat:@"%@", [str substringWithRange:NSMakeRange(8, 2)]];
}
- (NSString *)dateHour {
    NSString *str = [self dateString];
    return [NSString stringWithFormat:@"%@", [str substringWithRange:NSMakeRange(11, 2)]];
}
- (NSString *)dateMinute {
    NSString *str = [self dateString];
    return [NSString stringWithFormat:@"%@", [str substringWithRange:NSMakeRange(14, 2)]];
}
- (NSString *)dateSecond {
    NSString *str = [self dateString];
    return [NSString stringWithFormat:@"%@", [str substringWithRange:NSMakeRange(17, 2)]];
}
+ (NSString *)currentDateStringWithFormatter:(NSString *)yyyyMMddHHmmss {
    return [[NSDate date] dateStringWithFormatter:yyyyMMddHHmmss];
}
+ (NSString *)dateStringFrom1970second:(double)second withFormatter:(NSString *)formatterStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatterStr;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    return [formatter stringFromDate:date];
}
+ (NSString *)dateStringFrom1970second:(double)second {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = [NSString stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    return [date dateString];
}
- (NSString *)dateStringWithFormatter:(NSString *)formatterStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatterStr;
    NSString *dateStr = [formatter stringFromDate:self];
    return dateStr;
}

+ (NSString *)currentDateUnsignedString {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = [NSString stringWithFormat:@"yyyyMMddHHmmss"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}
+ (NSString *)currentDateUnsigned_Milliseconds {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = [NSString stringWithFormat:@"yyyyMMddHHmmssSSS"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

/**
 *  判断是否是同一天
 */
- (BOOL)isSameDayToDate2:(NSDate *)date2 {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlag = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comp1 = [calendar components:unitFlag fromDate:self];
    NSDateComponents *comp2 = [calendar components:unitFlag fromDate:date2];
    return (([comp1 day] == [comp2 day]) && ([comp1 month] == [comp2 month]) && ([comp1 year] == [comp2 year]));
}


+ (NSDate *)tomorrowDate {
    NSDate *date = [NSDate date];//当前时间
    NSDate *nextDay = [NSDate dateWithTimeInterval:24 * 60 * 60 sinceDate:date];//后一天
    return nextDay;
}
+ (NSDate *)yesterdayDate {
    NSDate *date = [NSDate date];//当前时间
    NSDate *lastDay = [NSDate dateWithTimeInterval:-24 * 60 * 60 sinceDate:date];//前一天
    return lastDay;
}
+ (NSString *)returnWordsForTime:(NSString *)str {
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    timeInterval = timeInterval - 8*60*60;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

@end


#pragma mark - -----------------UIImage-----------------

@implementation UIImage (KJCategory)

+ (nullable UIImage *)kj_imageNamed:(nonnull NSString *)name {
    if (name == nil || [name isEqualToString:@""]) {
        NSLog(@"kj_imageNamed 传入为nil 或为 空字符串 ---> (%@)", name);
        return nil;
    }
    return [self imageNamed:name];
}

+ (UIImage *)imageWithColor:(UIColor *)color imageWidth:(CGFloat)width imageHeight:(CGFloat)height {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, 0.0);
    [color set];
    UIRectFill(CGRectMake(0, 0, width, height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (instancetype)lx_circleImage
{
    // self -> 圆形图片
    
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    
    // 上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(context, rect);
    
    // 裁剪
    CGContextClip(context);
    
    // 绘制图片到圆上面
    [self drawInRect:rect];
    
    // 获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)lx_circleImageNamed:(NSString *)name
{
    return [[self imageNamed:name] lx_circleImage];
}

+ (UIImage *)imageWithOriginalImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


- (UIImage *)grayScale
{
    int width = self.size.width;
    int height = self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    CGContextRef context = CGBitmapContextCreate(nil,
                                                 width,
                                                 height,
                                                 8, // bits per component
                                                 0,
                                                 colorSpace,
                                                 kCGBitmapByteOrderDefault);
    
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,
                       CGRectMake(0, 0, width, height), self.CGImage);
    CGImageRef image = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:image];
    CFRelease(image);
    CGContextRelease(context);
    
    return grayImage;
}

- (UIImage *)scaleWithFixedWidth:(CGFloat)width
{
    float newHeight = self.size.height * (width / self.size.width);
    CGSize size = CGSizeMake(width, newHeight);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.CGImage);
    
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageOut;
}

- (UIImage *)scaleWithFixedHeight:(CGFloat)height
{
    float newWidth = self.size.width * (height / self.size.height);
    CGSize size = CGSizeMake(newWidth, height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.CGImage);
    
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageOut;
}

- (UIColor *)averageColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), self.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    if(rgba[3] > 0) {
        CGFloat alpha = ((CGFloat)rgba[3])/255.0;
        CGFloat multiplier = alpha/255.0;
        return [UIColor colorWithRed:((CGFloat)rgba[0])*multiplier
                               green:((CGFloat)rgba[1])*multiplier
                                blue:((CGFloat)rgba[2])*multiplier
                               alpha:alpha];
    }
    else {
        return [UIColor colorWithRed:((CGFloat)rgba[0])/255.0
                               green:((CGFloat)rgba[1])/255.0
                                blue:((CGFloat)rgba[2])/255.0
                               alpha:((CGFloat)rgba[3])/255.0];
    }
}

- (UIImage *)croppedImageAtFrame:(CGRect)frame
{
    frame = CGRectMake(frame.origin.x * self.scale, frame.origin.y * self.scale, frame.size.width * self.scale, frame.size.height * self.scale);
    CGImageRef sourceImageRef = [self CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, frame);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[self scale] orientation:[self imageOrientation]];
    CGImageRelease(newImageRef);
    return newImage;
}

- (UIImage *)addImageToImage:(UIImage *)img atRect:(CGRect)cropRect{
    
    CGSize size = CGSizeMake(self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    
    CGPoint pointImg1 = CGPointMake(0,0);
    [self drawAtPoint:pointImg1];
    
    CGPoint pointImg2 = cropRect.origin;
    [img drawAtPoint: pointImg2];
    
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}

- (UIImage *)fillClipSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef imageContext = UIGraphicsGetCurrentContext();
    CGContextDrawTiledImage(imageContext, (CGRect){CGPointZero, self.size}, [self CGImage]);
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}


// 对图片进行滤镜处理
// 怀旧 --> CIPhotoEffectInstant                         单色 --> CIPhotoEffectMono
// 黑白 --> CIPhotoEffectNoir                            褪色 --> CIPhotoEffectFade
// 色调 --> CIPhotoEffectTonal                           冲印 --> CIPhotoEffectProcess
// 岁月 --> CIPhotoEffectTransfer                        铬黄 --> CIPhotoEffectChrome
// CILinearToSRGBToneCurve, CISRGBToneCurveToLinear, CIGaussianBlur, CIBoxBlur, CIDiscBlur, CISepiaTone, CIDepthOfField
- (UIImage *)filterImageWithfilterName:(NSString *)name
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:self];
    CIFilter *filter = [CIFilter filterWithName:name];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return resultImage;
}

// 对图片进行模糊处理
// CIGaussianBlur ---> 高斯模糊
// CIBoxBlur      ---> 均值模糊(Available in iOS 9.0 and later)
// CIDiscBlur     ---> 环形卷积模糊(Available in iOS 9.0 and later)
// CIMedianFilter ---> 中值模糊, 用于消除图像噪点, 无需设置radius(Available in iOS 9.0 and later)
// CIMotionBlur   ---> 运动模糊, 用于模拟相机移动拍摄时的扫尾效果(Available in iOS 9.0 and later)
- (UIImage *)blurImageWithBlurName:(NSString *)name
                            radius:(NSInteger)radius
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:self];
    CIFilter *filter;
    if (name.length != 0) {
        filter = [CIFilter filterWithName:name];
        [filter setValue:inputImage forKey:kCIInputImageKey];
        if (![name isEqualToString:@"CIMedianFilter"]) {
            [filter setValue:@(radius) forKey:@"inputRadius"];
        }
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
        UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
        CGImageRelease(cgImage);
        return resultImage;
    }else{
        return nil;
    }
}

// 创建一张实时模糊效果 View (毛玻璃效果)
//Avilable in iOS 8.0 and later
+ (UIVisualEffectView *)effectViewWithFrame:(CGRect)frame
{
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = frame;
    return effectView;
}

// 通过给定颜色和大小生成图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, CGRectMake(0, 0, size.width, size.height));
    //填充颜色为蓝色
    CGContextSetFillColorWithColor(context, color.CGColor);
    //在context上绘制
    CGContextFillPath(context);
    //把当前context的内容输出成一个UIImage图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //上下文栈pop出创建的context
    UIGraphicsEndImageContext();
    return image;
}
// 从View中生成图片
+ (UIImage *)shotImage:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //把当前的整个画面导入到context中，然后通过context输出UIImage，这样就可以把整个屏幕转化为图片
    [view.layer renderInContext:context];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
// 屏幕截图
+ (UIImage *)shotImage {
    CGSize size = [UIScreen mainScreen].bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if ([window respondsToSelector:@selector(screen)] && window.screen == [UIScreen mainScreen])
            continue;
        
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, - window.bounds.size.width * window.layer.anchorPoint.x, - window.bounds.size.height * window.layer.anchorPoint.y);
        [window.layer renderInContext:context];
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// 文字转成图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size title:(NSString *)title titleColor:(UIColor *)titleColor {
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, size.width, size.height);
    label.backgroundColor = color;
    label.text = title; label.textColor = titleColor;
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 文字转换成图片
    [label.layer renderInContext:context];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end


#pragma mark - -----------------NSString-----------------

@implementation NSString (KJCategory)

- (NSAttributedString *)changeToAttributedStringWithString:(NSString *)string color:(UIColor *)color attributedSize:(CGFloat)attributedSize fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = NSMakeRange(fromIndex, toIndex - fromIndex + 1);
    
    if (range.location + range.length > string.length) {
        NSLog(@"警告!!!  越界 %@  range = %@", string, NSStringFromRange(range));
        return nil;
    }
    if (color) {
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:attributedSize] range:range];
    
    return attributedStr;
}


- (NSAttributedString *)changeToAttributedStringWithString:(NSString *)string specialChar:(NSString *)specialChar color:(UIColor *)color attributedSize:(CGFloat)attributedSize toIndex:(NSInteger)toIndex {
    
    if ([string componentsSeparatedByString:specialChar].count - 1 < 1) {
        NSLog(@"传入的字符串里面不包含特殊字符 ------->>> %@, %@", string, specialChar);
        return nil;
    }
    
    NSInteger specialCharLocation = [string rangeOfString:specialChar].location;
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSRange range = NSMakeRange(specialCharLocation, toIndex - specialCharLocation);
    
    if (range.location + range.length > string.length) {
        NSLog(@"警告!!!  越界 %@  range = %@", string, NSStringFromRange(range));
        return nil;
    }
    
    if (color) {
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:attributedSize] range:range];
    return attributedStr;
}


//邮箱
- (BOOL)validateEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

//手机号码验证
- (BOOL)validateMobile {
    //手机号以13，15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(1[0-9][0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

//车牌号验证
- (BOOL)validateCarNo {
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}

//车型
- (BOOL)validateCarType {
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:self];
}

//用户名
- (BOOL)validateUserName {
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:self];
    return B;
}

/**
 * 密码
 * 说明 密码验证数字与字母组合, 默认6-12位
 * 参数 min, 最少位
 * 参数 max, 最大位
 */
- (BOOL)validatePassword {
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,12}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}
- (BOOL)validatePasswordWithMin:(unsigned int)min max:(unsigned int)max {
    NSString *passWordRegex = [NSString stringWithFormat:@"^[a-zA-Z0-9]{%u,%u}+$", min, max];
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}

/**
 * 昵称
 * 说明 以中文开头, 默认4-8位
 * 参数 min, 最少位
 * 参数 max, 最大位
 */
- (BOOL)validateNickname {
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:self];
}
- (BOOL)validateNicknameWithMin:(unsigned int)min max:(unsigned int)max {
    NSString *nicknameRegex = [NSString stringWithFormat:@"^[\u4e00-\u9fa5]{%u,%u}$", min, max];
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:self];
}

//身份证号
- (BOOL)validateIdentityCard {
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

/**
 * 验证码
 * 说明 纯数字验证码, 默认5位
 * 参数 size, 位数
 */
- (BOOL)validateVerifyCode {
    NSString *verifyCodeRegex = @"^[0-9]{5}$";
    NSPredicate *verifyPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",verifyCodeRegex];
    return [verifyPredicate evaluateWithObject:self];
}
- (BOOL)validateVerifyCodeWithSize:(unsigned int)size {
    NSString *verifyCodeRegex = [NSString stringWithFormat:@"^[0-9]{%d}$", size];
    NSPredicate *verifyPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",verifyCodeRegex];
    return [verifyPredicate evaluateWithObject:self];
}


/** 是否全是大写或数字 */
- (BOOL)inputShouldUpperAndNumber {
    if (self.length == 0) return NO;
    NSString *regex =@"[A-Z0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:self];
}

/** 是否全是字母或数字 */
- (BOOL)isCharAndNumber {
    if (self.length == 0) return NO;
    NSString *regex =@"[A-Za-z0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:self];
}


/** 是否包含大写字母 */
- (BOOL)containsUppercase {
    
    // 限制 不能输入的特殊字符串
    NSCharacterSet *cs = nil;
    
    cs = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ"] invertedSet];
    
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    BOOL basicTest = [self isEqualToString:filtered];
    return basicTest;
}
/** 是否包含小写字母 */
- (BOOL)containsLowercase {
    
    
    // 限制 不能输入的特殊字符串
    NSCharacterSet *cs = nil;
    
    cs = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyz"] invertedSet];
    
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    BOOL basicTest = [self isEqualToString:filtered];
    return basicTest;
}
/** 是否包含数字 */
- (BOOL)containsNumber {
    
    
    // 限制 不能输入的特殊字符串
    NSCharacterSet *cs = nil;
    
    cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    BOOL basicTest = [self isEqualToString:filtered];
    return basicTest;
}



/**
 * MD5加密
 * 说明 MD5是消息摘要算法
 * 返回 16位字符串类型的 MD5 hash值
 */
- (NSString *)MD5 {
    const char *cStr = self.UTF8String;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; ++ i){
        [hash appendFormat:@"%02X",result[i]];
    }
    return [hash uppercaseString];
}

// 过滤首尾的空格和换行
- (NSString *)trimWhiteAndNewline {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
// 过滤首尾的空格
- (NSString *)trimWhite {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

// 过滤所有的空格和换行
- (NSString *)trimAllWhiteAndNewline {
    NSString *result = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return [result stringByReplacingOccurrencesOfString:@"\r" withString:@""];
}
// 过滤所有的空格
- (NSString *)trimAllWhite {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}


+ (NSString *)uuidString {
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}


/**
 *  这个在时间很短时， 得到多个随机数， 可能得到的随机数是相同的
 */
+ (NSString *)returnGetArc4randomWithNum:(NSUInteger)num type:(Arc4randomType)type {
    
    NSString *sourceStr = nil;
    switch (type) {
        case Arc4randomType_Number:
            sourceStr = @"0123456789";
            break;
        case Arc4randomType_Number_Up_Low_Char:
            sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
            break;
        case Arc4randomType_Up_Char:
            sourceStr = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            break;
        case Arc4randomType_Low_Char:
            sourceStr = @"abcdefghijklmnopqrstuvwxyz";
            break;
        case Arc4randomType_Number_Low_Char:
            sourceStr = @"0123456789abcdefghijklmnopqrstuvwxyz";
            break;
        case Arc4randomType_Number_Up_Char:
            sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            break;
        default:
            break;
    }
    
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < num; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

+ (NSString *)returnArc4randomWithNum:(NSUInteger)num type:(Arc4randomType)type {
    
    NSString *sourceStr = nil;
    switch (type) {
        case Arc4randomType_Number:
            sourceStr = @"0123456789";
            break;
        case Arc4randomType_Number_Up_Low_Char:
            sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
            break;
        case Arc4randomType_Up_Char:
            sourceStr = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            break;
        case Arc4randomType_Low_Char:
            sourceStr = @"abcdefghijklmnopqrstuvwxyz";
            break;
        case Arc4randomType_Number_Low_Char:
            sourceStr = @"0123456789abcdefghijklmnopqrstuvwxyz";
            break;
        case Arc4randomType_Number_Up_Char:
            sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            break;
        default:
            break;
    }
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    for (int i = 0; i < num; i++)
    {
        unsigned index = arc4random() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}


+ (NSString *)arrayStringWithStringArray:(NSArray *)array {
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < array.count; i++) {
        NSString *str = array[i];
        if (i != 0) {
            [string appendString:[NSString stringWithFormat:@", %@", str]];
        } else {
            [string appendString:[NSString stringWithFormat:@"%@", str]];
        }
    }
    return string;
}


#pragma mark - 字符串操作
- (NSString *)kj_substringFromIndex:(NSUInteger)from {
    if ([self isKindOfClass:[NSString class]] == NO) {
        NSLog(@"%s ---> %@ 不是NSString类型", __func__, self);
        return nil;
    }
    if (from > self.length || from < 0) {
        NSLog(@"%s ---> %@ 长度%lu 下标%lu越界", __func__, self, self.length, from);
        return nil;
    }
    return [self substringFromIndex:from];
}
- (NSString *)kj_substringToIndex:(NSUInteger)to {
    if ([self isKindOfClass:[NSString class]] == NO) {
        NSLog(@"%s ---> %@ 不是NSString类型", __func__, self);
        return nil;
    }
    if (to > self.length || to < 0) {
        NSLog(@"%s ---> %@ 长度%lu 下标%lu越界", __func__, self, self.length, to);
        return nil;
    }
    return [self substringToIndex:to];
}


- (NSString *)kj_substringWithRange:(NSRange)range {
    if ([self isKindOfClass:[NSString class]] == NO) {
        NSLog(@"%s ---> %@ 不是NSString类型", __func__, self);
        return nil;
    }
    NSUInteger location = range.location;
    NSUInteger length = range.length;
    if (location > self.length || location < 0 || length > self.length || length < 0) {
        NSLog(@"%s ---> range的location 或 length 不符合规范 %@,  字符串(%@)长度是%lu", __func__, NSStringFromRange(range), self, self.length);
        return nil;
    }
    if (location + length > self.length) {
        NSLog(@"%s ---> %@ 越界,  字符串(%@)长度是%lu", __func__, NSStringFromRange(range), self, self.length);
        return nil;
    }
    return [self substringWithRange:range];
}
- (NSString *)kj_stringByAppendingString:(NSString *)aString {
    if ([self isKindOfClass:[NSString class]] == NO) {
        NSLog(@"%s ---> %@ 不是NSString类型", __func__, self);
        return nil;
    }
    if ([aString isKindOfClass:[NSString class]] == NO || aString == nil) {
        NSLog(@"不能拼接一个空字符串 或者 非NSString类型 %@ ", aString);
        return self;
    }
    return [self stringByAppendingString:aString];
}



@end


@implementation CALayer (KJCategory)


- (void)pauseAnimation {
    if (self.speed == 0.0) {
        return;
    }
    CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed = 0.0;
    self.timeOffset = pausedTime;
}

- (void)goonAnimation {
    if (self.speed == 1.0) {
        return;
    }
    CFTimeInterval pausedTime = [self timeOffset];
    self.speed = 1.0;
    self.timeOffset = 0.0;
    self.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.beginTime = timeSincePause;
}

@end

