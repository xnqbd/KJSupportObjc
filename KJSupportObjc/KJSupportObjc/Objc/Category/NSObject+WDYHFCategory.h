//
//  WDYHFCategory.h
//  KJProduct
//
//  Created by uback on 2018/3/19.
//  Copyright © 2018年 uback. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>






typedef NS_ENUM(NSInteger, KJWDArc4randomType) {
    /**
     *  0-9
     */
    KJWDArc4randomType_Number,
    /**
     *  0-9 和 a-z A-Z
     */
    KJWDArc4randomType_Number_Up_Low_Char,
    
    /**
     *  A_Z
     */
    KJWDArc4randomType_Up_Char,
    
    /**
     *  a-z
     */
    KJWDArc4randomType_Low_Char,
    
    /**
     *  0-9 和 a-z
     */
    KJWDArc4randomType_Number_Low_Char,
    /**
     *  0-9 和 A-Z
     */
    KJWDArc4randomType_Number_Up_Char
};



NS_ASSUME_NONNULL_BEGIN

@class MASViewAttribute, MASConstraintMaker;

#pragma mark - -----------------异常处理-----------------
BOOL WDKJ_IsNullObj(id obj, Class cla);
BOOL WDKJ_IsEmpty_Str(NSString *_Nullable str);
BOOL WDKJ_IsEmpty_AttributedStr(NSAttributedString *_Nullable attStr);

BOOL WDKJ_IsNull_Num(NSNumber *_Nullable number);
BOOL WDKJ_IsNull_Array(NSArray *_Nullable array);

NSString *WDKJ_SpaceString(NSString *_Nullable str);
NSString *WDKJ_ConfirmString(NSString *_Nullable str);
NSAttributedString *WDKJ_SpaceAttString(NSAttributedString *_Nullable attStr);
NSAttributedString *WDKJ_ConfirmAttString(NSAttributedString *_Nullable attStr);
NSNumber *WDKJ_ConfirmNumber(NSNumber *_Nullable number);
NSDictionary *WDKJ_ConfirmDic(NSDictionary *_Nullable dic);
NSArray *WDKJ_ConfirmArray(NSArray *_Nullable array);

BOOL WDKJ_IsNull_NumberOrString(id numberOrString);
/**
 比较字符串 是否相同 (网络上取到的数据)

 @param numberOrString 目标
 @param myStr 我的
 @return 是否相同
 */
BOOL WDKJ_CompareNumberOrString(id numberOrString, NSString *_myStr);


#pragma mark - -----------------其他-----------------


NSString *WDKJ_Sex(NSNumber *sex);

NSMutableAttributedString *WDCKJAttributed(NSString *_Nullable name, NSDictionary *_Nullable dic);
NSMutableAttributedString *WDCKJAttributed2(NSString *_Nullable text, UIColor *_Nullable color, id _Nullable fontSize);
NSMutableAttributedString * WDAttTitle(NSString *_Nullable text);
NSMutableAttributedString * WDAttTitle14(NSString *_Nullable text);
NSMutableAttributedString * WDAttSubTitle(NSString *_Nullable text);
NSMutableAttributedString * WDAttSubTitle14(NSString *_Nullable text);
NSMutableAttributedString *WDAtt13(NSString *_Nullable name);
NSMutableAttributedString *WDAtt15_5(NSString *_Nullable name);


/**
 设置间距AttributedString

 @param text 文本
 @param horizontalSpace 文字水平之间间距
 @param lineSpace 垂直行之间间距
 @param color 颜色
 @param fontSize 大小
 @return 实例化对象
 */
NSMutableAttributedString *WDCKJAttributed3(NSString *_Nullable text, CGFloat horizontalSpace, CGFloat lineSpace, UIColor *_Nullable color, NSNumber *_Nullable fontSize);

/**
 拼接
 */
NSMutableAttributedString *WDCKJAttAppend(NSString *_Nullable text1, UIColor *_Nullable color1, NSNumber *_Nullable fontSize1, NSString *_Nullable text2, UIColor *_Nullable color2, NSNumber *_Nullable fontSize2);


/**
 加粗
 */
NSMutableAttributedString *WDCKJAttBold(NSString *_Nullable text, UIColor *_Nullable color, NSNumber *_Nullable fontSize);

/**
 添加附件 (图片在前，文字在后)
 */
NSMutableAttributedString *WDCKJAttributed6(CGRect bounds, UIImage *_Nullable image, NSString *_Nullable text, UIColor *_Nullable color, NSNumber *_Nullable fontSize);



int getRandomNumber(int from, int to);


void WDCKJdispatch_async_main_queue(void(^block)(void));

void WDCKJBGColor_Arc4Color(UIView *view);

void WDCKJ_ifDEBUG(void(^_Nullable debugBlock)(void), void(^_Nullable releaseBlock)(void));


CGFloat WDAPP_ScreenWidth(void);
CGFloat WDAPP_ScreenHeight(void);


@interface UIWindow (WDYHFCategory)

+ (UIWindow *)kjwd_appdelegateWindow;

@end

@interface NSObject (WDYHFCategory)

/*
 让一段代码在一段时间内只能执行一次， 这个方法就算很频繁执行， 但在指定时间内block中的代码也只会执行一次
 */
- (void)kjwd_executedOnceInTimeInterval:(NSTimeInterval)timeInterval block:(void(^)(void))block;


