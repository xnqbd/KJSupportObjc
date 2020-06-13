//
//  WDYHFCategory.h.m
//  KJProduct
//
//  Created by uback on 2018/3/19.
//  Copyright © 2018年 uback. All rights reserved.
//

#import "NSObject+WDYHFCategory.h"
#import <CommonCrypto/CommonDigest.h>
#import <objc/message.h>
#import "UIView+CKJDesingable.h"

#pragma mark - -----------------异常处理-----------------

BOOL WDKJ_IsNullObj(id obj, Class cla) {
    if (obj == nil) {
        return YES;
    } else if ([obj isKindOfClass:[NSNull class]]) {
        return YES;
    } else if ([obj isKindOfClass:cla] == NO) {
        return YES;
    }
    return NO;
}
BOOL WDKJ_IsEmpty_Str(NSString *_Nullable str) {
    if (str == nil) {
        return YES;
    } else if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    } else if ([str isKindOfClass:NSString.class] == NO) {
        return YES;
    } else if ([str isEqualToString:@""]) {
        return YES;
    } else {
        return NO;
    }
}
BOOL WDKJ_IsEmpty_AttributedStr(NSAttributedString *_Nullable attStr) {
    if (attStr == nil) {
        return YES;
    } else if ([attStr isKindOfClass:[NSAttributedString class]]) {
        return WDKJ_IsEmpty_Str(attStr.string);
    } else {
        return YES;
    }
}

BOOL WDKJ_IsNull_Num(NSNumber *_Nullable number) {
    if (number == nil) {
        return YES;
    } else if ([number isKindOfClass:[NSNull class]]) {
        return YES;
    } else if ([number isKindOfClass:NSNumber.class] == NO) {
        return YES;
    } else {
        return NO;
    }
}
BOOL WDKJ_IsNull_Array(NSArray *_Nullable array) {
    if (array == nil) {
        return YES;
    } else if ([array isKindOfClass:[NSNull class]]) {
        return YES;
    } else if ([array isKindOfClass:NSArray.class] == NO) {
        return YES;
    } else {
        return NO;
    }
}

NSString * WDKJ_ConfirmString(NSString *_Nullable str) {
    return WDKJ_IsEmpty_Str(str) ? @"" : str;
}
NSString * WDKJ_SpaceString(NSString *_Nullable str) {
    return (WDKJ_IsEmpty_Str(str) ? @" " : str);
}

NSAttributedString * WDKJ_SpaceAttString(NSAttributedString *_Nullable attStr) {
    return WDKJ_IsEmpty_AttributedStr(attStr) ? [[NSAttributedString alloc] initWithString:@" "] : attStr;
}
NSAttributedString * WDKJ_ConfirmAttString(NSAttributedString *_Nullable attStr) {
    return WDKJ_IsEmpty_AttributedStr(attStr) ? [[NSAttributedString alloc] init] : attStr;
}

NSNumber * WDKJ_ConfirmNumber(NSNumber *_Nullable number) {
    return (WDKJ_IsNull_Num(number) ? @0 : number);
}
NSDictionary * WDKJ_ConfirmDic(NSDictionary *_Nullable dic) {
    if (WDKJ_IsNullObj(dic, [NSDictionary class])) {
        return @{};
    } else {
        return dic;
    }
}
NSArray * WDKJ_ConfirmArray(NSArray *_Nullable array) {
    if (WDKJ_IsNullObj(array, [NSArray class])) {
        return @[];
    } else {
        return array;
    }
}


BOOL WDKJ_IsNull_NumberOrString(id numberOrString) {
    BOOL isNSNumberClass = [numberOrString isKindOfClass:NSNumber.class];
    BOOL isNSStringClass = [numberOrString isKindOfClass:NSString.class];
    
    if (numberOrString == nil) {
        return YES;
    } else if ([numberOrString isKindOfClass:[NSNull class]]) {
        return YES;
    } else if (isNSNumberClass || isNSStringClass) {
        return NO;
    } else {
        return YES;
    }
}
BOOL WDKJ_CompareNumberOrString(id numberOrString, NSString * myStr) {
    // 传入的origin可能是 字符串、也可能是NSNumber,
    // 传入的myStr只能传入字符串, 而且不能为空
    
    // 如果初始值是 字符串类型的话
    
    if (myStr == nil) {
        return NO;
    }
    
    if (numberOrString == nil) {
        
        return numberOrString == myStr;
        
    } else if ([numberOrString isKindOfClass:[NSNull class]]) {
        
        return numberOrString == myStr;
        
    } else if ([numberOrString isKindOfClass:NSString.class]) {
        
        NSString *temp = (NSString *)numberOrString;
        
        if ([myStr isKindOfClass:NSString.class]) {
            
            myStr = WDKJ_ConfirmString(myStr);
            BOOL result = [temp isEqualToString:myStr];
            return result;
            
        } else if ([myStr isKindOfClass:NSNumber.class]) {
            
            NSString *my = ((NSNumber *)myStr).stringValue;
            BOOL result = [temp isEqualToString:my];
            return result;
        } else {
            NSLog(@"警告！ 传入的 %@ 应该是NSString 或者 NSNumber类型", myStr);
            return NO;
        }
    } else if ([numberOrString isKindOfClass:NSNumber.class]) {
        
        NSNumber *temp = (NSNumber *)numberOrString;
        
        if ([myStr isKindOfClass:NSString.class]) {
            myStr = WDKJ_ConfirmString(myStr);
            NSNumber *my = [NSNumber numberWithInteger:myStr.integerValue];
            BOOL result = [temp isEqualToNumber:my];
            return result;
            
        } else if ([myStr isKindOfClass:NSNumber.class]) {
            BOOL result = [temp isEqualToNumber:(NSNumber *)myStr];
            return result;
        } else {
            NSLog(@"警告！ 传入的 %@ 应该是NSString 或者 NSNumber类型", myStr);
            return NO;
        }
        
    } else {
        NSLog(@"警告！ 传入的 %@ 应该是NSString 或者 NSNumber类型", numberOrString);
        return NO;
    }
}

#pragma mark - -----------------其他-----------------

NSString *WDKJ_Sex(NSNumber *sex) {
    NSString *def = @"未知";
    
    //0女 1男
    
    if (WDKJ_IsNullObj(sex, [NSNumber class])) {
        return def;
    }
    if (sex.intValue == 1) {
        return @"男";
    } else if (sex.intValue == 0) {
        return @"女";
    }
    return def;
}

NSMutableAttributedString * WDCKJAttributed(NSString *_Nullable name, NSDictionary *_Nullable dic) {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:WDKJ_ConfirmString(name) attributes:(dic)];
    return str;
}

NSMutableAttributedString * WDCKJAttributed2(NSString *_Nullable text, UIColor *_Nullable color, id _Nullable fontSize) {
    UIColor *_color = WDKJ_IsNullObj(color, [UIColor class]) ? [UIColor blackColor] : color;
    
    UIFont *font = [UIFont systemFontOfSize:15.5];
    
    if ([fontSize isKindOfClass:[NSNumber class]]) {
        font = [UIFont systemFontOfSize:((NSNumber *)fontSize).floatValue];
    } else  if ([fontSize isKindOfClass:[UIFont class]]) {
        font = fontSize;
    } else {
    }
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:WDKJ_ConfirmString(text) attributes:@{NSForegroundColorAttributeName : _color, NSFontAttributeName : font}];
    
    return str;
}

NSMutableAttributedString * WDAttTitle(NSString *_Nullable text) {
    return WDCKJAttributed2(text, [UIColor kjwd_title], @15.5);
}
NSMutableAttributedString * WDAttTitle14(NSString *_Nullable text) {
    return WDCKJAttributed2(text, [UIColor kjwd_title], @14);
}

NSMutableAttributedString * WDAttSubTitle(NSString *_Nullable text) {
    return WDCKJAttributed2(text, [UIColor kjwd_subTitle], @15.5);
}
NSMutableAttributedString * WDAttSubTitle14(NSString *_Nullable text) {
    return WDCKJAttributed2(text, [UIColor kjwd_subTitle], @14);
}


NSMutableAttributedString * WDAtt13(NSString *_Nullable name) {
    return WDCKJAttributed2(name, nil, @13.5);
}


NSMutableAttributedString * WDAtt15_5(NSString *_Nullable name) {
    return WDCKJAttributed2(name, [UIColor kjwd_title], @15.5);
}


NSMutableAttributedString * WDCKJAttributed3(NSString *_Nullable text, CGFloat horizontalSpace, CGFloat lineSpace, UIColor *_Nullable color, NSNumber *_Nullable fontSize) {
    if (WDKJ_IsEmpty_Str(text)) {
        return [[NSMutableAttributedString alloc] init];
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSKernAttributeName:@(horizontalSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    UIColor *_color = WDKJ_IsNullObj(color, [UIColor class]) ? [UIColor blackColor] : color;
    CGFloat _fontSize = WDKJ_IsNull_Num(fontSize) ? 15.5 : fontSize.integerValue;
    
    [attributedString addAttributes:@{NSForegroundColorAttributeName : _color, NSFontAttributeName : [UIFont systemFontOfSize:_fontSize]} range:NSMakeRange(0, [text length])];
    //    [attributedString  addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, [text length])];
    return attributedString;
}
NSMutableAttributedString * WDCKJAttAppend(NSString *_Nullable text1, UIColor *_Nullable color1, NSNumber *_Nullable fontSize1, NSString *_Nullable text2, UIColor *_Nullable color2, NSNumber *_Nullable fontSize2) {
    NSMutableAttributedString *att = WDCKJAttributed2(text1, color1, fontSize1);
    [att appendAttributedString:WDCKJAttributed2(text2, color2, fontSize2)];
    return att;
}


NSMutableAttributedString * WDCKJAttBold(NSString *_Nullable text, UIColor *_Nullable color, NSNumber *_Nullable fontSize) {
    UIColor *_color = WDKJ_IsNullObj(color, [UIColor class]) ? [UIColor blackColor] : color;
    CGFloat _fontSize = WDKJ_IsNull_Num(fontSize) ? 15.5 : fontSize.integerValue;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:WDKJ_ConfirmString(text) attributes:@{NSForegroundColorAttributeName : _color, NSFontAttributeName : [UIFont boldSystemFontOfSize:_fontSize]}];
    return str;
}

NSMutableAttributedString * WDCKJAttributed6(CGRect bounds, UIImage *_Nullable image, NSString *_Nullable text, UIColor *_Nullable color, NSNumber *_Nullable fontSize) {
    //3.初始化NSTextAttachment对象
    NSTextAttachment *attchment = [[NSTextAttachment alloc]init];
    attchment.bounds = bounds;//设置frame
    attchment.image = WDKJ_IsNullObj(image, [UIImage class]) ? nil : image;//设置图片
    
    NSAttributedString *imageAtt = [NSAttributedString attributedStringWithAttachment:(NSTextAttachment *)(attchment)];
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithAttributedString:imageAtt];
    
    [result appendAttributedString:WDCKJAttributed2(text, color, fontSize)];
    return result;
}


int getRandomNumber(int from, int to) {
    int temp = to - from + 1;
    int num = (arc4random() % temp);
    return from + num;
}

void WDCKJdispatch_async_main_queue(void(^block)(void)) {
    dispatch_async(dispatch_get_main_queue(), ^{
        block ? block() : nil;
    });
}
void WDCKJBGColor_Arc4Color(UIView *view) {
    if ([view isKindOfClass:[UIView class]] == NO) return;
    void (*kj_sengMsg)(id, SEL, UIColor *) = (void (*)(id, SEL, UIColor *))objc_msgSend;
    kj_sengMsg(view, @selector(setBackgroundColor:), [UIColor kjwd_arc4Color]);
}


void WDCKJ_ifDEBUG(void(^_Nullable debugBlock)(void), void(^_Nullable releaseBlock)(void)) {
#ifdef DEBUG
    debugBlock ? debugBlock() : nil;
#else
    releaseBlock ? releaseBlock() : nil;
#endif
}

CGFloat WDAPP_ScreenWidth(void) {
    return [UIScreen mainScreen].bounds.size.width;
}
CGFloat WDAPP_ScreenHeight(void) {
    return [UIScreen mainScreen].bounds.size.height;
}





@implementation UIWindow (WDYHFCategory)

+ ( UIWindow *)kjwd_appdelegateWindow {
    id appdelegate = [UIApplication sharedApplication].delegate;
    id (*kj_sengMsg)(id, SEL) = (id (*)(id, SEL))objc_msgSend;
    UIWindow *window = kj_sengMsg(appdelegate, sel_registerName("window"));
    return window;
}


@end

@implementation NSObject (WDYHFCategory)


/*
 让一段代码在一段时间内只能执行一次， 这个方法就算很频繁执行， 但在指定时间内block中的代码也只会执行一次
 */
