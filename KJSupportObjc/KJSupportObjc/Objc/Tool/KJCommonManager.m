//
//  KJCommonManager.m
//  AirCleaner
//
//  Created by chenkaijie on 17/4/27.
//  Copyright © 2017年 HadLinks. All rights reserved.
//

#import "KJCommonManager.h"

#import "NSObject+KJCategory.h"
#import "FileManagerTool.h"



//#define Email @"2537511854@qq.com"
static const NSString *Email = @"2537511854@qq.com";

typedef void(^LocationCompleBlock)(CLPlacemark *placemark);

@interface KJCommonManager () <CLLocationManagerDelegate>

// 定位
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (copy, nonatomic) LocationCompleBlock locationCompleBlock;

/**
 *  当前位置 重新请求时间
 */
@property (assign, nonatomic) NSTimeInterval updateLocation_timeInterval;
@property (strong, nonatomic) NSTimer *updateLocation_timer;


/**
 *  为了给阻塞blcok 提供的一个属性
 */
@property (strong, nonatomic) NSDate *flagDate;

@end

@implementation KJCommonManager


+ (instancetype)defaultKJKJCommonManager {
    static KJCommonManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[KJCommonManager alloc] init];
        [manager timeInterval_set];
//        [manager addRacObserver];
    });
    return manager;
}

- (void)currentLocationOfAppCompletion:(void (^)(CLPlacemark *mark))completion failure:(void (^)(NSString *message))failureHandler ignoreResultAndRe_request:(NSNumber *)ignoreResultRe_request timeoutInterval:(NSNumber *)timeoutInterval {
//    if ([self ishaveLocationAuthorize] == NO) {
//        NSLog(@"不好意思， 没有定位权限");
//        return;
//    }
    
//    [self lazy_updateLocationScheduledTimer:self.updateLocation_timeInterval sel:_cmd];
    
    BOOL boo = ignoreResultRe_request == nil ? NO : ignoreResultRe_request.boolValue;
    if (boo == NO) { // 如果不忽略， 那么如果有值， 就取回值
        if (self.currentPlacemark != nil) {
            if (completion) {
                completion(self.currentPlacemark);
            }
            return;
        }
    }
    // 开始定位
    [self kj_startLocating];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeoutInterval.doubleValue * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.currentPlacemark != nil) {
            NSLog(@"定位成功了 ");
            if (completion) {
                completion(self.currentPlacemark);
            }
            return;
        }
        if (failureHandler) {
            failureHandler(@"定位失败");
        }
    });
}



#pragma mark - 定位
- (CLLocationManager *)locationManager {
    if (_locationManager) return _locationManager;
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    //10米
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    _locationManager.distanceFilter = 10;
    return _locationManager;
}

- (CLGeocoder *)geocoder {
    if (_geocoder) return _geocoder;
    _geocoder = [[CLGeocoder alloc] init];
    return _geocoder;
}

- (void)kj_startLocating {
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        switch ([CLLocationManager authorizationStatus]) {
            case kCLAuthorizationStatusAuthorizedAlways:
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                [self.locationManager startUpdatingLocation];
                break;
            default:
                [self.locationManager requestWhenInUseAuthorization];
                break;
        }
    } else {
        [self.locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusNotDetermined) {
        //NSLog(@"等待用户授权");
    } else if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        //NSLog(@"授权成功");
        [self.locationManager startUpdatingLocation];
    } else {
        //NSLog(@"授权失败");
        //打开app定位设置
        //[self show_requestLocationAuthorizeAlertController];
    }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [manager stopUpdatingLocation];
    CLLocation *location = locations.lastObject;
    
    //NSString *longitude = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    //NSString *latitude = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    
    __weak typeof(self) weakSelf = self;
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *place = [placemarks firstObject];
        [weakSelf setValue:place forKey:@"currentPlacemark"];
        if (weakSelf.locationCompleBlock) {
            weakSelf.locationCompleBlock(place);
        }
    }];
}