- (void)kjwd_setValuesForKeysWithDictionary:(nullable NSDictionary<NSString *, id> *)keyedValues;

@end

@interface NSNull (WDYHFCategory)

@end

#pragma mark - -----------------NSData-----------------
@interface NSData (WDYHFCategory)

- (NSString *)kjwd_utf8String;
+ (instancetype)kjwd_dataWithContentsOfURL:(id)url;

@end


#pragma mark - -----------------NSTimer-----------------
@interface NSTimer (Category)

/**
 进入后台会停止, 进入前台会重新启动
 */
+ (NSTimer *)kjwd_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats nowPerform:(BOOL)boo handleBlockOnMainQueue:(void(^)(NSTimer *_currentTimer))block;

@end




#pragma mark - -----------------NSArray-----------------
@interface NSArray <__covariant ObjectType> (WDYHFCategory)



+ (NSArray *)kjwd_readJsonDataFromLocalWithName:(nullable NSString *)name type:(nullable NSString *)type;


/**
 根据 数组元素 属性值相同 重组数组

 
 @param propertyName 属性名
 @param handle 回调  (data 和 propertyValueSortedSet 个数是相等的)
 */
- (void)kjwd_DoElementPropertyValueEqualWithPropertyName:(NSString *_Nullable)propertyName handle:(void(^_Nullable)(NSMutableArray <NSArray <ObjectType>*>*_data, NSArray <NSString *>*_propertyValueSortedSet))handle;


/**
 根据一个过滤条件，遍历数组元素

 @param conformBlock 过滤条件
 @param handle 回调
 */
- (void)kjwd_do_conformBlock:(BOOL(^)(ObjectType obj, NSUInteger idx))conformBlock handle:(void(^)(BOOL isConform, ObjectType obj, NSUInteger idx))handle;
/**
 根据一个过滤条件，符合条件的加入到新数组里返回

 @param filterBlock 过滤条件
 @return 符合条件的新数组
 */
- (NSArray<ObjectType> *)kjwd_do_filter_returnConformNewArray:(BOOL (^)(ObjectType objc))filterBlock;

/**
 根据一个过滤条件，返回符合条件的元素

 @param filterBlock 过滤条件
 @return 符合条件的元素
 */
- (nullable ObjectType)kjwd_do_filter_returnConformObject:(BOOL (^)(ObjectType objc))filterBlock;
/**
 根据一个过滤条件，返回符合条件的元素下标（如果没有符合的，就返回nil）
 
 @param filterBlock 过滤条件
 @return 符合条件的元素下标
 */
- (nullable NSNumber *)kjwd_do_filter_returnConformIndex:(BOOL (^)(ObjectType objc))filterBlock;


- (ObjectType)kjwd_objectAtIndex:(NSUInteger)index;

- (nullable NSNumber *)kjwd_indexOfObject:(nullable ObjectType)anObject;




/**
 反转数组，第一个元素变成最后一个元素，最后一个元素变成第一个元素，（数组里的每个元素还是同一个对象）
 */
- (NSArray *)kjwd_reverseArray;

/**
 逆向遍历数组， 一般用在移除元素
 */
- (void)kjwd_reverseEnumerateObjectsUsingBlock:(void (NS_NOESCAPE ^)(ObjectType obj, NSUInteger idx, BOOL *stop))block;


/**
 返回c, k, j  这样的字符串
 */
- (NSString *)kjwd_arrayString;


/// 传入["0", "5", "8"] 返回 "058"
- (NSString *)kjwd_stringValue;

/**
 必须保证元素的NSNumber类型

 @return 返回NSIndexSet的值
 */
- (NSIndexSet *)kjwd_indexSetValue;

/**
 从0到数组个数 的数组

 @return 下标数组
 */
- (NSArray <NSNumber *>*)kjwd_indexArray;


/**
 合并
 */
- (NSMutableArray *)kjwd_mergeArray:(NSArray *_Nullable)otherArray;

/**
 交集

 @param array 另外一个数组
 @return 返回集合，无序的
 */
- (NSSet *)kjwd_intersectWithArray:(NSArray<ObjectType> *)array;

/**
 查看值的数据类型
 */
- (void)kjwd_lookValuesDataType;
    
- (NSArray *)kjwd_filteredArrayUsingPredicate:(NSString *_Nullable)predicate;

@end

#pragma mark - -----------------NSMutableArray-----------------
// 关于NSMutableArray线程安全的思考和实现 http://blog.csdn.net/kongdeqin/article/details/53171189
@interface NSMutableArray <ObjectType> (WDYHFCategory)

+ (instancetype)kjwd_enumTo:(NSUInteger)to returnItemBlock:(id(^_Nonnull)(NSUInteger i))callBack;
+ (instancetype)kjwd_enumFrom:(NSUInteger)from to:(NSUInteger)to returnItemBlock:(id(^_Nonnull)(NSUInteger i))callBack;


+ (instancetype)kjwd_arrayWithArray:(nullable NSArray<ObjectType> *)array;

- (BOOL)kjwd_addObject:(ObjectType)object;

- (BOOL)kjwd_addObjectsFromArray:(NSArray<ObjectType> *)array;


/**
 比原生的能做到，插入到最后一行
 */
- (BOOL)kjwd_insertObject:(ObjectType)object atIndex:(NSUInteger)index;

- (BOOL)kjwd_insertObjects:(nullable NSArray<ObjectType> *)objects atIndex:(NSUInteger)index;