- (void)kjwd_executedOnceInTimeInterval:(NSTimeInterval)timeInterval block:(void(^)(void))block {
    
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
// 让一段代码在一段时间内只能执行一次， 只会执行最后的 最新的，比如输入框里的延迟1秒后搜索
//- (void)kjwd_executedNewestHandle:(void(^_Nullable)(void))handle InTimeInterval:(NSTimeInterval)timeInterval {
//    
//    NSDate *currentDate = [NSDate date];
//    NSTimeInterval interval = [currentDate timeIntervalSinceDate:self.markDate];
//    
//    // 当已经停止输入字符  2秒内，只搜索最新的关键字
//    //              2秒
//    if (interval < timeInterval) {
//        
//        // 增加block
//        NSMutableArray *arr = [NSMutableArray kjwd_arrayWithArray:self.markBlockArray];
//        [arr addObject:handle];
//        self.markBlockArray = arr;
//        return;
//    }
//    
//    
//    self.markDate = [NSDate date];
//    
//    void (^block)(void) = self.markBlockArray.lastObject;
//    
//    if (block) {
//        block();
//    }
//}



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

//- (void)setMarkBlockArray:(NSArray *)markBlockArray {
//    objc_setAssociatedObject(self, @"markBlockArray", markBlockArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//- (NSArray *)markBlockArray {
//    NSArray *markBlockArray = objc_getAssociatedObject(self, @"markBlockArray");
//    return markBlockArray;
//}


- (void)kjwd_setValuesForKeysWithDictionary:(nullable NSDictionary<NSString *, id> *)keyedValues {
    if (WDKJ_IsNullObj(keyedValues, [NSDictionary class])) return;
    [self setValuesForKeysWithDictionary:keyedValues];
}

@end

@implementation NSNull (WDYHFCategory)

- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"请修复NSNull空的情况 %@ ", NSStringFromSelector(aSelector));
    __block NSString *string = @"";
    WDCKJ_ifDEBUG(^{
        string = @"此处错误，请修复NSNull为空的情况";
    }, nil);
    return string;
}

@end

#pragma mark - -----------------NSData-----------------
@implementation NSData (WDYHFCategory)

- (NSString *)kjwd_utf8String {
    NSString *string = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    if (string == nil) {
        string = [[NSString alloc] initWithData:[self kjwd_UTF8Data] encoding:NSUTF8StringEncoding];
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

- (NSData *)kjwd_UTF8Data {
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

+ (instancetype)kjwd_dataWithContentsOfURL:(id)url {
    NSData *data = nil;
    if ([url isKindOfClass:[NSString class]]) {
        data = [NSData dataWithContentsOfURL:[NSURL kjwd_URLWithString:url]];
    } else if ([url isKindOfClass:[NSURL class]]) {
        data = [NSData dataWithContentsOfURL:url];
    }
    return data ? data : [NSData data];
}


@end


#pragma mark - -----------------NSTimer-----------------
@implementation NSTimer (Category)
+ ( NSTimer *)kjwd_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats nowPerform:(BOOL)boo handleBlockOnMainQueue:(void(^)(NSTimer * currentTimer))block {
    NSTimer *timer = [self scheduledTimerWithTimeInterval:interval
                                                   target:self
                                                 selector:@selector(kj_blockInvoke:)
                                                 userInfo:[block copy]
                                                  repeats:repeats];
    
    
    if (boo) {
        if (block) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(timer);
            });
        }
    }
    return timer;
}
+ (void)kj_blockInvoke:(NSTimer *)timer {
    void (^block)(NSTimer *) = timer.userInfo;
    if(block) {
        dispatch_async(dispatch_get_main_queue(), ^{        
            block(timer);
        });
    }
}

@end
#pragma mark - -----------------NSArray-----------------
@implementation NSArray (WDYHFCategory)

+ ( NSArray *)kjwd_readJsonDataFromLocalWithName:(nullable NSString *)name type:(nullable NSString *)type {
    if (WDKJ_IsEmpty_Str(name)) {
        return @[];
    }
    if (WDKJ_IsEmpty_Str(type)) {
        type = nil;
    }
    
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    if (data == nil) {
        return @[];
    }
    
    return [NSJSONSerialization JSONObjectWithData:data
                                           options:kNilOptions
                                             error:nil];
}


- (void)kjwd_DoElementPropertyValueEqualWithPropertyName:(NSString *_Nullable)propertyName handle:(void(^_Nullable)(NSMutableArray <NSArray *>* data, NSArray <NSString *>* propertyValueSortedSet))handle {
    NSMutableArray *result = [NSMutableArray array];
    
    if (handle == nil) {
        return;
    }
    
    if (WDKJ_IsEmpty_Str(propertyName)) {
        handle(result, @[]);
        return;
    }
    
    NSArray *propertyValueArray =  [self valueForKeyPath:propertyName]; // 这个和self.count个数一样， 和self的顺序也一样
    
    NSArray *temp = [NSSet setWithArray:propertyValueArray].allObjects; // 无序的
    NSMutableArray *sort = [NSMutableArray array];
    
    for (int i = 0; i < self.count; i++) {
        id objc = [self objectAtIndex:i];
        id propertyValue = [objc valueForKeyPath:propertyName];

        for (id value in temp) {
            if (propertyValue == value) {
                if ([sort containsObject:propertyValue] == NO) {
                    [sort addObject:propertyValue];
                }
            }
        }
    }
    
    
    for (id value in sort) {
        NSMutableArray *elementArray = [NSMutableArray array];
        for (int i = 0; i < self.count; i++) {
            id objc = [self objectAtIndex:i];
            id propertyValue = [objc valueForKeyPath:propertyName];
            if (propertyValue == value) {
                [elementArray addObject:objc];
            }
        }
        [result addObject:elementArray];
    }
    handle(result, sort);
}

- (void)kjwd_do_conformBlock:(BOOL(^)(id obj, NSUInteger idx))conformBlock handle:(void(^ )(BOOL isConform, id obj, NSUInteger idx))handle {
    if (conformBlock == nil) return;
    if (handle == nil) return;
    
    for (NSUInteger i = 0; i < self.count; i++) {
        id objc = [self kjwd_objectAtIndex:i];
        BOOL boo = conformBlock(objc, i);
        handle(boo, objc, i);
    }
}
- (NSArray *)kjwd_do_filter_returnConformNewArray:(BOOL (^)(id))filterBlock {
    if (filterBlock == nil) {
        NSLog(@"filterBlock 不能为空");
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (id objc in self) {
        BOOL flag = filterBlock(objc);
        if (flag) {
            [array kjwd_addObject:objc];
        }
    }
    return array;
}

- (nullable id)kjwd_do_filter_returnConformObject:(BOOL (^)(id))filterBlock {
    if (filterBlock == nil) {
        NSLog(@"filterBlock 不能为空");
        return nil;
    }
    for (id objc in self) {
        BOOL isConform = filterBlock(objc);
        if (isConform) {
            return objc;
        }
    }
    return nil;
}
- (nullable NSNumber *)kjwd_do_filter_returnConformIndex:(BOOL (^)(id))filterBlock {
    if (filterBlock == nil) {
        NSLog(@"filterBlock 不能为空");
        return nil;
    }
    for (NSInteger i = 0; i < self.count; i++) {
        id objc = [self kjwd_objectAtIndex:i];
        BOOL isConform = filterBlock(objc);
        if (isConform) {
            return @(i);
        }
    }
    return nil;
}

- (id)kjwd_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        NSLog(@"位置 %lu 越界, 当前数组个数是 %lu", (unsigned long)index, (unsigned long)self.count);
        return nil;
    } else {
        id value = [self objectAtIndex:index];
        if (value == [NSNull null]) {
            NSLog(@"第%lu元素为NULL  个数是 %lu  数组是%@ ", (unsigned long)index, (unsigned long)self.count, self);
            return nil;
        }
        return [self objectAtIndex:index];
    }
}
- (nullable NSNumber *)kjwd_indexOfObject:(nullable id)anObject {
    if (anObject == nil) {
        return nil;
    }
    NSUInteger idex = [self indexOfObject:anObject];
    return @(idex);
}


- (NSArray *)kjwd_reverseArray {
    NSArray *array = [[self reverseObjectEnumerator] allObjects];
    return array;
}

- (void)kjwd_reverseEnumerateObjectsUsingBlock:(void (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))block {
    if (block == nil) return;
    
    BOOL stop = NO;
    
    for (NSInteger i = self.count - 1 ; i >= 0; i--) {
        if (stop == YES) {
            return;
        }
        id object = [self kjwd_objectAtIndex:i];
        block(object, i, &stop);
    }
}

- ( NSString *)kjwd_arrayString {
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
- (NSString *)kjwd_stringValue {
    NSMutableString *string = [NSMutableString string];
    for (id obj in self) {
        [string appendString:[NSString stringWithFormat:@"%@", obj]];
    }
    return string;
}

- ( NSIndexSet *)kjwd_indexSetValue {
    NSMutableIndexSet *set = [NSMutableIndexSet indexSet];
    for (int i = 0; i < self.count; i++) {
        NSNumber *num = [self kjwd_objectAtIndex:i];
        if ([num isKindOfClass:NSNumber.class] == NO) {
            return set;
        }
        [set addIndex:num.integerValue];
    }
    return set;
}
- ( NSArray <NSNumber *>*)kjwd_indexArray {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < self.count; i++) {
        [arr addObject:@(i)];
    }
    return arr;
}

- (NSMutableArray *)kjwd_mergeArray:(NSArray *_Nullable)otherArray {
    NSMutableArray *result = [NSMutableArray arrayWithArray:self];
    if (WDKJ_IsNull_Array(otherArray) == NO) {
        [result addObjectsFromArray:otherArray];
    }
    return result;
}

- ( NSSet *)kjwd_intersectWithArray:(NSArray *)array {
    if (array == nil) {
        return [NSSet set];
    }
// #warning 注意：这里self 元素类型应该是NSNumber类型,  你可以调用 self.kjwd_indexArray
    
    NSMutableSet *set1 = [NSMutableSet setWithArray:self];
    NSMutableSet *set2 = [NSMutableSet setWithArray:array];
    
    [set1 intersectSet:set2];
    return set1;
}


- (void)kjwd_lookValuesDataType {
    [self enumerateObjectsUsingBlock:^(id   obj, NSUInteger idx, BOOL *  stop) {
        NSLog(@"数组下标 %lu", (unsigned long)idx);
        if ([obj isKindOfClass:[NSString class]]) {
//            NSLog(@"%lu   NSString *%@ ", idx, obj);
            
            NSLog(@"@property (copy, nonatomic) NSString *%@;", obj);
            
        } else if ([obj isKindOfClass:[NSNumber class]]) {
//            NSLog(@"数组下标%lu   NSNumber *%@ ", idx, obj);
            
            
            NSLog(@"@property (copy, nonatomic) NSNumber *%@;", obj);
            
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *temp = (NSDictionary *)obj;
            [temp kjwd_lookValuesDataType];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            [self kjwd_lookValuesDataType];
        } 
        NSLog(@"\n\n");
    }];
}

- (NSArray *)kjwd_filteredArrayUsingPredicate:(NSString *_Nullable)predicate {
    if (WDKJ_IsEmpty_Str(predicate)) {
        return @[];
    }
    NSPredicate *pre1 = [NSPredicate predicateWithFormat:predicate];
    
    NSArray *result = @[];
    @try {
       result = [self filteredArrayUsingPredicate:pre1];
    } @catch (NSException *exception) {
        NSLog(@"异常!!! 谓词在数组中匹配异常!!!  %@  %@ ", predicate, exception);
    } @finally {
        NSLog(@"%@ ", @"完成");
    }
    return result;
}

@end

#pragma mark - -----------------NSMutableArray-----------------
@implementation NSMutableArray (WDYHFCategory)

+ (instancetype)kjwd_enumTo:(NSUInteger)to returnItemBlock:(id(^_Nonnull)(NSUInteger i))callBack {
    return [self kjwd_enumFrom:0 to:to returnItemBlock:callBack];
}
+ (instancetype)kjwd_enumFrom:(NSUInteger)from to:(NSUInteger)to returnItemBlock:(id(^_Nonnull)(NSUInteger i))callBack {
    NSMutableArray *result = [NSMutableArray array];
    if (callBack == nil) {
        return result;
    }
    if (from > to) {
        return result;
    }
    for (NSUInteger i = from; i <= to; i++) {
        id obj = callBack(i);
        [result kjwd_addObject:obj];
    }
    return result;
}

+ (instancetype)kjwd_arrayWithArray:(nullable NSArray *)array {
    if (WDKJ_IsNull_Array(array)) {
        return [NSMutableArray array];
    }
    return [NSMutableArray arrayWithArray:array];
}

- (BOOL)kjwd_addObject:(id)object {
    if (object == nil || [object isKindOfClass:[NSNull class]]) {
        NSLog(@"kj_addObject 对象不能被加入 因为对象为空");
        return NO;
    } else {
        [self addObject:object];
        return YES;
    }
}
- (BOOL)kjwd_addObjectsFromArray:(NSArray *)array {
    if (WDKJ_IsNull_Array(array)) {
        NSLog(@"kj_addObjectsFromArray 数组不能被加入 因为对象为空");
        return NO;
    } else {
        [self addObjectsFromArray:array];
        return YES;
    }
}
- (BOOL)kjwd_insertObject:(id)object atIndex:(NSUInteger)index {
    if (object == nil || [object isKindOfClass:[NSNull class]]) {
        NSLog(@"kj_insertObject 对象不能被插入 因为对象为空");
        return NO;
    }
    if (index < 0) {
        NSLog(@"kj_insertObject 不能插入在小于0的位置 , 当前数组个数是 %lu", (unsigned long)self.count);
        return NO;
    }
    
    if (index == self.count) {
        [self kjwd_addObject:object];
        return YES;
    } else if (index > self.count) {
        NSLog(@"kj_insertObject 位置 %lu 越界, 当前数组个数是 %lu", (unsigned long)index, (unsigned long)self.count);
        return NO;
    } else {
        [self insertObject:object atIndex:index];
        return YES;
    }
}

