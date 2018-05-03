//
//  KJCommonManager.h
//  AirCleaner
//
//  Created by chenkaijie on 17/4/27.
//  Copyright © 2017年 HadLinks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileManagerTool.h"
#import <CoreLocation/CoreLocation.h>

@interface KJCommonManager : NSObject

#define KJCommMInstance [KJCommonManager defaultKJKJCommonManager]

+ (instancetype)defaultKJKJCommonManager;

/*
 * 进入前台 时间, (应用程序从杀死到 重新点击App图标， 不算)
 */
@property (strong, nonatomic) NSDate *willEnterForeground_date;
/*
 * 进入后台 时间
 */
@property (strong, nonatomic) NSDate *didEnterBackground_date;



/**
 *  ignoreResultRe_request: 忽略结果 重新请求， 默认传NO
 *  @{device1.mac : 宁波， device2.mac : 杭州}
 */
- (void)currentLocationOfAppCompletion:(void (^)(CLPlacemark *mark))completion failure:(void (^)(NSString *message))failureHandler ignoreResultAndRe_request:(NSNumber *)ignoreResultRe_request timeoutInterval:(NSNumber *)timeoutInterval;
@property (strong, nonatomic, readonly) CLPlacemark *currentPlacemark;

/** 是否有定位权限*/
- (BOOL)ishaveLocationAuthorize;
/** 进入定位系统设置*/
- (void)show_requestLocationAuthorizeAlertController;





//- (void)redirectNSLogToDocumentFolder;
///**
// *  Log 文件夹 路径
// */
//- (NSString *)Log_folder_path;
//
///**
// *  所有的log文件的名字数组
// */
//- (NSArray <NSString *>*)all_logFileName;
//
///**
// *  所有的log文件的 全路径
// */
//- (NSArray <NSString *>*)all_logfile_FullPath;





/**
 *  阻塞这个block里面的代码块
 */
- (void)performBlock:(void (^)())block cloggedTimeInterval:(NSTimeInterval)timeInterval;





@end