- (BOOL)kjwd_removeObjectAtIndex:(NSUInteger)index;

/**
 安全删除某一行，尤其用于一边遍历，一遍删除数组的元素，这个很安全,  (但是要注意：想要删除一定要逆序遍历)
 */
- (void)kjwd_safeRemoveObjectAtIndex:(NSUInteger)index;





/**
 删除指定下标数组的元素
 */
- (void)kjwd_removeAllObjects_IncludedRows:(NSArray <NSNumber *>*)includedRows;

/**
 删除除了 指定下标数组 以外的全部元素
 */
- (void)kjwd_removeAllObjects_notIncludedRows:(NSArray <NSNumber *>*)notIncludedRows;


/**
 返回你不想删除的Rows下标数组 以外的IndexSet

 @param notIncludedRows 你不想删除的Rows下标数组
 @return 返回你不想删除的Rows下标 以外的IndexSet
 */
- (NSIndexSet *)kjwd_returnIndexSet_notIncludedRowsOfYou:(NSArray <NSNumber *>*)notIncludedRows;
/**
 返回你想删除的Rows下标数组 的IndexSet
 
 @param includedRows 你想删除的Rows下标数组
 @return 返回你想删除的Rows下标 的IndexSet
 */
- (NSIndexSet *)kjwd_returnIndexSet_IncludedRowsOfYou:(NSArray <NSNumber *>*)includedRows;

/**
 *  当向数组里的第一个位置插入数据时， 建议用这个
 */
- (BOOL)kjwd_insertAt_FirstIndex_Of_Object:(ObjectType)object;

- (BOOL)kjwd_replaceObjectAtIndex:(NSUInteger)index withObject:(ObjectType)object;

    
/**
 字典转模型
 */
+ (instancetype)kjwd_arrayWithKeyValuesArray:(NSArray <NSDictionary *>* _Nullable)keyValuesArray modelClass:(Class)ModelClass callBack:(void(^_Nullable )(id _currentModel))callBack;

@end

#pragma mark - -----------------NSDictionary-----------------
@interface NSDictionary (WDYHFCategory)

/**
 *  转成JSON格式的字符串， 有空格和换行    类似这样子  {"return_msg" : "响应成功"}
 */
- (NSString *)kjwd_returnJsonString;
/**
 *  转成JSON格式的字符串， 没有空格和换行,  类似这样子  {"return_msg":"响应成功"}
 */
- (NSString *)kjwd_convertToJsonStringWithoutLineAndbreak;

/**
 *  转成没有空格和换行,  类似这样子  {\"return_msg\":\"响应成功\"}
 */
- (NSString *)kjwd_myConvertToJsonStringAsData;


/**
 *  转成字符串（不是JSON格式）
 */
- (NSString *)kjwd_returnString;

/**
 查看值的数据类型
 */
- (void)kjwd_lookValuesDataType;

/// 打印归档的日志
- (void)kjwd_encode_log;

/**
 返回的数组只有两个元素，第一个元素是KeysArray，第二个元素是ValuesArray，这KeysArray和ValuesArray元素个数相同，（注意：KeysArray的顺序和self想要的顺序不一定是一致的）

 @return @[@[Key0, Key1], @[Value0, Value1]]
 */
- (NSArray <NSArray *>*)kjwd_returnKeysArrayValuesArray;


/**
 
 字典转换成 字典数组，例如 {"key1" : "value1", "key2" : "value2"}  转换为 [{"key1" : @"value1"}, {"key2" : "value2"}];
 
例子

 NSString *name = @"name";
 name.kjwd_helperNumber = 1;
 
 NSString *age = @"age";
 age.kjwd_helperNumber = 2;
 
 NSString *sex = @"sex";
 sex.kjwd_helperNumber = 3;
 
 NSString *height = @"height";
 height.kjwd_helperNumber = 4;
 
 
 NSDictionary *dic = @{name : @"张三",
 age :  @"20",
 sex :  @"男",
 height :  @"170"
 };

 
 如果按照kjwd_helperNumber升序，那么 转换后
 @[
 @{name : @"张三"},
 @{age :  @"20"},
 @{sex :  @"男"},
 @{height :  @"170"}
 ];
 

 
 @return 排好序的字典数组
 */
- (NSMutableArray *)kjwd_returnDicArrayWithSort:(NSComparator NS_NOESCAPE)cmptr;



/**
 从本地读取数据
 
 
 NSDictionary *dic = [NSDictionary kjwd_readJsonDataFromLocalWithName:@"NewList" type:@"geojson"];
 NSArray *arr = dic[@"result"];

 @param name 文件名
 @param type 类型
 */
+ (NSDictionary *)kjwd_readJsonDataFromLocalWithName:(nullable NSString *)name type:(nullable NSString *)type;

/**
 Json字符串转成字典
 */
+ (NSDictionary *)kjwd_readFromJsonString:(nullable NSString *)jsonStr;


@end

#pragma mark - -----------------NSIndexSet-----------------
@interface NSIndexSet (WDYHFCategory)

- (NSArray *)kjwd_returnArray;

@end

#pragma mark - -----------------UIAlertController-----------------
@interface UIAlertController (WDYHFCategory)

+ (instancetype)kjwd_alertTitle:(NSString *_Nullable)alertTitle message:(NSString *_Nullable)message alertAction_Left:(NSString *_Nullable)leftActionTitle leftBlock:(void(^_Nullable)(void))leftBlock right:(NSString *_Nullable)rightActionTitle rightBlock:(void(^_Nullable)(void))rightBlock presentingVC:(UIViewController *_Nullable)presentingVC;