- (BOOL)kjwd_insertObjects:(nullable NSArray *)objects atIndex:(NSUInteger)index {
    if (WDKJ_IsNull_Array(objects)) {
        NSLog(@"kjwd_insertObjects 对象不能被插入 因为对象为空");
        return NO;
    }
    if (index < 0) {
        NSLog(@"kjwd_insertObjects 不能插入在小于0的位置 , 当前数组个数是 %lu", (unsigned long)self.count);
        return NO;
    }
    
    if (index == self.count) {
        [self addObjectsFromArray:objects];
        return YES;
    } else if (index > self.count) {
        NSLog(@"kjwd_insertObjects 位置 %lu 越界, 当前数组个数是 %lu", (unsigned long)index, (unsigned long)self.count);
        return NO;
    } else {
        NSRange range = NSMakeRange(index, [objects count]);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        
        [self insertObjects:objects atIndexes:indexSet];
        return YES;
    }
}


- (BOOL)kjwd_removeObjectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        NSLog(@"kj_removeObjectAtIndex 位置 %lu 越界, 当前数组个数是 %lu", (unsigned long)index, (unsigned long)self.count);
        return NO;
    } else {
        [self removeObjectAtIndex:index];
        return YES;
    }
}
- (void)kjwd_safeRemoveObjectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        NSLog(@"传入的索引  %lu 越界，  数组个数是 %lu", (unsigned long)index, (unsigned long)self.count);
        return;
    }
    if (index < 0) {
        NSLog(@"传入的索引  %lu 越界，  数组个数是 %lu", (unsigned long)index, (unsigned long)self.count);
        return;
    }
    
    for (NSInteger i = self.count - 1 ; i >= 0; i--) {
        if (index == i) {
            [self kjwd_removeObjectAtIndex:i];
        }
    }
}
- (void)kjwd_removeAllObjects_IncludedRows:(NSArray <NSNumber *>*)includedRows {
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    for (NSNumber *indexNum in includedRows) {
        [indexSet addIndex:indexNum.intValue];
    }
    [self removeObjectsAtIndexes:indexSet];
}

- (void)kjwd_removeAllObjects_notIncludedRows:(NSArray <NSNumber *>*)notIncludedRows {
    
    NSIndexSet *indexSet = [self kjwd_returnIndexSet_notIncludedRowsOfYou:notIncludedRows];
    
    [self removeObjectsAtIndexes:indexSet];
}

- ( NSIndexSet *)kjwd_returnIndexSet_notIncludedRowsOfYou:(NSArray <NSNumber *>*)notIncludedRows {
    
    if (notIncludedRows == nil) {
        return [NSIndexSet indexSet];
    }
    
    NSMutableArray *selfIndexs = [NSMutableArray array];
    for (int i = 0 ; i < self.count; i++) {
        [selfIndexs addObject:@(i)];
    }
    
    NSMutableSet *selfSet = [NSMutableSet setWithArray:selfIndexs];
    NSMutableSet *targetSet = [NSMutableSet setWithArray:notIncludedRows];
    
    [selfSet minusSet:targetSet];      //取差集后 set1中为
    
    
    //minusArr 里面装着 需要删除的下标
    NSArray <NSNumber *> *minusArr = selfSet.allObjects;
    
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    
    [minusArr enumerateObjectsUsingBlock:^(NSNumber *  obj, NSUInteger idx, BOOL *  stop) {
        [indexSet addIndex:obj.intValue];
    }];
    
    return indexSet;
}
- (NSIndexSet *)kjwd_returnIndexSet_IncludedRowsOfYou:(NSArray <NSNumber *>*)includedRows {
    
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    
    [includedRows enumerateObjectsUsingBlock:^(NSNumber *  obj, NSUInteger idx, BOOL *  stop) {
        [indexSet addIndex:obj.intValue];
    }];
    
    return indexSet;
}


- (BOOL)kjwd_insertAt_FirstIndex_Of_Object:(id)object {
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
- (BOOL)kjwd_replaceObjectAtIndex:(NSUInteger)index withObject:(id)object {
    if (index >= self.count) {
        NSLog(@"kj_replaceObjectAtIndex 替换失败 位置 %lu 越界, 当前数组个数是 %lu", (unsigned long)index, (unsigned long)self.count);
        return NO;
    }
    if (object == nil || [object isKindOfClass:[NSNull class]]) {
        NSLog(@"kj_replaceObjectAtIndex 替换失败 此对象不能被插入到 %lu 位置 因为对象为空", (unsigned long)index);
        return NO;
    }
    [self replaceObjectAtIndex:index withObject:object];
    return YES;
}


+ (instancetype)kjwd_arrayWithKeyValuesArray:(NSArray <NSDictionary *>* _Nullable)keyValuesArray modelClass:(Class)ModelClass callBack:(void(^_Nullable )(id currentModel))callBack {
    
    keyValuesArray = WDKJ_ConfirmArray(keyValuesArray);
    
    NSMutableArray *result = [NSMutableArray array];
    
    [keyValuesArray enumerateObjectsUsingBlock:^(NSDictionary *  obj, NSUInteger idx, BOOL *  stop) {
        NSObject *model = [[ModelClass alloc] init];
        [model setValuesForKeysWithDictionary:WDKJ_ConfirmDic(obj)];
        if (callBack) {
            callBack(model);
        }
        [result addObject:model];
    }];
    return result;
}



@end


#pragma mark - -----------------NSDictionary-----------------
@implementation NSDictionary (WDYHFCategory)

- ( NSString *)kjwd_returnJsonString {

    NSString *result = @"";
    NSError *error = nil;
    NSData *jsonData = nil;
    
    BOOL exp = NO;
    
    @try {
        jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        
    } @catch (NSException *exception) {
        NSLog(@"字典转JSON字符串时异常了， 异常信息：%@   ", exception);
        exp = YES;
    }
    
    if (exp) {
        NSLog(@"真的异常了 %@ ", error);
    } else {
           if (!jsonData) {
               NSLog(@"字典转JSON字符串失败 %@", error);
           } else {
               result = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
           }
    }
    return result;
}

- ( NSString *)kjwd_convertToJsonStringWithoutLineAndbreak {
    
    NSString *origin = [self kjwd_returnJsonString];
    if (WDKJ_IsEmpty_Str(origin)) return @"";
    NSMutableString *mutStr = [NSMutableString stringWithString:origin];
    NSRange range = NSMakeRange(0, mutStr.length);
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = NSMakeRange(0, mutStr.length);
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}
- ( NSString *)kjwd_myConvertToJsonStringAsData {
    NSMutableString *mutStr = [NSMutableString stringWithString:[self kjwd_convertToJsonStringWithoutLineAndbreak]];
    NSRange range = NSMakeRange(0, mutStr.length);
    [mutStr replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSLiteralSearch range:range];
    return mutStr;
}

- (NSString *)kjwd_returnString {
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

- (void)kjwd_lookValuesDataType {
    WDCKJ_ifDEBUG(^{
        // 在js里有的key对应的value为null，这里不会遍历出来这些键值对
            
            [self enumerateKeysAndObjectsUsingBlock:^(id   key, id   obj, BOOL *  stop) {
                if ([obj isKindOfClass:[NSString class]]) {
                    NSLog(@"@property (copy, nonatomic) NSString *%@;              %@ ", key, obj);
                } else if ([obj isKindOfClass:[NSNumber class]]) {
                    NSLog(@"@property (copy, nonatomic) NSNumber *%@;              %@ ", key, obj);
                } else if ([obj isKindOfClass:[NSDictionary class]]) {
                    [self kjwd_lookValuesDataType];
                } else if ([obj isKindOfClass:[NSArray class]]) {
                    NSLog(@"@property (strong, nonatomic) NSArray *%@;", key);
                    
                    NSArray *temp = (NSArray *)obj;
                    [temp kjwd_lookValuesDataType];
                } else {
                    
                    NSLog(@"@property (strong, nonatomic) id %@;              %@ ", key, obj);
                }
            }];
    }, nil);
}

- (void)kjwd_encode_log {
    WDCKJ_ifDEBUG(^{
        NSString *(^bl)(id value) = ^NSString *(id value){
            NSString *type = @"";
            if ([value isKindOfClass:[NSNumber class]]) {
                type = @"NSNumber";
            } else if ([value isKindOfClass:[NSString class]]) {
                type = @"NSString";
            } else if ([value isKindOfClass:[NSArray class]]) {
                type = @"NSArray";
            } else if ([value isKindOfClass:[NSDictionary class]]) {
                type = @"NSDictionary";
            } else {
                type = @"其他类型";
            }
            return type;
        };
        
        [self enumerateKeysAndObjectsUsingBlock:^(id   key, id   obj, BOOL *  stop) {
            NSString *type = bl(obj);
            NSLog(@"%@  [coder encodeObject:self.%@ forKey:@\"%@\"];            ", type, key, key);
        }];
        NSLog(@"\n\n");
        [self enumerateKeysAndObjectsUsingBlock:^(id   key, id   obj, BOOL *  stop) {
            NSString *type = bl(obj);
            NSLog(@"%@  self.%@ = [coder decodeObjectForKey:@\"%@\"];            ", type, key, key);
        }];
    }, nil);
}


- (NSArray <NSArray *>*)kjwd_returnKeysArrayValuesArray {
    
    NSMutableArray *result = [NSMutableArray array];
    NSMutableArray *keyArr = [NSMutableArray array];
    NSMutableArray *valueArr = [NSMutableArray array];
    for (id objc in self.allKeys) {
        [keyArr kjwd_addObject:objc];
        [valueArr kjwd_addObject:self[objc]];
    }
    [result kjwd_addObject:keyArr];
    [result kjwd_addObject:valueArr];
    return result;
}

- ( NSMutableArray *)kjwd_returnDicArrayWithSort:(NSComparator NS_NOESCAPE)cmptr {
    if (cmptr == nil) {
        return [NSMutableArray array];
    }
    
    NSArray *keys = [self.allKeys sortedArrayUsingComparator:cmptr];
    
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSString *key in keys) {
        id value = self[key];
        [result addObject:@{key : value}];
    }
    return result;
}

+ ( NSDictionary *)kjwd_readJsonDataFromLocalWithName:(nullable NSString *)name type:(nullable NSString *)type {
    if (WDKJ_IsEmpty_Str(name)) {
        return @{};
    }
    if (WDKJ_IsEmpty_Str(type)) {
        type = nil;
    }
    
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    if (data == nil) {
        return @{};
    }
    
    return [NSJSONSerialization JSONObjectWithData:data
                                           options:kNilOptions
                                             error:nil];
}
+ ( NSDictionary *)kjwd_readFromJsonString:(nullable NSString *)jsonStr {
    
    if (WDKJ_IsEmpty_Str(jsonStr)) {
        return @{};
    }
    
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    if (jsonData == nil) return @{};
    
    NSError *err = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return @{};
    }
    return dic;
    
}

@end



#pragma mark - -----------------NSIndexSet-----------------

@implementation NSIndexSet (WDYHFCategory)

- (NSArray *)kjwd_returnArray {
    NSMutableArray *array = [NSMutableArray array];
    [self enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *  stop) {
        [array addObject:@(idx)];
    }];
    return array;
}

@end


#pragma mark - -----------------UIAlertController-----------------

@implementation UIAlertController (WDYHFCategory)