// 这个是一个工具
- (void)reverseGeocodeWithlatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude completedBlock:(void(^)(CLPlacemark *placemark))completedBlock {
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (completedBlock) {
            completedBlock([placemarks firstObject]);
        }
    }];
}


#pragma mark - NSTimer 的 懒加载
//- (NSTimer *)lazy_updateLocationScheduledTimer:(NSTimeInterval)timeInterval sel:(SEL)sel {
//    if (self.updateLocation_timer) return self.updateLocation_timer;
//    typeweakself;
//    NSLog(@"重新 创建 定位 Timer");
//    self.updateLocation_timer = [NSTimer kj_scheduledTimerWithTimeInterval:timeInterval block:^{
//        NSLog(@"%f秒后 重新  定位  %@ ", timeInterval, [NSDate date]);
//        [weakSelf scheduled_updateLocation];
//    } repeats:YES];
//    return self.updateLocation_timer;
//}

#pragma mark - 一些初始化操作
// 各个缓存请求时间间隔设置
- (void)timeInterval_set {
    self.updateLocation_timeInterval = 6 * 60 * 60;
    //self.updateLocation_timeInterval = 30;
}

////RAC监听登录和退出
//- (void)addRacObserver {
//    typeweakself;
//    [[RACObserve(TFWUserInstance, online) distinctUntilChanged] subscribeNext:^(NSNumber *onlineNumber) {
//        BOOL online = onlineNumber.boolValue;
//        if (online == NO) { // 退出登录
//            [weakSelf.updateLocation_timer invalidate];
//            weakSelf.updateLocation_timer = nil;
//        }
//    }];
//}


//- (void)setWillEnterForeground_date:(NSDate *)willEnterForeground_date {
//    _willEnterForeground_date = willEnterForeground_date;
//
//    if (TFWUserInstance.online == NO) { // 如果用户没有登录， 就不进行请求了
//        return;
//    }
//
//    NSTimeInterval timeInterval = [_willEnterForeground_date timeIntervalSinceDate:self.didEnterBackground_date];
//    NSLog(@"Common前台到后台时间间隔 %f ", timeInterval);
//
//    if (timeInterval >= self.updateLocation_timeInterval) {
//        NSLog(@"--------- 超过时间  进行重新 更新地理位置 ---------");
//        [self scheduled_updateLocation];
//    }
//}



#pragma mark - NSTimer Block里面的 调用

//- (void)scheduled_updateLocation {
//    [TFWKJDM requestCurrentLocation_ignoreResultAndRe_request:@YES];
//}


#pragma mark - 权限
- (BOOL)ishaveLocationAuthorize {
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        switch ([CLLocationManager authorizationStatus]) {
            case kCLAuthorizationStatusAuthorizedAlways:
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                return YES;
            default:
                return NO;
                break;
        }
    } else {
        return YES;
    }
}




- (void)show_requestLocationAuthorizeAlertController {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"定位服务未开启" message:@"请在系统设置中开启定位服务" preferredStyle:UIAlertControllerStyleAlert];
    __weak UIAlertController *weakAlert = alert;
    UIAlertAction *temporarily = [UIAlertAction actionWithTitle:@"暂不" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakAlert dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *setting = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakAlert dismissViewControllerAnimated:YES completion:nil];
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:settingsURL]) {
            [[UIApplication sharedApplication] openURL:settingsURL];
        }
    }];
    [alert addAction:temporarily];
    [alert addAction:setting];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

/**
 *  阻塞这个block里面的代码块
 */
- (void)performBlock:(void (^)())block cloggedTimeInterval:(NSTimeInterval)timeInterval {
    NSDate *currentDate = [NSDate date];
    
    if (self.flagDate == nil) {
        self.flagDate = [currentDate dateByAddingTimeInterval:-(timeInterval + 1)];
    }
    
    
    NSTimeInterval interval = [currentDate timeIntervalSinceDate:self.flagDate];
    //NSLog(@"当前%@  self.flagDate %@  %f", currentDate, self.flagDate, interval);
    
    if (interval < timeInterval) return;
    
    if (block) {
        block();
    }
    self.flagDate = [NSDate date];
}





@end