+ (instancetype)kjwd_alertTitle:(NSString *_Nullable)alertTitle message:(NSString *_Nullable)message actionSheet_top:(NSString *_Nullable)topSheetTitle topBlock:(void(^_Nullable)(void))topBlock centerSheet:(NSString *_Nullable)centerSheetTitle centerBlock:(void(^_Nullable)(void))centerBlock buttomSheet:(NSString *_Nullable)buttomSheetTitle buttomBlock:(void(^_Nullable)(void))buttomBlock presentingVC:(UIViewController *_Nullable)presentingVC;

@end

#pragma mark - -----------------UITabBar-----------------
@interface UITabBar (WDYHFCategory)

- (void)kjwd_setTopImage:(UIImage *)image;

@end

#pragma mark - -----------------UIColor-----------------
@interface UIColor (WDYHFCategory)

+ (UIColor *)kjwd_arc4Color;

+ (UIColor *)kjwd_r:(NSInteger)r g:(NSInteger)g b:(NSInteger)b alpha:(CGFloat)alpha;
+ (UIColor *)kjwd_rbg:(NSInteger)rgb alpha:(CGFloat)alpha;

+ (UIColor *)kjwd_colorWithHexString:(NSString *)color;

+ (UIColor *)kjwd_title;
+ (UIColor *)kjwd_subTitle;

+ (UIColor *)kjwd_230Color;

+ (UIColor *)kjwd_blueBtnColor;

+ (UIColor *)kjwd_coverGrayWithAlphaComponent:(CGFloat)alpha;

@end


@interface NSURL (KJ_Category)

/**
 *  解决 有中文 会导致转换失败的问题, 场景1：设置UIImage时使用
 */
+ (NSURL *)kjwd_URLWithString:(nullable NSString *)urlString;


/**
 打开URL
 
 @param urlString  比如 电话 tel:18822221111，
 @param options 可以传nil
 @param completion 可以传nil
 */
+ (void)kjwd_openURLWithString:(NSString *_Nullable)urlString options:(NSDictionary<UIApplicationOpenExternalURLOptionsKey, id> *_Nullable)options completionHandler:(void (^_Nullable)(BOOL success))completion;



@end

#pragma mark - -----------------UIViewController-----------------
@interface UIViewController (WDYHFCategory)

/** 得到当前控制器 被 哪一个控制器 推过来的 控制器 */
- (nullable UIViewController *)kjwd_previous_PushedVC;

/** 从MainStoryBoard加载同名的控制器 */
+ (instancetype)kjwd_instanceInMain;

/** 从MainStoryBoard加载 标示 的控制器 */
+ (instancetype)kjwd_instanceInMainWithIdentifier:(NSString *)identifier;

/**
 *  pop到指定控制器
 *  如果当前导航控制器包含所想要pop到的控制器，会调用currentStackBlock
 *  如果当前导航控制器不包含所想要pop到的控制器，那么把newVc插入到导航控制器的viewControllers数组里
 *  @param vcClass 类名 (例如[ViewController class])
 */
- (void)kjwd_popToSpecifyVC:(Class)vcClass currentStackBlock:(void(^_Nullable)(__kindof UIViewController *findZheVC))currentStackBlock newAllocVC:(__kindof UIViewController *_Nullable)newVc;
/**
 *  通过动画切换根视图控制器
 */
- (void)kjwd_settoRootVCWithAnimation:(BOOL)animation;


@end



#pragma mark - -----------------UINavigationController-----------------
@interface UINavigationController (WDYHFCategory)

- (nullable UIViewController *)kjwd_rootViewController;



/**
 *  将navigationBar设置为透明
 */
- (void)kjwd_setClearNavigationBar;

/**
 *  设置标题颜色字体等等
 */
- (void)kjwd_setTitleColorFontDic:(NSDictionary *)dic;
/**
 *  设置左右item颜色
 */
- (void)kjwd_setLeftRightBarButtonItemColor:(UIColor *)color;

@end

#pragma mark - -----------------UIBarButtonItem-----------------
@interface UIBarButtonItem (WDYHFCategory)

+ ( instancetype)kjwd_itemWithTitle:(nullable NSString *)title color:(nullable UIColor *)color callBack:(void(^)(UIBarButtonItem *sender))callBack;


/**
 用UIButton包装CustomView
 如果想要在superview上加子视图，只能使用frame，不能使用约束
 
 self.navigationItem.rightBarButtonItem = [UIBarButtonItem kjwd_itemWithNormalImage:[UIImage kjwd_imageNamed:@"信息"] detailSetting:^(UIButton *btn, UIView *superview) {
 btn.center = superview.center;
 } wrapperSize:CGSizeMake(30, 30) btnFrame:CGRectMake(0, 0, 30, 30) style:UIBarButtonItemStyleDone callBack:^(UIBarButtonItem *sender) {
 NSLog(@"%@ ", @"点击信息");
 }];
 
 */
+ (instancetype)kjwd_itemWithNormalImage:(nullable UIImage *)normalImage detailSetting:(void(^_Nullable)(UIButton *_btn, UIView *_superview))detailSetting wrapperSize:(CGSize)wrapperSize btnFrame:(CGRect)btnFrame  style:(UIBarButtonItemStyle)style callBack:(void(^_Nullable)(UIBarButtonItem *_sender))callBack;