+ (instancetype)kjwd_alertTitle:(NSString *_Nullable)alertTitle message:(NSString *_Nullable)message alertAction_Left:(NSString *_Nullable)leftActionTitle leftBlock:(void(^_Nullable)(void))leftBlock right:(NSString *_Nullable)rightActionTitle rightBlock:(void(^_Nullable)(void))rightBlock presentingVC:(UIViewController *_Nullable)presentingVC {
    UIAlertController *alert = [self alertControllerWithTitle:alertTitle message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (leftActionTitle) {
        UIAlertAction *left = [UIAlertAction actionWithTitle:leftActionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
            if (leftBlock) {
                leftBlock();
            }
        }];
        [alert addAction:left];
    }
    if (rightActionTitle) {
        UIAlertAction *right = [UIAlertAction actionWithTitle:rightActionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
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

+ (instancetype)kjwd_alertTitle:(NSString *_Nullable)alertTitle message:(NSString *_Nullable)message actionSheet_top:(NSString *_Nullable)topSheetTitle topBlock:(void(^_Nullable)(void))topBlock centerSheet:(NSString *_Nullable)centerSheetTitle centerBlock:(void(^_Nullable)(void))centerBlock buttomSheet:(NSString *_Nullable)buttomSheetTitle buttomBlock:(void(^_Nullable)(void))buttomBlock presentingVC:(UIViewController *_Nullable)presentingVC {

    if (WDKJ_IsEmpty_Str(alertTitle)) {
        alertTitle = @"";
    }
    if (WDKJ_IsEmpty_Str(message)) {
        message = [NSString stringWithFormat:@"%@", message];
    }
    
    UIAlertController *alert = [self alertControllerWithTitle:alertTitle message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    if (topSheetTitle) {
        UIAlertAction *top = [UIAlertAction actionWithTitle:topSheetTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
            if (topBlock) {
                topBlock();
            }
        }];
        [alert addAction:top];
    }
    if (centerSheetTitle) {
        UIAlertAction *center = [UIAlertAction actionWithTitle:centerSheetTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
            if (centerBlock) {
                centerBlock();
            }
        }];
        [alert addAction:center];
    }
    if (buttomSheetTitle) {
        UIAlertAction *buttom = [UIAlertAction actionWithTitle:buttomSheetTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *  action) {
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

@implementation UITabBar (WDYHFCategory)

- (void)kjwd_setTopImage:(UIImage *)image {
    [self setShadowImage:image];
    [self setBackgroundImage:[[UIImage alloc]init]];
}

@end


#pragma mark - -----------------UIColor-----------------
@implementation UIColor (WDYHFCategory)

+ ( UIColor *)kjwd_arc4Color {
    uint32_t r = arc4random_uniform(256);
    uint32_t g = arc4random_uniform(256);
    uint32_t b = arc4random_uniform(256);
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1];
}
+ ( UIColor *)kjwd_r:(NSInteger)r g:(NSInteger)g b:(NSInteger)b alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:alpha];
}
+ ( UIColor *)kjwd_rbg:(NSInteger)rgb alpha:(CGFloat)alpha {
    return [self kjwd_r:rgb g:rgb b:rgb alpha:alpha];
}

+ ( UIColor *)kjwd_colorWithHexString:(NSString *)color {
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


+ ( UIColor *)kjwd_title {
    return [UIColor kjwd_colorWithHexString:@"333333"];
}

+ ( UIColor *)kjwd_subTitle {
    return [UIColor kjwd_colorWithHexString:@"969696"];
}
+ ( UIColor *)kjwd_230Color {
    return [UIColor kjwd_r:230 g:230 b:230 alpha:1];
}


+ (UIColor *)kjwd_blueBtnColor {
    return [UIColor kjwd_r:25 g:130 b:197 alpha:1];
}
+ (UIColor *)kjwd_coverGrayWithAlphaComponent:(CGFloat)alpha {
    return [[UIColor blackColor] colorWithAlphaComponent:alpha];
}

@end



@implementation NSURL (KJ_Category)

+ ( NSURL *)kjwd_URLWithString:(nullable NSString *)urlString {
    if (WDKJ_IsEmpty_Str(urlString)) {
        return [[NSURL alloc] init];
    }
    NSURL *url = [NSURL URLWithString:urlString];
    if (url) {
        return url;
    }
    
    NSCharacterSet *encode_set= [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *urlString_encode = [urlString stringByAddingPercentEncodingWithAllowedCharacters:encode_set];
    url = [NSURL URLWithString:urlString_encode];
   
    return url ? url : [[NSURL alloc] init];
}

+ (void)kjwd_openURLWithString:(NSString *_Nullable)urlString options:(NSDictionary<UIApplicationOpenExternalURLOptionsKey, id> *_Nullable)options completionHandler:(void (^_Nullable)(BOOL success))completion {
    NSURL *url = [self kjwd_URLWithString:urlString];
    if (options == nil) {
        options = @{};
    }
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        if(@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:options completionHandler:completion];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

@end

#pragma mark - -----------------UIViewController-----------------
@implementation UIViewController (WDYHFCategory)
/** 得到当前控制器 被 哪一个控制器 推过来的 控制器 */
- (nullable UIViewController *)kjwd_previous_PushedVC {
    UINavigationController *navc = self.navigationController;
    if (navc.viewControllers.count == 1) return nil;
    UIViewController *vc = [navc.viewControllers objectAtIndex:navc.viewControllers.count - 2];
    return vc;
}

/** 从MainStoryBoard加载同名的控制器 */
+ (instancetype)kjwd_instanceInMain {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
}

/** 从MainStoryBoard加载 标示 的控制器 */
+ (instancetype)kjwd_instanceInMainWithIdentifier:(NSString *)identifier {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}

/**
 *  pop到指定控制器
 *  如果当前导航控制器包含所想要pop到的控制器，会调用currentStackBlock
 *  如果当前导航控制器不包含所想要pop到的控制器，那么把newVc插入到导航控制器的viewControllers数组里
 *  @param vcClass 类名 (例如[ViewController class])
 */
- (void)kjwd_popToSpecifyVC:(Class)vcClass currentStackBlock:(void(^_Nullable)(__kindof UIViewController *findZheVC))currentStackBlock newAllocVC:(__kindof UIViewController *_Nullable)newVc {
    BOOL boo = NO;
    
    UINavigationController *navc = self.navigationController;
    
    NSArray *stackArray = navc.viewControllers;
    NSArray *array = [stackArray kjwd_reverseArray];
    
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
            NSLog(@"想要pop 到新控制器，newVc不能为nil");
            return;
        }
        if ([newVc isKindOfClass:[UIViewController class]] == NO) {
            NSLog(@"想要pop 到新控制器，newVc要为UIViewController类型");
            return;
        }
        NSMutableArray <__kindof UIViewController *>*array = [NSMutableArray arrayWithArray:WDKJ_ConfirmArray(self.navigationController.viewControllers)];
        [array kjwd_insertObject:newVc atIndex:[array indexOfObject:self]];
        [self.navigationController setViewControllers:array animated:NO];
        [navc popViewControllerAnimated:YES];
    }
}
- (void)kjwd_settoRootVCWithAnimation:(BOOL)animation {
    
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

@implementation UINavigationController (WDYHFCategory)

- (nullable UIViewController *)kjwd_rootViewController {
    NSArray *vcArray = self.viewControllers;
    NSUInteger count = vcArray.count;
    if (count == 0) return nil;
    return [vcArray kjwd_objectAtIndex:0];
}
- (void)kjwd_setClearNavigationBar {
    //设置导航栏背景图片为一个空的image，这样就透明了
//    UIImage *image = [UIImage kjwd_imageWithColor:[UIColor clearColor] size:CGSizeMake(100, 40)];
    UIImage *image = [[UIImage alloc] init];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
}
- (void)kjwd_setTitleColorFontDic:(NSDictionary *)dic {
    self.navigationBar.titleTextAttributes = dic;
}

- (void)kjwd_setLeftRightBarButtonItemColor:(UIColor *)color {
    self.navigationBar.tintColor = color;
}

@end

#pragma mark - -----------------UIBarButtonItem-----------------



@interface UIBarButtonItem (Property)

@property (copy, nonatomic, nullable) void (^kjCallBackBlock)(UIBarButtonItem *sender);

@end


@implementation UIBarButtonItem (WDYHFCategory)

+ ( instancetype)kjwd_itemWithTitle:(nullable NSString *)title color:(nullable UIColor *)color callBack:(void(^)(UIBarButtonItem *sender))callBack {
    UIBarButtonItem *temp = [[self alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:nil action:NULL];
    temp.tintColor =  color;
    temp.kjCallBackBlock = callBack;
    temp.target = temp;
    temp.action = @selector(handleCallBack:);
    return temp;
}

+ ( instancetype)kjwd_itemWithNormalImage:(nullable UIImage *)normalImage detailSetting:(void(^_Nullable)(UIButton * btn, UIView * superview))detailSetting wrapperSize:(CGSize)wrapperSize btnFrame:(CGRect)btnFrame  style:(UIBarButtonItemStyle)style callBack:(void(^_Nullable)(UIBarButtonItem * sender))callBack {
    
    UIView *wrapper = [[UIView alloc] init];
    // 只能设置size大小，origin始终会是0,0 原点，
    // 如果是leftBarButtonItem， 那么始终会距离左边一定距离
    // 如果是rightBarButtonItem，那么始终会距离右边一定距离
    wrapper.frame = CGRectMake(0, 0, wrapperSize.width, wrapperSize.height);
    
//    WDCKJBGColor_Arc4Color(wrapper);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
   
//    WDCKJBGColor_Arc4Color(btn);
    [btn setImage:normalImage forState:UIControlStateNormal];
    btn.frame = btnFrame;
    [wrapper addSubview:btn];
    detailSetting ? detailSetting(btn, wrapper) : nil;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:wrapper];
    
    item.kjCallBackBlock = callBack;
    __weak UIBarButtonItem *weakItem = item;
    [btn kjwd_addTouchUpInsideForCallBack:^(UIButton *  sender) {
        [weakItem handleCallBack:weakItem];
    }];
    
    return item;
}

- (void)handleCallBack:(UIBarButtonItem *)sender {
    self.kjCallBackBlock ? self.kjCallBackBlock(self) : nil;
}

//--------- runtime
- (void)setKjCallBackBlock:(void (^)(UIBarButtonItem *))kjCallBackBlock {
    objc_setAssociatedObject(self, @"kjCallBackBlock", kjCallBackBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIBarButtonItem *))kjCallBackBlock {
    void (^block)(UIBarButtonItem *) = objc_getAssociatedObject(self, @"kjCallBackBlock");
    return block;
}


@end

#pragma mark - -----------------UINavigationItem-----------------
@implementation UINavigationItem (WDYHFCategory)


/**
 titleView 仅仅是一张图片 （默认居中）
 */
+ ( UIView *)kjwd_returnTitleViewWithImage:(nullable UIImage *)image imageViewSize:(CGSize)imageViewSize detailSetting:(void(^_Nullable)(UIImageView * imageView, UIView * superview))detailSetting {
    if (WDKJ_IsNullObj(image, [UIImage class])) {
        return [[UIView alloc] init];
    }
    
    CGRect rect = CGRectMake(0, 0, imageViewSize.width, imageViewSize.height);
    
    // 只能设置size大小，设置origin没有效果
    // width最大距离就是左边挨着leftBarButtonItem， 右边挨着rightBarButtonItem
    // height在一定的数值内设置有效
    UIView *wrapper = [[UIView alloc] init];
    wrapper.frame = rect;
//    WDCKJBGColor_Arc4Color(wrapper);
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:image];
    imageV.frame = rect;
    imageV.center = wrapper.center;
    [wrapper addSubview:imageV];
    if (detailSetting) {
        detailSetting(imageV, wrapper);
    }
    return wrapper;
}

@end

@implementation UITableView (WDYHFCategory)

- (void)kjwd_reloadData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}

- (void)kjwd_reloadSection:(NSInteger)section withRowAnimation:(UITableViewRowAnimation)animation {
    if ([self numberOfSections] - 1 >= section) {
        // 10个分区， 0_9
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:section];
        [self reloadSections:set withRowAnimation:animation];
    }
}

- (void)kjwd_selectRow:(NSInteger)row section:(NSInteger)section animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition {
    if ([self numberOfSections] > section && [self numberOfRowsInSection:section] > row) {
        [self selectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section] animated:animated scrollPosition:scrollPosition];
    }
}
- (void)kjwd_scrollToRow:(NSInteger)row section:(NSInteger)section atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated {
    if ([self numberOfSections] > section && [self numberOfRowsInSection:section] > row) {
        [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section] atScrollPosition:scrollPosition animated:animated];
    }
}

@end


@implementation UICollectionView (WDYHFCategory)

- (void)kjwd_reloadData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}

@end




#pragma mark - -----------------UIView-----------------

@interface UIView (Property)


@property (weak, nonatomic) UIView *animateFromScreenButtomWithBackGroundView;
@property (assign, nonatomic) CGFloat animateFromScreenButtomWithHeight;
@property (assign, nonatomic) NSTimeInterval animateFromScreenButtomWithDuration;
@property (copy, nonatomic) void (^triggerTapGestureRecognizerBlock)(void(^disappearBlock)(void));
@property (copy, nonatomic) void (^gestureRecognizerBlock)(UIGestureRecognizer *sender, UIView *currentView);




@end


@implementation UIView (WDYHFCategory)


- (nullable __kindof UIViewController *)kjwd_currentViewController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

/// 获取当前的Cell，实例 CKJCommonTableViewCell *cell = [btn kjwd_getCell];
- (nullable __kindof UITableViewCell *)kjwd_getCell {
    UIView *currentView = self;
    while (![currentView isKindOfClass:[UITableViewCell class]] && currentView) {
        NSLog(@"当前的View是 %@   ", currentView);
        currentView = currentView.superview;
    }
    if (currentView) {
        NSLog(@"找到了Cell  %@", currentView);
    }
    return (UITableViewCell *)currentView;
}


- (MASViewAttribute *)kjwdMas_safeAreaTop {
    if (@available(iOS 11.0, *)) {
        return self.mas_safeAreaLayoutGuideTop;
    } else {
        return self.mas_top;
    }
}
- (MASViewAttribute *)kjwdMas_safeAreaBottom {
    if (@available(iOS 11.0, *)) {
        return self.mas_safeAreaLayoutGuideBottom;
    } else {
        return self.mas_bottom;
    }
}
- (MASViewAttribute *)kjwdMas_safeAreaLeft {
    if (@available(iOS 11.0, *)) {
        return self.mas_safeAreaLayoutGuideLeft;
    } else {
        return self.mas_left;
    }
}
- (MASViewAttribute *)kjwdMas_safeAreaRight {
    if (@available(iOS 11.0, *)) {
        return self.mas_safeAreaLayoutGuideRight;
    } else {
        return self.mas_right;
    }
}

/*
 
 make.left.equalTo(superview.kjwdMas_safeAreaLeft);
 make.right.equalTo(superview.kjwdMas_safeAreaRight);
 make.top.equalTo(superview.kjwdMas_safeAreaTop);
 make.bottom.equalTo(superview.kjwdMas_safeAreaBottom);
 
 make.height.equalTo(@60);
 
 */

- (NSArray *)kjwd_masWithSuperView:(UIView *)superView makeConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))block {
    [superView addSubview:self];
    return [self kjwd_mas_makeConstraints:block];
}

- (NSArray *)kjwd_mas_makeConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))block {
    if (self.superview == nil) {
        NSLog(@"%@的父视图为空", self);
        return nil;
    }
    if (block == nil) {
        return nil;
    }
    UIView *superV = self.superview;
    return [self mas_makeConstraints:^(MASConstraintMaker *make) {
        block(make, superV);
    }];
}

- (NSArray *)kjwd_mas_updateConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))block {
    if (self.superview == nil) {
        NSLog(@"%@的父视图为空", self);
        return nil;
    }
    if (block == nil) {
        return nil;
    }
    UIView *superV = self.superview;
    return [self mas_updateConstraints:^(MASConstraintMaker *make) {
        block(make, superV);
    }];
}
- (NSArray *)kjwd_mas_remakeConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))block {
    if (self.superview == nil) {
        NSLog(@"%@的父视图为空", self);
        return nil;
    }
    if (block == nil) {
        return nil;
    }
    UIView *superV = self.superview;
    return [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        block(make, superV);
    }];
}

- (void)kjwd_addToSuperView:(nullable UIView *)superview constraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))block {
    if (superview == nil) return;
    if ([superview isKindOfClass:[UIView class]] == NO) return;
    
    [superview addSubview:self];
    [self kjwd_mas_makeConstraints:block];
}

- (void)kjwd_setHidden:(BOOL)hidden {
    if (hidden) { // 想要隐藏
        if (self.hidden == NO) {
            self.hidden = YES;
        }
    } else {  // 想要显示
        if (self.hidden) {
            self.hidden = NO;
        }
    }
}

- (void)setKjwd_x:(CGFloat)kjwd_x {
    CGRect frame = self.frame;
    frame.origin.x = kjwd_x;
    self.frame = frame;
}
- (void)setKjwd_y:(CGFloat)kjwd_y {
    CGRect frame = self.frame;
    frame.origin.y = kjwd_y;
    self.frame = frame;
}
- (CGFloat)kjwd_x {
    return self.frame.origin.x;
}
- (CGFloat)kjwd_y {
    return self.frame.origin.y;
}
- (void)setKjwd_centerX:(CGFloat)kjwd_centerX {
    CGPoint center = self.center;
    center.x = kjwd_centerX;
    self.center = center;
}
- (CGFloat)kjwd_centerX {
    return self.center.x;
}
- (void)setKjwd_centerY:(CGFloat)kjwd_centerY {
    CGPoint center = self.center;
    center.y = kjwd_centerY;
    self.center = center;
}
- (CGFloat)kjwd_centerY {
    return self.center.y;
}
- (void)setKjwd_width:(CGFloat)kjwd_width {
    CGRect frame = self.frame;
    frame.size.width = kjwd_width;
    self.frame = frame;
}
- (void)setKjwd_height:(CGFloat)kjwd_height {
    CGRect frame = self.frame;
    frame.size.height = kjwd_height;
    self.frame = frame;
}
- (CGFloat)kjwd_height {
    return self.frame.size.height;
}
- (CGFloat)kjwd_width {
    return self.frame.size.width;
}
- (void)setKjwd_size:(CGSize)kjwd_size {
    CGRect frame = self.frame;
    frame.size = kjwd_size;
    self.frame = frame;
}
- (CGSize)kjwd_size {
    return self.frame.size;
}
- (void)setKjwd_origin:(CGPoint)kjwd_origin {
    CGRect frame = self.frame;
    frame.origin = kjwd_origin;
    self.frame = frame;
}
- (CGPoint)kjwd_origin {
    return self.frame.origin;
}


- (CGPoint)kjwd_centerPointToOtherView:(UIView *)otherView {
    
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
+ (instancetype)kjwd_instanceUsingAutoNib {
    return [self kjwd_instanceWithNibName:NSStringFromClass(self.class)];
}
+ (instancetype)kjwd_instanceWithNibName:(NSString *)nibName {
    return [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] firstObject];
}

- (UIImage *)kjwd_shotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO,   0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //把当前的整个画面导入到context中，然后通过context输出UIImage，这样就可以把整个屏幕转化为图片
    [self.layer renderInContext:context];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (image == nil) {
        image = [[UIImage alloc] init];
    }
    return image;
}

#pragma mark - 从底部向上钻动画效果
- (void)masonryWithAnimateFromScreenButtomWithDuration:(NSTimeInterval)duration superView:(UIView *_Nullable)superView selfMasonryHeight:(CGFloat)height coverViewColor:(UIColor *_Nullable)coverViewColor animationCompletion:(void (^_Nullable)(BOOL))completionBlock triggerTapGestureRecognizerBlock:(void(^)(void(^ disappearBlock)(void)))triggerTapGestureRecognizerBlock {
    
    self.triggerTapGestureRecognizerBlock = triggerTapGestureRecognizerBlock;
    
    if (superView == nil) {
        superView = [UIWindow kjwd_appdelegateWindow];
    }
    if (coverViewColor == nil) {
        coverViewColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    
    UIView *backGroundView = ({
        UIView *tmp = [[UIView alloc] init];
        tmp.backgroundColor = [UIColor clearColor];
        [superView addSubview:tmp];
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(kjwd_tapBackGroundView)];
        [tmp addGestureRecognizer:tap];
        self.animateFromScreenButtomWithBackGroundView = tmp;
        tmp;
    });
    [superView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.height.equalTo(@(height));
        make.bottom.equalTo(superView.mas_bottom).offset(height);
    }];
    [backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(superView);
        make.bottom.equalTo(self.mas_top);
    }];
    
    [superView layoutIfNeeded];
    
    self.animateFromScreenButtomWithDuration = duration;
    self.animateFromScreenButtomWithHeight = height;
    
    
    [UIView animateWithDuration:duration animations:^{
        backGroundView.backgroundColor = coverViewColor ? coverViewColor : [UIColor blackColor];
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(superView.mas_bottom);
        }];
        [superView layoutIfNeeded];
    } completion:^(BOOL finished) {
        completionBlock ? completionBlock(finished) : nil;
    }];
}

// 这个是从底部向上点击事件
- (void)kjwd_tapBackGroundView {
    void (^disappearBlock)(void) = ^ {
        [self masonryWithAnimateFromScreenButtom_hiddenBackGroundView];
    };
    self.triggerTapGestureRecognizerBlock ? self.triggerTapGestureRecognizerBlock(disappearBlock) : nil;
}

/** 这个和上面的向上钻的效果是配合使用 */
- (void)masonryWithAnimateFromScreenButtom_hiddenBackGroundView {
    UIView *superView = self.superview;
    [UIView animateWithDuration:self.animateFromScreenButtomWithDuration animations:^{
        self.animateFromScreenButtomWithBackGroundView.backgroundColor = [UIColor clearColor];
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(superView.mas_bottom).offset(self.animateFromScreenButtomWithHeight);
        }];
        [superView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.animateFromScreenButtomWithBackGroundView removeFromSuperview];
        [self removeFromSuperview];
    }];
}


- (void)kjwd_addGestureRecognizer:(UIGestureRecognizer *)ges handleBlock:(void(^)(__kindof UIGestureRecognizer * gestureRecognizer, __kindof UIView * currentView))handleBlock {
    [ges addTarget:self action:@selector(kjwd_gestureRecognizerAction:)];
    [self addGestureRecognizer:ges];
    self.gestureRecognizerBlock = handleBlock;
}
- (void)kjwd_gestureRecognizerAction:(UIGestureRecognizer *)sender {
    self.gestureRecognizerBlock ? self.gestureRecognizerBlock(sender, self) : nil;
}
- (void)kjwd_addTapGestureRecognizerHandleBlock:(void(^)(UITapGestureRecognizer *_gestureRecognizer, UIView *_currentView))handleBlock {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [self kjwd_addGestureRecognizer:tap handleBlock:handleBlock];
}



// ----------------- runtime ------------

// animateFromScreenButtomWithHeight
- (void)setAnimateFromScreenButtomWithHeight:(CGFloat)animateFromScreenButtomWithHeight {
    objc_setAssociatedObject(self, @"animateFromScreenButtomWithHeight", @(animateFromScreenButtomWithHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)animateFromScreenButtomWithHeight {
    NSNumber *height = objc_getAssociatedObject(self, @"animateFromScreenButtomWithHeight");
    return height.floatValue;
}

// animateFromScreenButtomWithDuration
- (void)setAnimateFromScreenButtomWithDuration:(NSTimeInterval)animateFromScreenButtomWithDuration {
    // 对double类型的只能用 OBJC_ASSOCIATION_RETAIN_NONATOMIC, 不然会-[CFNumber retain]: message sent to deallocated instance
    
    objc_setAssociatedObject(self, @"animateFromScreenButtomWithDuration", @(animateFromScreenButtomWithDuration), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSTimeInterval)animateFromScreenButtomWithDuration {
    // 对double类型的只能用 OBJC_ASSOCIATION_RETAIN_NONATOMIC, 不然会-[CFNumber retain]: message sent to deallocated instance
    NSNumber *timeInterval = objc_getAssociatedObject(self, @"animateFromScreenButtomWithDuration");
    return timeInterval.doubleValue;
}


// animateFromScreenButtomWithBackGroundView
- (void)setAnimateFromScreenButtomWithBackGroundView:(UIView *)animateFromScreenButtomWithBackGroundView {
    if (animateFromScreenButtomWithBackGroundView == nil) {
        return;
    }
    CKJOriginalObject *originalObject = [[CKJOriginalObject alloc] initWithBlock:^{
        // 在对象dealloc的时候，需要把self的属性设置为nil
        objc_setAssociatedObject(self, @"animateFromScreenButtomWithBackGroundView", nil, OBJC_ASSOCIATION_ASSIGN);
    }];
    objc_setAssociatedObject(animateFromScreenButtomWithBackGroundView, (__bridge const void *)(originalObject.block), originalObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, @"animateFromScreenButtomWithBackGroundView", animateFromScreenButtomWithBackGroundView, OBJC_ASSOCIATION_ASSIGN);  //
}
- (UIView *)animateFromScreenButtomWithBackGroundView {
    UIView *temp = objc_getAssociatedObject(self, @"animateFromScreenButtomWithBackGroundView");
    return temp;
}

// triggerTapGestureRecognizerBlock
- (void)setTriggerTapGestureRecognizerBlock:(void (^)(void))triggerTapGestureRecognizerBlock {
    objc_setAssociatedObject(self, @"triggerTapGestureRecognizerBlock", triggerTapGestureRecognizerBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(void (^)(void)))triggerTapGestureRecognizerBlock {
    void (^block)(void(^)(void))  = objc_getAssociatedObject(self, @"triggerTapGestureRecognizerBlock");
    return block;
}



// 手势 gestureRecognizerBlock
- (void)setGestureRecognizerBlock:(void (^)(UIGestureRecognizer *, UIView *))gestureRecognizerBlock {
    objc_setAssociatedObject(self, @"gestureRecognizerBlock", gestureRecognizerBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(UIGestureRecognizer *, UIView *))gestureRecognizerBlock {
    void (^temp)(UIGestureRecognizer *, UIView *) = objc_getAssociatedObject(self, @"gestureRecognizerBlock");
    return temp;
}

// 附加
- (void)setEx_Obj1:(id)ex_Obj1 {
    objc_setAssociatedObject(self, @"ex_Obj1", ex_Obj1, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (id)ex_Obj1 {
    id ex_Obj1 = objc_getAssociatedObject(self, @"ex_Obj1");
    return ex_Obj1;
}

@end

#pragma mark - -----------------UIButton-----------------


@interface UIButton (Property)

@property (copy, nonatomic, nullable) void (^kjCallBackBlock)(UIButton *sender);

@end


@implementation UIButton (WDYHFCategory)

- (void)kjwd_layoutButtonWithEdgeInsetsStyle:(GLButtonEdgeInsetsStyle)style
                             imageTitleSpace:(CGFloat)space {
    /**
     *  知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     *  如果只有title，那它上下左右都是相对于button的，image也是一样；
     *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     */
    
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    
    switch (style) {
        case GLButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case GLButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case GLButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case GLButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}


- (void)kjwd_addTouchUpInsideForCallBack:(void(^_Nullable)(UIButton *  sender))callBack {
    [self kjwd_addControlEvents:UIControlEventTouchUpInside forCallBack:callBack];
}
- (void)kjwd_addControlEvents:(UIControlEvents)controlEvents forCallBack:(void (^_Nullable)(UIButton * ))callBack {
    if (callBack == nil) return;
    self.kjCallBackBlock = callBack;
    [self addTarget:self action:@selector(btnCallBack:) forControlEvents:controlEvents];
}
- (void)btnCallBack:(UIButton *)sender {
    self.kjCallBackBlock ? self.kjCallBackBlock(self) : nil;
}


/// 实心样式的
+ (instancetype)fillStyleWithTitle:(id)title bgColor:(UIColor *_Nullable)bgColor radius:(NSNumber *_Nullable)radius callBack:(void(^_Nullable)(UIButton * _sender))callBack {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    btn.layer.masksToBounds = YES;
    
    if ([radius isKindOfClass:[NSNumber class]]) {
        btn.layer.cornerRadius = radius.floatValue;
    } else {
        btn.layer.cornerRadius = 5;
    }
    
    if ([title isKindOfClass:[NSString class]]) {
        [btn setTitle:(NSString *)title forState:UIControlStateNormal];
    } else if ([title isKindOfClass:[NSAttributedString class]]) {
        [btn setAttributedTitle:(NSAttributedString *)title forState:UIControlStateNormal];
    }
    
    if ([bgColor isKindOfClass:[UIColor class]]) {
        btn.backgroundColor = bgColor;
    } else {
        btn.backgroundColor = [UIColor kjwd_blueBtnColor];
    }
    
    [btn kjwd_addTouchUpInsideForCallBack:callBack];
    return btn;
}


// runtime
- (void)setKjCallBackBlock:(void (^)(UIButton *))kjCallBackBlock {
    objc_setAssociatedObject(self, @"kjCallBackBlock", kjCallBackBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(UIButton *))kjCallBackBlock {
    void (^block)(UIButton *) = objc_getAssociatedObject(self, @"kjCallBackBlock");
    return block;
}


@end


@implementation UILabel (WDYHFCategory)


+ (instancetype)kjwd_labelWithText:(nullable NSString *)text fontSize:(nullable NSNumber *)fontSize color:(nullable UIColor *)color {
    
    UILabel *label = [[self alloc] init];
    
    if (WDKJ_IsEmpty_Str(text) == NO) {
        label.text = text;
    }
    if (WDKJ_IsNull_Num(fontSize) == NO) {
        label.font = [UIFont systemFontOfSize:fontSize.floatValue];
    }
    if (color != nil) {
        if ([color isKindOfClass:[UIColor class]]) {
            label.textColor = color;
        }
    }
    return label;
}

@end

@implementation UIScrollView (WDYHFCategory)

/**
 垂直方向添加Views
 
 @param views views数组
 @param viewHeight 每一个View的高度
 @param itemSpacing 每一个View之间的间距
 @param topSpacing 顶部间距
 @param bottomSpacing 底部间距
 @param horizontalConstraints 水平方向的约束
 
 比如
 make.left.equalTo(@10);
 make.width.equalTo(@100);
 
 */
- (void)kjwd_viewsOfVertical:(NSArray <UIView *>*)views viewHeight:(CGFloat)height itemSpacing:(CGFloat)itemSpacing topSpacing:(CGFloat)topSpacing bottomSpacing:(CGFloat)bottomSpacing horizontalConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))horizontalConstraints {
    
    if (horizontalConstraints == nil) {
        return;
    }
    
    UIView *contentView = [[UIView alloc] init];
    [self addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.width.equalTo(self);
    }];
    
    UIView *lastView = nil;
    
    
    for (int i = 0; i < views.count; i++) {
        UIView *view = views[i];
//        WDCKJBGColor_Arc4Color(view);
        [contentView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.top.equalTo(@(topSpacing));
            } else {
                make.top.equalTo(lastView.mas_bottom).offset(itemSpacing);
            }
            make.height.equalTo(@(height));
            
            horizontalConstraints(make, view.superview);
        }];
        
        lastView = view;
    }
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom).offset(bottomSpacing);
    }];
}

- (void)kjwd_viewsOfHorizontal:(NSArray <UIView *>*)views viewWidth:(CGFloat)width itemSpacing:(CGFloat)itemSpacing leftSpacing:(CGFloat)leftSpacing rightSpacing:(CGFloat)rightSpacing vorizontalConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))verticalConstraints {
    if (verticalConstraints == nil) return;
    
    UIView *contentView = [[UIView alloc] init];
    [self addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.height.equalTo(self);
    }];
    
    UIView *lastView = nil;

    for (int i = 0; i < views.count; i++) {
        UIView *view = views[i];
//        WDCKJBGColor_Arc4Color(view);
        [contentView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.equalTo(@(leftSpacing));
            } else {
                make.left.equalTo(lastView.mas_right).offset(itemSpacing);
            }
            make.width.equalTo(@(width));
            verticalConstraints(make, view.superview);
        }];
        
        lastView = view;
    }
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastView.mas_right).offset(rightSpacing);
    }];
}