@end

#pragma mark - -----------------UINavigationItem-----------------
@interface UINavigationItem (WDYHFCategory)

/**
 titleView 仅仅是一张图片 （默认居中）
 
 
 CGFloat mutil = 315 / 90.0;
 self.navigationItem.titleView = [UINavigationItem kjwd_returnTitleViewWithImage:[UIImage kjwd_imageNamed:@"logo-字"] imageViewSize:CGSizeMake(mutil * 35, 35) detailSetting:nil];
 
 */
+ (UIView *)kjwd_returnTitleViewWithImage:(nullable UIImage *)image imageViewSize:(CGSize)imageViewSize detailSetting:(void(^_Nullable)(UIImageView *_imageView, UIView *_superview))detailSetting;

@end




@interface UITableView (WDYHFCategory)

- (void)kjwd_reloadData;
- (void)kjwd_reloadSection:(NSInteger)section withRowAnimation:(UITableViewRowAnimation)animation;
- (void)kjwd_selectRow:(NSInteger)row section:(NSInteger)section animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition;
- (void)kjwd_scrollToRow:(NSInteger)row section:(NSInteger)section atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;


@end


@interface UICollectionView (WDYHFCategory)

- (void)kjwd_reloadData;

@end


#pragma mark - -----------------UIView-----------------
@interface UIView (WDYHFCategory)

@property (strong, nonatomic, nullable) id ex_Obj1;



/// 返回当前视图的控制器
- (nullable __kindof UIViewController *)kjwd_currentViewController;

/// 获取当前的Cell，实例 CKJCommonTableViewCell *cell = [btn kjwd_getCell];
- (nullable __kindof UITableViewCell *)kjwd_getCell;


/**
 这几个属性是 Masonry的封装
 */
@property (nonatomic, strong, nullable, readonly) MASViewAttribute * kjwdMas_safeAreaTop;
@property (nonatomic, strong, nullable, readonly) MASViewAttribute * kjwdMas_safeAreaBottom;
@property (nonatomic, strong, nullable, readonly) MASViewAttribute * kjwdMas_safeAreaLeft;
@property (nonatomic, strong, nullable, readonly) MASViewAttribute * kjwdMas_safeAreaRight;

- (NSArray *_Nullable)kjwd_masWithSuperView:(UIView *)superView makeConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))block;


- (NSArray *_Nullable)kjwd_mas_makeConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))block;
- (NSArray *_Nullable)kjwd_mas_updateConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))block;
- (NSArray *_Nullable)kjwd_mas_remakeConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))block;
- (void)kjwd_addToSuperView:(nullable UIView *)superview constraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))block;


- (void)kjwd_setHidden:(BOOL)hidden;

@property (nonatomic, assign) CGFloat kjwd_x;
@property (nonatomic, assign) CGFloat kjwd_y;
@property (nonatomic, assign) CGFloat kjwd_centerX;
@property (nonatomic, assign) CGFloat kjwd_centerY;
@property (nonatomic, assign) CGFloat kjwd_width;
@property (nonatomic, assign) CGFloat kjwd_height;
@property (nonatomic, assign) CGSize  kjwd_size;
@property (nonatomic, assign) CGPoint kjwd_origin;


/**
 *  返回当前View和另外一个View中心点连线的中间point
 */
- (CGPoint)kjwd_centerPointToOtherView:(UIView *)otherView;


/**
 * 便利构造器
 * 说明 创建并使用XIB文件初始视图控制器, 默认使用与控制器相同名字的XIB文件
 * 参数 nibName, XIB文件名
 */
+ (nullable instancetype)kjwd_instanceUsingAutoNib;
+ (nullable instancetype)kjwd_instanceWithNibName:(NSString *)nibName;

/**
 * 视图转化成图片
 */
- (UIImage *)kjwd_shotImage;



#pragma mark - View从底部向上出现的动画效果

/**
 想要从底部向上钻处理的视图, 只需要创建对象，不需要设置frame和约束
 */
- (void)masonryWithAnimateFromScreenButtomWithDuration:(NSTimeInterval)duration superView:(UIView *_Nullable)superView selfMasonryHeight:(CGFloat)height coverViewColor:(UIColor *_Nullable)coverViewColor animationCompletion:(void (^_Nullable)(BOOL))completionBlock triggerTapGestureRecognizerBlock:(void(^)(void(^_disappearBlock)(void)))triggerTapGestureRecognizerBlock;
/** 点击灰色蒙版消失，需要开发者主动调用（View从底部向上出现的动画效果是配合使用） */
- (void)masonryWithAnimateFromScreenButtom_hiddenBackGroundView;



#pragma mark - 手势

/**
 添加手势 （注意：该block引用里面的强指针）

 @param ges 手势
 @param handleBlock 手势触发的回调
 */
- (void)kjwd_addGestureRecognizer:(UIGestureRecognizer *)ges handleBlock:(void(^)(__kindof UIGestureRecognizer * gestureRecognizer, __kindof UIView * currentView))handleBlock;

- (void)kjwd_addTapGestureRecognizerHandleBlock:(void(^)(UITapGestureRecognizer *_gestureRecognizer, UIView *_currentView))handleBlock;

@end


@interface UIButton (WDYHFCategory)

#pragma mark - -----------------UIButton-----------------

// 定义一个枚举（包含了四种类型的button）
typedef NS_ENUM(NSUInteger, GLButtonEdgeInsetsStyle) {
    /** image在上，label在下 */
    GLButtonEdgeInsetsStyleTop,
    /** image在左，label在右 */
    GLButtonEdgeInsetsStyleLeft,
    /** image在下，label在上 */
    GLButtonEdgeInsetsStyleBottom,
    /** label在左, image在右 */
    GLButtonEdgeInsetsStyleRight
};


/**
 *  设置button的titleLabel和imageView的布局样式，及间距 (注意：如果修改了Font，需要重新调用此方法进行布局)
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)kjwd_layoutButtonWithEdgeInsetsStyle:(GLButtonEdgeInsetsStyle)style
imageTitleSpace:(CGFloat)space;




/**
 最常用的 点击按钮 回调

 @param callBack 回调block
 */
- (void)kjwd_addTouchUpInsideForCallBack:(void(^_Nullable)(UIButton * _sender))callBack;
- (void)kjwd_addControlEvents:(UIControlEvents)controlEvents forCallBack:(void(^_Nullable)(UIButton * _sender))callBack;

/// 实心样式的
+ (instancetype)fillStyleWithTitle:(id)title bgColor:(UIColor *_Nullable)bgColor radius:(NSNumber *_Nullable)radius callBack:(void(^_Nullable)(UIButton * _sender))callBack;


@end

@interface UILabel (WDYHFCategory)

+ (instancetype)kjwd_labelWithText:(nullable NSString *)text fontSize:(nullable NSNumber *)fontSize color:(nullable UIColor *)color;

@end

@interface UIScrollView (WDYHFCategory)

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
- (void)kjwd_viewsOfVertical:(NSArray <UIView *>*)views viewHeight:(CGFloat)viewHeight itemSpacing:(CGFloat)itemSpacing topSpacing:(CGFloat)topSpacing bottomSpacing:(CGFloat)bottomSpacing horizontalConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))horizontalConstraints;


/**
 水平方向添加Views

 @param views views数组
 @param width 每一个View的宽度
 @param itemSpacing 每一个View之间的间距
 @param leftSpacing 左边距离
 @param rightSpacing 右边距离
 @param verticalConstraints 垂直方向的约束
 */
- (void)kjwd_viewsOfHorizontal:(NSArray <UIView *>*)views viewWidth:(CGFloat)width itemSpacing:(CGFloat)itemSpacing leftSpacing:(CGFloat)leftSpacing rightSpacing:(CGFloat)rightSpacing vorizontalConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make, UIView *superview))verticalConstraints;

@end




/*
 
 [a compare:b] == NSOrderedAscending  升序   a < b     a日期较早
 [a compare:b] == NSOrderedSame,      相等
 [a compare:b] == NSOrderedDescending 降序   a > b     a日期较晚
 
 
 */

#pragma mark - -----------------NSDate-----------------
@interface NSDate (WDYHFCategory)

#define CKJDateFormat1 (@"yyyy-MM-dd HH:mm:ss")
#define CKJDateFormat2 (@"yyyy-MM-dd")

#define CKJDateFormat3 (@"yyyyMMddHHmmss")
#define CKJDateFormat4 (@"yyyyMMdd")

#define CKJDateFormat5 (@"yyyy-MM-dd HH:mm")


/// 传入20190723 返回 2019-07-23
+ (NSString *)kjwd_format1:(NSString *_Nullable)dateStr;

+ (nullable NSDate *)kjwd_returnDate:(NSString *_Nullable)dateString withDateFormat:(NSString *_Nullable)format;

/**
 输入 yyyy-MM-dd HH:mm:ss 这样的字符串-----> 返回 yyyy-MM-dd 的字符串
 */
+ (NSString *)kjwd_return_yMdWithDate:(NSString *_Nullable)dateString;


/**
 把该时间的时分秒设置为00:00:00 ---->然后返回新的时间
 */
- (NSDate *)kjwd_set_HmsEqualZero_Date;


/** 把 “2017-12-21”  时分秒设置为0 返回时间  */
+ (nullable NSDate *)kjwd_set_HmsEqualZero_withYMDString:(nullable NSString *)YMDString;

/**
 返回 yyyy-MM-dd HH:mm:ss 的字符串
 */
- (NSString *)kjwd_dateString;


/// 返回 yyyy-MM-dd 的字符串
- (NSString *)kjwd_YearMonthDayString;
- (NSString *)kjwd_year;
- (NSString *)kjwd_month;
- (NSString *)kjwd_day;
- (NSString *)kjwd_hour;
- (NSString *)kjwd_minute;
- (NSString *)kjwd_second;

/// 通过 格式 返回 时间字符串 比如 传入 "yyyyMMdd" 返回 "20180203"
- (NSString *)kjwd_dateStringWithFormatter:(NSString *)formatterStr;

/// 距离1970年的秒数
- (long long)kjwd_timeIntervalSince1970;
/// 距离1970年的毫秒数
- (long long)kjwd_timeIntervalSince1970_Milliseconds;

/** 判断是否是同一天 */
- (BOOL)kjwd_isSameDayToDate2:(NSDate *)date2;

/** 明天 */
- (NSDate *)kjwd_tomorrow;
/** 昨天 */
- (NSDate *)kjwd_yesterDay;
/** 明年 */
- (NSDate *)kjwd_nextyear;
/** 去年 */
- (NSDate *)kjwd_yesterYear;