@end


#pragma mark - -----------------NSDate-----------------
@implementation NSDate (WDYHFCategory)

+ ( NSString *)kjwd_format1:(NSString *_Nullable)dateStr {
    if (WDKJ_IsEmpty_Str(dateStr)) return @"";
    NSDate *date = [NSDate kjwd_returnDate:dateStr withDateFormat:CKJDateFormat4];
    NSString *result = [date kjwd_dateStringWithFormatter:CKJDateFormat2];
    return result;
}

+ (nullable NSDate *)kjwd_returnDate:(NSString *_Nullable)dateString withDateFormat:(NSString *_Nullable)format {
    if (WDKJ_IsEmpty_Str(dateString)) {
        return nil;
    }
    if (WDKJ_IsEmpty_Str(format)) {
        format = CKJDateFormat1;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

+ ( NSString *)kjwd_return_yMdWithDate:(NSString *_Nullable)dateString {
    NSDate *date = [NSDate kjwd_returnDate:dateString withDateFormat:nil];
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@", date.kjwd_year, date.kjwd_month, date.kjwd_day];
    return dateStr;
}

- ( NSDate *)kjwd_set_HmsEqualZero_Date {
    NSString *str = [NSString stringWithFormat:@"%@-%@-%@ 00:00:00", self.kjwd_year, self.kjwd_month, self.kjwd_day];
    NSDate *date = [NSDate kjwd_returnDate:str withDateFormat:nil];
    return date;
}
+ (nullable NSDate *)kjwd_set_HmsEqualZero_withYMDString:(nullable NSString *)YMDString {
    if (WDKJ_IsEmpty_Str(YMDString)) {
        return nil;
    }
    NSString *str = [NSString stringWithFormat:@"%@ 00:00:00", YMDString];
    NSDate *date = [NSDate kjwd_returnDate:str withDateFormat:nil];
    return date;
}

- ( NSString *)kjwd_dateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = [NSString stringWithFormat:CKJDateFormat1];
    NSString *dateStr = [formatter stringFromDate:self];
    return dateStr;
}
- ( NSString *)kjwd_YearMonthDayString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = [NSString stringWithFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:self];
    return dateStr;
}
- ( NSString *)kjwd_year {
    return [[self kjwd_dateString] substringToIndex:4];
}
- ( NSString *)kjwd_month {
    NSString *str = [self kjwd_dateString];
    return [NSString stringWithFormat:@"%@", [str substringWithRange:NSMakeRange(5, 2)]];
}
- ( NSString *)kjwd_day {
    NSString *str = [self kjwd_dateString];
    return [NSString stringWithFormat:@"%@", [str substringWithRange:NSMakeRange(8, 2)]];
}
- ( NSString *)kjwd_hour {
    NSString *str = [self kjwd_dateString];
    return [NSString stringWithFormat:@"%@", [str substringWithRange:NSMakeRange(11, 2)]];
}
- ( NSString *)kjwd_minute {
    NSString *str = [self kjwd_dateString];
    return [NSString stringWithFormat:@"%@", [str substringWithRange:NSMakeRange(14, 2)]];
}
- ( NSString *)kjwd_second {
    NSString *str = [self kjwd_dateString];
    return [NSString stringWithFormat:@"%@", [str substringWithRange:NSMakeRange(17, 2)]];
}
- ( NSString *)kjwd_dateStringWithFormatter:(NSString *)formatterStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatterStr;
    NSString *dateStr = [formatter stringFromDate:self];
    return dateStr;
}

/// 距离1970年的秒数
- (long long)kjwd_timeIntervalSince1970 {
    NSTimeInterval time = [self timeIntervalSince1970];
    long long dTime = [[NSNumber numberWithDouble:time] longLongValue]; // 将double转为long long型
    return dTime;
}
/// 距离1970年的毫秒数
- (long long)kjwd_timeIntervalSince1970_Milliseconds {
    return [self kjwd_timeIntervalSince1970] * 1000;
}

/**
 *  判断是否是同一天
 */
- (BOOL)kjwd_isSameDayToDate2:(NSDate *)date2 {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlag = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comp1 = [calendar components:unitFlag fromDate:self];
    NSDateComponents *comp2 = [calendar components:unitFlag fromDate:date2];
    return (([comp1 day] == [comp2 day]) && ([comp1 month] == [comp2 month]) && ([comp1 year] == [comp2 year]));
}


- ( NSDate *)kjwd_tomorrow {
    NSDate *date = [self dateByAddingTimeInterval:60 * 60 * 24];//后一天
    return date;
}
- ( NSDate *)kjwd_yesterDay {
    NSDate *date = [self dateByAddingTimeInterval:- 60 * 60 * 24];//前一天
    return date;
}
/** 明年 */
- (NSDate *)kjwd_nextyear {
    NSDate *date = [self dateByAddingTimeInterval:60 * 60 * 24 * 365];
    return date;
}
/** 去年 */
- (NSDate *)kjwd_yesterYear {
    NSDate *date = [self dateByAddingTimeInterval:- 60 * 60 * 24 * 365];//前一天
    return date;
}
+ (NSString *)kjwd_returnWordsForTime:(NSString *)str {
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

@implementation UIImage (WDYHFCategory)

+ ( UIImage *)kjwd_imageNamed:( NSString *)name {
    if (WDKJ_IsEmpty_Str(name)) {
        //        NSLog(@"kj_imageNamed 传入为nil 或为 空字符串 ---> (%@)", name);
        return [[UIImage alloc] init];
    }
    UIImage *image = [self imageNamed:name];
    if (image == nil) {
        image = [[UIImage alloc] init];
    }
    return image;
}
+ (UIImage *)kjwd_imageWithUrlStr:(nullable NSString *)urlStr {
    UIImage *empty = [[UIImage alloc] init];
    if (WDKJ_IsEmpty_Str(urlStr)) return empty;
    NSURL *url = [NSURL kjwd_URLWithString:urlStr];
    NSData *data = [NSData kjwd_dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    if (image == nil) {
        return empty;
    }
    return image;
}

// 通过给定颜色和大小生成图片
+ ( UIImage *)kjwd_imageWithColor:(UIColor *)color size:(CGSize)size {
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
    
    if (image == nil) {
        return [[UIImage alloc] init];
    }
    
    return image;
}

+ ( UIImage *)kjwd_imageWithColor:(UIColor *)color size:(CGSize)size radius:(CGFloat)radius {
    return [[self kjwd_imageWithColor:color size:size] kjwd_setCornerRadius:radius];
}

+ ( UIImage *)kjwd_QRCodeWithContent:(NSString *)content size:(CGSize)size {
    if (content == nil) {
        return [[UIImage alloc] init];
    }
    
    UIImage *codeImage = nil;
    
    NSData *stringData = [content dataUsingEncoding: NSUTF8StringEncoding];
    
    //生成
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    UIColor *onColor = [UIColor blackColor];
    UIColor *offColor = [UIColor whiteColor];
    
    //上色
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage",qrFilter.outputImage,
                             @"inputColor0",[CIColor colorWithCGColor:onColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor:offColor.CGColor],
                             nil];
    
    CIImage *qrImage = colorFilter.outputImage;
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    
    if (cgImage == nil) {
        return [[UIImage alloc] init];
    }
    
    return codeImage;
}

//改变图片的大小
- ( UIImage *)kjwd_scaleToSize:(CGSize)size {
//     这个失真
//    // 创建一个bitmap的context
//    // 并把它设置成为当前正在使用的context
//    UIGraphicsBeginImageContext(size);
//    // 绘制改变大小的图片
//    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    // 从当前context中创建一个改变大小后的图片
//    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//    // 使当前的context出堆栈
//    UIGraphicsEndImageContext();
//    // 返回新的改变大小后的图片
//    return scaledImage;
    
    
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。
    // 如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (scaledImage == nil) {
        return [[UIImage alloc] init];
    }
    
    return scaledImage;   //返回的就是已经改变的图片
}

- (UIImage *)kjwd_noTransformScaleToWidth:(NSNumber *_Nullable)newWidthNumber height:(NSNumber *_Nullable)newHeightNumber {
    
    if (WDKJ_IsNull_Num(newWidthNumber) && WDKJ_IsNull_Num(newHeightNumber)) {
        return self;
    }
   
    CGFloat oldWidth = self.size.width, oldHeight = self.size.height;
    
    if (oldWidth == 0 || oldHeight == 0) {
        return self;
    }
    
    if (newWidthNumber) {
        CGFloat newWidth = newWidthNumber.floatValue;
        if (newWidth > 0) {
            return [self kjwd_scaleToSize:CGSizeMake(newWidth, newWidth * oldHeight / oldWidth)];
        }
    }
    if (newHeightNumber) {
        CGFloat newHeight = newHeightNumber.floatValue;
        if (newHeight > 0) {
            return [self kjwd_scaleToSize:CGSizeMake(newHeight * oldWidth / oldHeight, newHeight)];
        }
    }
    return self;
}


// 这个设置圆角没有问题，radius 要设置大一些
- ( UIImage *)kjwd_setCornerRadius:(CGFloat)radius {
    UIImage *original = self;
    CGRect frame = CGRectMake(0, 0, original.size.width, original.size.height);
    // 开始一个Image的上下文
    UIGraphicsBeginImageContextWithOptions(original.size, NO, 1.0);
    // 添加圆角
    [[UIBezierPath bezierPathWithRoundedRect:frame
                                cornerRadius:radius] addClip];
    // 绘制图片
    [original drawInRect:frame];
    // 接受绘制成功的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (image == nil) {
        return [[UIImage alloc] init];
    }
    
    return image;
}
/**
 根据文字和颜色 生成图片
 @param isCircular 是否画圆
 */
+ (nullable UIImage *)kjwd_imageWithColor:(nullable UIColor *)color
                                    size:(CGSize)size
                                    text:(nullable NSString *)text
                          textAttributes:(nullable NSDictionary *)textAttributes
                                 circular:(BOOL)isCircular {
    if (size.width <= 0 || size.height <= 0) return nil;
    
    if (WDKJ_IsNullObj(color, [UIColor class])) {
        color = [UIColor blackColor];
    }
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // circular
    if (isCircular) {
        CGPathRef path = CGPathCreateWithEllipseInRect(rect, NULL);
        CGContextAddPath(context, path);
        CGContextClip(context);
        CGPathRelease(path);
    }
    
    // color
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    // text
    CGSize textSize = [text sizeWithAttributes:textAttributes];
    [text drawInRect:CGRectMake((size.width - textSize.width) / 2, (size.height - textSize.height) / 2, textSize.width, textSize.height) withAttributes:textAttributes];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



/*
 渐变色生成图片
 
 gradientType
 1. 上到下
 2. 左到右
 3. 左上到右下
 4. 右上到左下
 
 */
+ (UIImage *)kjwd_gradientColorImageFromColors:(NSArray <UIColor *>*)colors gradientType:(NSInteger)gradientType imgSize:(CGSize)imgSize {
    
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start = CGPointMake(0.0, 0.0);;
    CGPoint end = CGPointMake(0.0, 0.0);;
    switch (gradientType) {
        case 1: // 从上到下
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        case 2: // 从左到右
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, 0.0);
            break;
        case 3: // 左上到右下
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, imgSize.height);
            break;
        case 4: // 右上到左下
            start = CGPointMake(imgSize.width, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end,kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

@end


#pragma mark - -----------------NSPredicate-----------------

@implementation NSPredicate (WDYHFCategory)

+ (BOOL)kjwd_validateRegexStr:(nullable NSString *)regexStr targetStr:(nullable NSString *)targetStr {
    if (WDKJ_IsEmpty_Str(regexStr)) return NO;
    if (WDKJ_IsEmpty_Str(targetStr)) return NO;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexStr];
    return [predicate evaluateWithObject:targetStr];
}

@end

#pragma mark - -----------------NSString-----------------

@implementation NSString (WDYHFCategory)

+ ( NSString *)guidWithType:(KJWDArc4randomType)type {
//    fb40c1f2-520c-45f4-96e6-ff5495606590
    NSString *one = [NSString kjwd_returnArc4randomWithNum:8 type:type];
    NSString *two = [NSString kjwd_returnArc4randomWithNum:4 type:type];
    NSString *three = [NSString kjwd_returnArc4randomWithNum:4 type:type];
    NSString *four = [NSString kjwd_returnArc4randomWithNum:4 type:type];
    NSString *five = [NSString kjwd_returnArc4randomWithNum:12 type:type];
    NSString *result = [NSString stringWithFormat:@"%@-%@-%@-%@-%@", one, two, three, four, five];
    return result;
}

//邮箱
- (BOOL)kjwd_validateEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/// 手机号码验证
- (BOOL)kjwd_varityPhoneSuccess {
    NSString *phone = @"^(1)\\d{10}$";
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phone];
    return [regextestcm evaluateWithObject:self];
}

/// 默认左3位  右2位， *6位， 比如  177******94
- ( NSString *)kjwd_Phone_defaultStar {
    return [self kjwd_PhoneLeftMargin:3 rightMargin:2 starNumber:6];
}

/** 手机号 左右各保留几位， 比如左3位  右2位， *6位，  177******94 */
- ( NSString *)kjwd_PhoneLeftMargin:(NSInteger)left rightMargin:(NSInteger)right starNumber:(NSInteger)starNumber {
    
    NSString *defaultStr = @"";
    
    if (self.length != 11) return defaultStr;
    
    if (left < 0 || left >= self.length) {
        return defaultStr;
    }
    if (right < 0 || right >= self.length) {
        return defaultStr;
    }
    if (left + right > self.length) {
        return defaultStr;
    }
    
    NSMutableString *star = [NSMutableString string];
    for (int i = 0; i < starNumber; i++) {
        [star appendString:@"*"];
    }
    
    NSInteger len = self.length - right - left;
    
    NSString *result = [self stringByReplacingCharactersInRange:NSMakeRange(left, len) withString:star];
    
    return result;
}

//车牌号验证
- (BOOL)kjwd_validateCarNo {
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:self];
}

//车型
- (BOOL)kjwd_validateCarType {
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:self];
}

//用户名
- (BOOL)kjwd_validateUserName {
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:self];
    return B;
}

/**
 * 密码
 * 说明 必须同时包含大写、小写、字母，这样的组合
 * 参数 min, 最少位
 * 参数 max, 最大位
 */
- (BOOL)kjwd_validatePasswordWithMin:(unsigned int)min max:(unsigned int)max {
    NSString *passWordRegex = [NSString stringWithFormat:@"^(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9]{%u,%u}$", min, max];
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}

/**
 * 昵称
 * 说明 以中文开头, 默认4-8位
 * 参数 min, 最少位
 * 参数 max, 最大位
 */
- (BOOL)kjwd_validateNicknameWithMin:(unsigned int)min max:(unsigned int)max {
    NSString *nicknameRegex = [NSString stringWithFormat:@"^[\u4e00-\u9fa5]{%u,%u}$", min, max];
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:self];
}