/**
 * 返回 1小时前 这样的字符 (传入2017-12-21 20:53:00.0  这样的字符串)
 */
+ (NSString *)kjwd_returnWordsForTime:(NSString *)str;


@end


#pragma mark - -----------------UIImage-----------------

@interface UIImage (WDYHFCategory)

/** 加载图片过滤空字符串 */
+ (UIImage *)kjwd_imageNamed:(nullable NSString *)name;
+ (UIImage *)kjwd_imageWithUrlStr:(nullable NSString *)urlStr;

/** 通过给定颜色和大小生成图片 */
+ (UIImage *)kjwd_imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)kjwd_imageWithColor:(UIColor *)color size:(CGSize)size radius:(CGFloat)radius;

/** 生成二维码 */
+ (UIImage *)kjwd_QRCodeWithContent:(NSString *)content size:(CGSize)size;

/** 生成指定大小的图片 */
- (UIImage *)kjwd_scaleToSize:(CGSize)size;

/// 不拉伸缩放，可以传入宽度或者高度
- (UIImage *)kjwd_noTransformScaleToWidth:(NSNumber *_Nullable)newWidthNumber height:(NSNumber *_Nullable)newHeightNumber;


/** 设置圆角并生成新图片 */
- (UIImage *)kjwd_setCornerRadius:(CGFloat)radius;

/**
 根据文字和颜色 生成图片
 @param isCircular 是否画圆
 */
+ (nullable UIImage *)kjwd_imageWithColor:(nullable UIColor *)color
                                     size:(CGSize)size
                                     text:(nullable NSString *)text
                           textAttributes:(nullable NSDictionary *)textAttributes
                                 circular:(BOOL)isCircular;


/*
 渐变色生成图片
 
 gradientType
 1. 上到下
 2. 左到右
 3. 左上到右下
 4. 右上到左下
 
 */
+ (UIImage *)kjwd_gradientColorImageFromColors:(NSArray <UIColor *>*)colors gradientType:(NSInteger)gradientType imgSize:(CGSize)imgSize;

@end

#pragma mark - -----------------NSPredicate-----------------

@interface NSPredicate (WDYHFCategory)

/** 验证正则表达式 */
+ (BOOL)kjwd_validateRegexStr:(nullable NSString *)regexStr targetStr:(nullable NSString *)targetStr;

@end

#pragma mark - -----------------NSString-----------------

@interface NSString (WDYHFCategory)


+ (NSString *)guidWithType:(KJWDArc4randomType)type;

// 邮箱
- (BOOL)kjwd_validateEmail;

/// 手机号码验证
- (BOOL)kjwd_varityPhoneSuccess;

/// 默认左3位  右2位， *6位， 比如  177******94
- (NSString *)kjwd_Phone_defaultStar;
/** 手机号 左右各保留几位， 比如左3位  右2位， *6位，  177******94 */
- (NSString *)kjwd_PhoneLeftMargin:(NSInteger)left rightMargin:(NSInteger)right starNumber:(NSInteger)starNumber;


// 车牌号验证
- (BOOL)kjwd_validateCarNo;

// 车型
- (BOOL)kjwd_validateCarType;

// 用户名
- (BOOL)kjwd_validateUserName;

/**
 * 密码
 * 说明 必须同时包含大写、小写、字母，这样的组合
 * 参数 min, 最少位
 * 参数 max, 最大位
 */
- (BOOL)kjwd_validatePasswordWithMin:(unsigned int)min max:(unsigned int)max;

/**
 * 昵称
 * 说明 以中文开头
 * 参数 min, 最少位
 * 参数 max, 最大位
 */
- (BOOL)kjwd_validateNicknameWithMin:(unsigned int)min max:(unsigned int)max;

// 身份证号
- (BOOL)kjwd_validateIdentityCard;

/**
 * 验证码
 * 说明 纯数字验证码, 默认6位
 * 参数 size, 位数
 */
- (BOOL)kjwd_validateVerifyCode;
- (BOOL)kjwd_validateVerifyCodeWithSize:(unsigned int)size;



/** 是否全是数字 */
- (BOOL)kjwd_isNumber;

/** 是否全是大写或数字 */
- (BOOL)kjwd_inputShouldUpperAndNumber;

/** 是否全是字母或数字 */
- (BOOL)kjwd_isCharAndNumber;

/** 是否包含大写字母 */
- (BOOL)kjwd_containsUppercase;
/** 是否包含小写字母 */
- (BOOL)kjwd_containsLowercase;
/** 是否包含数字 */
- (BOOL)kjwd_containsNumber;



/** 身份证号 年月日转为*号 */
- (NSString *)kjwd_idCardToAsterisk;

/// 返回身份证号的年月日,  比如 19980320
- (NSString *)kjwd_idCardBirthday;

/// 返回身份证号的年月日,  比如 1998-03-20
- ( NSString *)kjwd_idCardBirthday2;

/// 返回身份证号的年  比如 1998
- (NSString *)kjwd_idCardBirthday_Year;


/** 身份证号 左右各保留3位， 452************026 */
- (NSString *)kjwd_idCard_defaultStar;

/** 身份证号 左右各保留几位， 比如左右各保留3位， 452************026 */
- (NSString *)kjwd_idCardLeftMargin:(NSInteger)left rightMargin:(NSInteger)right;

/// 获取身份证上的性别
- (NSString *)kjwd_idCard_GetSex;
/// 获取身份证上的年龄
- (NSString *)kjwd_idCard_GetAge;


/**
 * MD5加密
 * 说明 MD5是消息摘要算法
 * 返回 16位字符串类型的 MD5 hash值
 */
- (NSString *)kjwd_MD5;


/**
 过滤首尾的空格和换行
 */
- (NSString *)kjwd_trimWhiteAndNewline;
/**
 过滤首尾的空格
 */
- (NSString *)kjwd_trimWhite;
/**
 过滤所有的空格和换行
 */
- (NSString *)kjwd_trimAllWhiteAndNewline;
// 过滤所有的空格
- (NSString *)kjwd_trimAllWhite;

+ (NSString *)kjwd_uuidString;






/**
 *  这个在时间很短时， 得到多个随机数， 可能得到的随机数是相同的
 */
+ (NSString *)kjwd_returnGetArc4randomWithNum:(NSUInteger)num type:(KJWDArc4randomType)type;

+ (NSString *)kjwd_returnArc4randomWithNum:(NSUInteger)num type:(KJWDArc4randomType)type;


+ (NSString *)kjwd_returnJsonStrFromDic:(NSDictionary *_Nullable)dic;

+ (NSString *)kjwd_arrayStringWithStringArray:(NSArray *)array;

@property (assign, nonatomic) CGFloat kjwd_helperNumber;

#pragma mark - 字符串操作
- (nullable NSString *)kjwd_substringFromIndex:(NSUInteger)from;
- (nullable NSString *)kjwd_substringToIndex:(NSUInteger)to;
- (nullable NSString *)kjwd_substringWithRange:(NSRange)range;
- (nullable NSString *)kjwd_stringByAppendingString:(nullable NSString *)aString;
- (nullable NSString *)kjwd_stringByReplacingCharactersInRange:(NSRange)range withString:(nullable NSString *)replacement;

/**
 使用toStr 替换掉beiReplace

 @param beiReplace 被替换的字符
 @param toStr 用这个去替换
 */
- (NSString *)kjwd_BeiReplace:(NSArray <NSString *>*)beiReplace toStr:(NSString *)toStr;


/// 查找符合正则的结果数组
/// @param options 一般传入NSRegularExpressionCaseInsensitive不区分字母大小写
- (NSArray <NSTextCheckingResult *>*)kjwd_searchWithRegularExpression:(NSString *)reg options:(NSRegularExpressionOptions)options;

- (NSArray <NSString *>*)kjwd_general_searchWithReg:(NSString *)reg options:(NSRegularExpressionOptions)options;

/// 正则 捕获组
- (NSArray <NSArray <NSString *>*>*)kjwd_group_searchWithReg:(NSString *)reg options:(NSRegularExpressionOptions)options;

@end

#pragma mark - -----------------NSDecimalNumber-----------------
@interface NSMutableAttributedString (WDYHFCategory)

- (NSMutableAttributedString *)kjwd_append:(NSAttributedString *_Nullable)att;

@end

#pragma mark - -----------------NSDecimalNumber-----------------
@interface NSDecimalNumber (WDYHFCategory)


/**
 如果能转成确定的十进制，那就转成本身的十进制，否则转成十进制0 (即使传入汉字或者字母等等，也会返回一个确定的十进制数，比如0)
 */
+ (instancetype)kjwd_confirmDecimalNumberWithString:(nullable NSString *)string;

@end


#pragma mark - -----------------CALayer-----------------
@interface CALayer (WDYHFCategory)

/**
 *  暂停 layer 层的动画
 */
- (void)kjwd_pauseAnimation;
/**
 *  继续 layer 层的动画
 */
- (void)kjwd_goonAnimation;

@end

#pragma mark - -----------------自定义UI部分-----------------

@class CKJCountDownButton;
typedef NSString*_Nonnull (^CountDownChanging)(CKJCountDownButton *countDownButton,NSUInteger second);
typedef NSString*_Nonnull (^CountDownFinished)(CKJCountDownButton *countDownButton,NSUInteger second);
typedef void (^TouchedCountDownButtonHandler)(CKJCountDownButton *countDownButton,NSInteger tag);

@interface CKJCountDownButton : UIButton
@property(nonatomic,strong) id userInfo;
///倒计时按钮点击回调
- (void)countDownButtonHandler:(TouchedCountDownButtonHandler)touchedCountDownButtonHandler;
//倒计时时间改变回调
- (void)countDownChanging:(CountDownChanging)countDownChanging;
//倒计时结束回调
- (void)countDownFinished:(CountDownFinished)countDownFinished;
///开始倒计时
- (void)startCountDownWithSecond:(NSUInteger)second;
///停止倒计时
- (void)stopCountDown;

@end


#pragma mark - -----------------其他部分-----------------

@interface CKJOriginalObject : NSObject

@property (nonatomic, copy) void (^block)(void) ;
- (instancetype)initWithBlock:(void (^)(void))block;

@end

@interface CKJAPPHelper : NSObject


/// 主Version
+ (NSString *)currentVersion;
/// buildVersion
+ (NSString *)currentBuildVersion;

+ (NSString *)bundleId;

+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;
+ (NSString *)kjwd_documentPath;


#pragma mark - Swift命名空间相关
+ (NSString *)kj_nameSpace;
+ (NSString *)return_ModelName:(NSString *)modelName;
+ (Class)returnClass_ClassString:(NSString *)classString;


@end




NS_ASSUME_NONNULL_END