//身份证号
- (BOOL)kjwd_validateIdentityCard {
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
 * 说明 纯数字验证码, 默认6位
 * 参数 size, 位数
 */
- (BOOL)kjwd_validateVerifyCode {
    NSString *verifyCodeRegex = @"^[0-9]{6}$";
    NSPredicate *verifyPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",verifyCodeRegex];
    return [verifyPredicate evaluateWithObject:self];
}
- (BOOL)kjwd_validateVerifyCodeWithSize:(unsigned int)size {
    NSString *verifyCodeRegex = [NSString stringWithFormat:@"^[0-9]{%d}$", size];
    NSPredicate *verifyPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",verifyCodeRegex];
    return [verifyPredicate evaluateWithObject:self];
}


/** 是否全是数字 */
- (BOOL)kjwd_isNumber {
    if (self.length == 0) return NO;
    NSString *regex =@"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:self];
}

/** 是否全是大写或数字 */
- (BOOL)kjwd_inputShouldUpperAndNumber {
    if (self.length == 0) return NO;
    NSString *regex =@"[A-Z0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:self];
}

/** 是否全是字母或数字 */
- (BOOL)kjwd_isCharAndNumber {
    if (self.length == 0) return NO;
    NSString *regex =@"[A-Za-z0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:self];
}


/** 是否包含大写字母 */
- (BOOL)kjwd_containsUppercase {
    
    // 限制 不能输入的特殊字符串
    NSCharacterSet *cs = nil;
    
    cs = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ"] invertedSet];
    
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    BOOL basicTest = [self containsString:filtered];
    return basicTest;
}
/** 是否包含小写字母 */
- (BOOL)kjwd_containsLowercase {
    
    // 限制 不能输入的特殊字符串
    NSCharacterSet *cs = nil;
    
    cs = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyz"] invertedSet];
    
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    BOOL basicTest = [self containsString:filtered];
    return basicTest;
}
/** 是否包含数字 */
- (BOOL)kjwd_containsNumber {
    
    // 限制 不能输入的特殊字符串
    NSCharacterSet *cs = nil;
    
    cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    BOOL basicTest = [self containsString:filtered];
    return basicTest;
}

/// 身份证号 年月日转为*号
- ( NSString *)kjwd_idCardToAsterisk {
    if (self.length != 18) { // NSLog(@"身份证号必须是18位!");
        return @"";
    }
    return [self stringByReplacingCharactersInRange:NSMakeRange(10, 4) withString:@"****"];
}

/// 返回身份证号的年月日,  比如 19980320
- ( NSString *)kjwd_idCardBirthday {
    if (self.length != 18) return @"";
    NSString *birthday = [self kjwd_substringWithRange:NSMakeRange(6, 8)];
    if (WDKJ_IsEmpty_Str(birthday)) {
        return @"";
    }
    return birthday;
}
- ( NSString *)kjwd_idCardBirthday2 {
    NSString *temp = [self kjwd_idCardBirthday];
    if (WDKJ_IsEmpty_Str(temp)) {
        return @"";
    }
    return [NSDate kjwd_format1:temp];
}

/// 返回身份证号的年  比如 1998
- ( NSString *)kjwd_idCardBirthday_Year {
    NSString *result = [[self kjwd_idCardBirthday] kjwd_substringToIndex:4];
    if (WDKJ_IsEmpty_Str(result)) {
        return @"";
    }
    return result;
}

/** 身份证号 左右各保留3位， 452************026 */
- (NSString *)kjwd_idCard_defaultStar {
    return [self kjwd_idCardLeftMargin:3 rightMargin:3];
}

- ( NSString *)kjwd_idCardLeftMargin:(NSInteger)left rightMargin:(NSInteger)right {
    NSInteger idLength = 18;
    
    NSString *defaultStr = @"";
    
    if (self.length != idLength) {
        //        NSLog(@"身份证号必须是18位!");
        return defaultStr;
    }
    if (left < 0 || right < 0) {
        return defaultStr;
    }
    if (left + right > idLength) {
        return defaultStr;
    }
    
    NSMutableString *chars = [NSMutableString string];
    for (int i = 0; i < idLength - right - left; i++) {
        [chars appendString:@"*"];
    }
    
    NSMutableString *str = [NSMutableString stringWithString:self];
    
    NSString *temp = [str stringByReplacingCharactersInRange:NSMakeRange(left, idLength - right - left) withString:chars];
    
    return temp;
}

/// 获取身份证上的性别
- (NSString *)kjwd_idCard_GetSex {
    if (self.length == 18) {  //获取18位 二代身份证  性别
        int sexInt = [[self substringWithRange:NSMakeRange(16, 1)] intValue];
        if(sexInt % 2 != 0) {  // 1
            return @"男";
        } else {  // 2
            return @"女";
        }
    } else if (self.length == 15) {  //获取15位 一代身份证  性别
        int sexInt = [[self substringWithRange:NSMakeRange(14,1)] intValue];
        
        if(sexInt % 2 != 0) {  // 1
            return @"男";
        } else {  // 2
            return @"女";
        }
    }
    return @"";
}

/// 获取身份证上的年龄
- (NSString *)kjwd_idCard_GetAge {
    
    NSString *birthday_year = [self kjwd_idCardBirthday_Year];
    
    int result = [[NSDate date] kjwd_year].intValue - birthday_year.intValue;
    if (result >= 0) {
        return [NSString stringWithFormat:@"%d", result];
    } else {
        return @"";
    }
}


/**
 * MD5加密
 * 说明 MD5是消息摘要算法
 * 返回 16位字符串类型的 MD5 hash值
 */
- (NSString *)kjwd_MD5 {
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
- (NSString *)kjwd_trimWhiteAndNewline {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
// 过滤首尾的空格
- (NSString *)kjwd_trimWhite {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

// 过滤所有的空格和换行
- (NSString *)kjwd_trimAllWhiteAndNewline {
    NSString *result = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return [result stringByReplacingOccurrencesOfString:@"\r" withString:@""];
}
// 过滤所有的空格
- (NSString *)kjwd_trimAllWhite {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

+ (NSString *)kjwd_uuidString {
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

+ (NSString *)__privateMethod__returnSource:(KJWDArc4randomType)type {
    NSString *sourceStr = nil;
    switch (type) {
        case KJWDArc4randomType_Number:
            sourceStr = @"0123456789";
            break;
        case KJWDArc4randomType_Number_Up_Low_Char:
            sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
            break;
        case KJWDArc4randomType_Up_Char:
            sourceStr = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            break;
        case KJWDArc4randomType_Low_Char:
            sourceStr = @"abcdefghijklmnopqrstuvwxyz";
            break;
        case KJWDArc4randomType_Number_Low_Char:
            sourceStr = @"0123456789abcdefghijklmnopqrstuvwxyz";
            break;
        case KJWDArc4randomType_Number_Up_Char:
            sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            break;
        default:
            break;
    }
    return sourceStr;
}

/**
 *  这个在时间很短时， 得到多个随机数， 可能得到的随机数是相同的
 */
+ ( NSString *)kjwd_returnGetArc4randomWithNum:(NSUInteger)num type:(KJWDArc4randomType)type {
    NSString *sourceStr = [self __privateMethod__returnSource:type];
    
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < num; i++) {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

+ (NSString *)kjwd_returnArc4randomWithNum:(NSUInteger)num type:(KJWDArc4randomType)type {
    NSString *sourceStr = [self __privateMethod__returnSource:type];
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    for (int i = 0; i < num; i++) {
        unsigned index = arc4random() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

+ ( NSString *)kjwd_returnJsonStrFromDic:(NSDictionary *_Nullable)dic {
    if (WDKJ_IsNullObj(dic, [NSDictionary class])) {
        return @"";
    }
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    if (jsonData == nil) {
        return @"";
    }
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSString *)kjwd_arrayStringWithStringArray:(NSArray *)array {
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
- (nullable NSString *)kjwd_substringFromIndex:(NSUInteger)from {
    if (from > self.length || from < 0) {
        NSLog(@"%s ---> %@ 长度%lu 下标%lu越界", __func__, self, (unsigned long)self.length, from);
        return nil;
    }
    return [self substringFromIndex:from];
}
- (nullable NSString *)kjwd_substringToIndex:(NSUInteger)to {
    if (to > self.length || to < 0) {
        NSLog(@"%s ---> %@ 长度%lu 下标%lu越界", __func__, self, (unsigned long)self.length, to);
        return nil;
    }
    return [self substringToIndex:to];
}

- (nullable NSString *)kjwd_substringWithRange:(NSRange)range {
    NSUInteger location = range.location;
    NSUInteger length = range.length;
    if (location > self.length || location < 0 || length > self.length || length < 0) {
        NSLog(@"%s ---> range的location 或 length 不符合规范 %@,  字符串(%@)长度是%lu", __func__, NSStringFromRange(range), self, (unsigned long)self.length);
        return nil;
    }
    if (location + length > self.length) {
        NSLog(@"%s ---> %@ 越界,  字符串(%@)长度是%lu", __func__, NSStringFromRange(range), self, (unsigned long)self.length);
        return nil;
    }
    return [self substringWithRange:range];
}
- (nullable NSString *)kjwd_stringByAppendingString:(nullable NSString *)aString {
    if ([aString isKindOfClass:[NSString class]] == NO || aString == nil) {
        NSLog(@"不能拼接一个空字符串 或者 非NSString类型 %@ ", aString);
        return self;
    }
    return [self stringByAppendingString:aString];
}

- (nullable NSString *)kjwd_stringByReplacingCharactersInRange:(NSRange)range withString:(nullable NSString *)replacement {
    if ([replacement isKindOfClass:[NSString class]] == NO || replacement == nil) {
        return nil;
    }
    NSUInteger location = range.location;
    NSUInteger length = range.length;
    if (location > self.length || location < 0 || length > self.length || length < 0) {
        NSLog(@"%s ---> range的location 或 length 不符合规范 %@,  字符串(%@)长度是%lu", __func__, NSStringFromRange(range), self, (unsigned long)self.length);
        return nil;
    }
    
    if (location + length > self.length) {
        NSLog(@"%s ---> %@ 越界,  字符串(%@)长度是%lu", __func__, NSStringFromRange(range), self, (unsigned long)self.length);
        return nil;
    }
    return [self stringByReplacingCharactersInRange:range withString:replacement];
}


- ( NSString *)kjwd_BeiReplace:( NSArray <NSString *>*)beiReplace toStr:( NSString *)toStr {
    NSString *result = self;
    for (NSString *bei in beiReplace) {
        result = [result stringByReplacingOccurrencesOfString:bei withString:toStr];
    }
    return result;
}


//  NSRegularExpressionCaseInsensitive             = 1 << 0, //不区分字母大小写的模式
//  NSRegularExpressionAllowCommentsAndWhitespace  = 1 << 1, //忽略掉正则表达式中的空格和#号之后的字符
//  NSRegularExpressionIgnoreMetacharacters        = 1 << 2, //将正则表达式整体作为字符串处理。表达式 a b c 会匹配到abc，ab#c会匹配到ab。
//  NSRegularExpressionDotMatchesLineSeparators    = 1 << 3, //允许.匹配任何字符，包括换行符
//  NSRegularExpressionAnchorsMatchLines           = 1 << 4, //允许^和$符号匹配行的开头和结尾
//  NSRegularExpressionUseUnixLineSeparators       = 1 << 5, //设置\n为唯一的行分隔符，否则所有的都有效。
//  NSRegularExpressionUseUnicodeWordBoundaries    = 1 << 6 //使用Unicode TR#29标准作为词的边界，否则所有传统正则表达式的词边界都有效

/*
 例子
 NSString *originStr = cookie;
 NSMutableArray <NSString *>*reg_result = [NSMutableArray array];
 [[originStr kjwd_searchWithRegularExpression:regexStr options:NSRegularExpressionCaseInsensitive] enumerateObjectsUsingBlock:^(NSTextCheckingResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
     NSRange range = [obj rangeAtIndex:2];
     NSString *temp = [originStr substringWithRange:range];
     [reg_result addObject:temp];
 }];
 NSLog(@"%@   ",     reg_result);
 */
- (NSArray <NSTextCheckingResult *>*)kjwd_searchWithRegularExpression:(NSString *)reg options:(NSRegularExpressionOptions)options {
    // 一般传 NSRegularExpressionCaseInsensitive 不区分字母大小写
    if (WDKJ_IsNullObj(reg, [NSString class])) {
        return @[];
    }
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:reg options:options error:&error];
    if (error) {
        NSLog(@"使用正则筛选字符串有误， 错误信息：%@   ", error);
        return @[];
    }
    NSArray <NSTextCheckingResult *>*matches = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    return matches;
}

- (NSArray <NSString *>*)kjwd_general_searchWithReg:(NSString *)reg options:(NSRegularExpressionOptions)options {
    NSMutableArray <NSString *>*result = [NSMutableArray array];
    NSArray *regRes = [self kjwd_searchWithRegularExpression:reg options:options];
    for (int i = 0; i < regRes.count; i++) {
        NSTextCheckingResult *temp = regRes[i];
        NSRange range = temp.range;
        //从原文本中将字段取出并存入一个NSMutableArray中
        [result addObject:[self substringWithRange:range]];
    }
    return result;
}


/*
 NSArray <NSString *>*result = [originStr kjwd_general_searchWithRegularExpression:@"(.*)小时(.*)分钟" options:NSRegularExpressionCaseInsensitive].firstObject;

 if (result.count) {
     NSString *hour = [result kjwd_objectAtIndex:0];
     NSString *minute = [result kjwd_objectAtIndex:1];
 }
*/
- (NSArray <NSArray <NSString *>*>*)kjwd_group_searchWithReg:(NSString *)reg options:(NSRegularExpressionOptions)options {
    NSString *originStr = self;
    NSMutableArray <NSArray <NSString *>*>*section_reg_result = [NSMutableArray array];
    [[originStr kjwd_searchWithRegularExpression:reg options:options] enumerateObjectsUsingBlock:^(NSTextCheckingResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray <NSString *>*cell_reg_result = [NSMutableArray array];
        for (int i = 1; i < obj.numberOfRanges; i++) {
            NSRange range = [obj rangeAtIndex:i];
            NSString *temp = [originStr substringWithRange:range];
            [cell_reg_result addObject:temp];
        }
        [section_reg_result addObject:cell_reg_result];
    }];
    return section_reg_result;
}


//--------- runtime
- (void)setKjwd_helperNumber:(CGFloat)kjwd_helperNumber {
    objc_setAssociatedObject(self, @"kjwd_helperNumber", @(kjwd_helperNumber), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)kjwd_helperNumber {
    NSNumber *number = objc_getAssociatedObject(self, @"kjwd_helperNumber");
    return number.floatValue;
}


@end


#pragma mark - -----------------NSMutableAttributedString-----------------
@implementation NSMutableAttributedString (WDYHFCategory)

- (NSMutableAttributedString *)kjwd_append:(NSAttributedString *_Nullable)att {
    if (!WDKJ_IsNullObj(att, [NSAttributedString class])) {
        [self appendAttributedString:att];
    }
    return self;
}

@end

#pragma mark - -----------------NSDecimalNumber-----------------
@implementation NSDecimalNumber (WDYHFCategory)

+ (instancetype)kjwd_confirmDecimalNumberWithString:(nullable NSString *)string {
    NSDecimalNumber *tempNumber = [[NSDecimalNumber alloc] initWithString:string];
    if ([tempNumber isEqualToNumber:[NSDecimalNumber notANumber]]) {
        return [NSDecimalNumber zero];
    } else {
        return tempNumber;
    }
}

@end

@implementation CALayer (WDYHFCategory)


- (void)kjwd_pauseAnimation {
    if (self.speed == 0.0) {
        return;
    }
    CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed = 0.0;
    self.timeOffset = pausedTime;
}

- (void)kjwd_goonAnimation {
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


@interface CKJCountDownButton(){
    NSInteger _second;
    NSUInteger _totalSecond;
    
    NSTimer *_timer;
    NSDate *_startDate;
    
    CountDownChanging _countDownChanging;
    CountDownFinished _countDownFinished;
    TouchedCountDownButtonHandler _touchedCountDownButtonHandler;
}
@end

@implementation CKJCountDownButton
#pragma -mark touche action
- (void)countDownButtonHandler:(TouchedCountDownButtonHandler)touchedCountDownButtonHandler{
    _touchedCountDownButtonHandler = [touchedCountDownButtonHandler copy];
    [self addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touched:(CKJCountDownButton*)sender{
    if (_touchedCountDownButtonHandler) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _touchedCountDownButtonHandler(sender,sender.tag);
        });
    }
}

#pragma -mark count down method
- (void)startCountDownWithSecond:(NSUInteger)totalSecond
{
    _totalSecond = totalSecond;
    _second = totalSecond;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
    _startDate = [NSDate date];
    _timer.fireDate = [NSDate distantPast];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)timerStart:(NSTimer *)theTimer {
    double deltaTime = [[NSDate date] timeIntervalSinceDate:_startDate];
    
    _second = _totalSecond - (NSInteger)(deltaTime+0.5) ;
    
    if (_second < 0.0)
    {
        [self stopCountDown];
    }
    else
    {
        if (_countDownChanging)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *title = _countDownChanging(self,_second);
                [self setTitle:title forState:UIControlStateNormal];
                [self setTitle:title forState:UIControlStateDisabled];
            });
        }
        else
        {
            NSString *title = [NSString stringWithFormat:@"%zd秒",_second];
            [self setTitle:title forState:UIControlStateNormal];
            [self setTitle:title forState:UIControlStateDisabled];
            
        }
    }
}

- (void)stopCountDown{
    if (_timer) {
        if ([_timer respondsToSelector:@selector(isValid)])
        {
            if ([_timer isValid])
            {
                [_timer invalidate];
                _second = _totalSecond;
                if (_countDownFinished)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString *title = _countDownFinished(self,_totalSecond);
                        [self setTitle:title forState:UIControlStateNormal];
                        [self setTitle:title forState:UIControlStateDisabled];
                    });
                }
                else
                {
                    [self setTitle:@"重新获取" forState:UIControlStateNormal];
                    [self setTitle:@"重新获取" forState:UIControlStateDisabled];
                    
                }
            }
        }
    }
}
#pragma -mark block
- (void)countDownChanging:(CountDownChanging)countDownChanging{
    _countDownChanging = [countDownChanging copy];
}
- (void)countDownFinished:(CountDownFinished)countDownFinished{
    _countDownFinished = [countDownFinished copy];
}
@end


#pragma mark - -----------------其他部分-----------------
@implementation CKJOriginalObject

- (instancetype)initWithBlock:(void (^)(void))block {
    self = [super init];
    if (self) {
        self.block = block;
    }
    return self;
}
- (void)dealloc {
    self.block ? self.block() : nil;
}

@end

@implementation CKJAPPHelper


+ (NSString *)currentVersion {
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    return appVersion;
}

/// buildVersion
+ (NSString *)currentBuildVersion {
    NSString *buildVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    return buildVersion;
}

+ (NSString *)bundleId {
    NSString *result = [[NSBundle mainBundle]bundleIdentifier];
    return result;
}

+ (CGFloat)screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}
+ (CGFloat)screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}
+ (NSString *)kjwd_documentPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = paths.firstObject;
    if (WDKJ_IsEmpty_Str(documentPath)) {
        return @"";
    }
    //使用  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] 得到的是 /Users/apple/Library/Application Support/iPhone Simulator/4.3/Applications/550AF26D-174B-42E6-881B-B7499FAA32B7/Documents
    
    //使用NSHomeDirectory() 得到的是 /Users/apple/Library/Application Support/iPhone Simulator/4.3/Applications/550AF26D-174B-42E6-881B-B7499FAA32B7
    return documentPath;
}

#pragma mark - Swift命名空间相关
+ ( NSString *)kj_nameSpace {
    NSString *namespace = [NSBundle mainBundle].infoDictionary[@"CFBundleExecutable"];
    namespace = [NSString stringWithFormat:@"%@.", namespace];
    return namespace;
}
+ ( NSString *)return_ModelName:(NSString *)modelName {
    if ([modelName containsString:[self kj_nameSpace]]) { // 为了Swift处理命名空间
        NSUInteger from = [modelName rangeOfString:[self kj_nameSpace]].length;
        modelName = [modelName substringFromIndex:from];
    }
    return modelName;
}
+ (Class)returnClass_ClassString:(NSString *)classString {
    // 为了Swift处理命名空间
    Class ocClass = NSClassFromString(classString);
    Class swiftClass = NSClassFromString([NSString stringWithFormat:@"%@%@", [self kj_nameSpace], classString]);
    return ocClass ? ocClass : swiftClass;
}


@end




//@interface CKJPrivateClass : NSObject
//
//@end
//
//@implementation CKJPrivateClass
//
//+ (NSString *)returnSource:(KJWDArc4randomType)type {
//    NSString *sourceStr = nil;
//    switch (type) {
//        case KJWDArc4randomType_Number:
//            sourceStr = @"0123456789";
//            break;
//        case KJWDArc4randomType_Number_Up_Low_Char:
//            sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
//            break;
//        case KJWDArc4randomType_Up_Char:
//            sourceStr = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
//            break;
//        case KJWDArc4randomType_Low_Char:
//            sourceStr = @"abcdefghijklmnopqrstuvwxyz";
//            break;
//        case KJWDArc4randomType_Number_Low_Char:
//            sourceStr = @"0123456789abcdefghijklmnopqrstuvwxyz";
//            break;
//        case KJWDArc4randomType_Number_Up_Char:
//            sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
//            break;
//        default:
//            break;
//    }
//    return sourceStr;
//}
//
//@end
