//
//  KJLocationManager.m
//  MobileManage
//
//  Created by admin2 on 2020/9/27.
//  Copyright © 2020 admin2. All rights reserved.
//

#import "CKJLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface CKJLocationManager () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) void (^getLocationBlock)(CLLocation *location);

@end

@implementation CKJLocationManager

/*
 
 -------------------------------------
 [locationManager requestWhenInUseAuthorization];
 Privacy - Location When In Use Usage Description  // 设置这个有用
 Privacy - Location Always and When In Use Usage Description  // 设置这个没用
 
 
 
 iOS14下会弹出
 1. 使用APP时允许  (下次请求不会弹框，直接得到定位信息)
 2. 允许一次  (下次请求仍然会 弹出该框)
 3. 不允许
 
 iOS14及以上会
 精准位置：打开    并且显示地图
 1. 使用APP时允许  (下次请求不会弹框，直接得到定位信息)
 2. 允许一次  (下次请求仍然会 弹出该框)
 3. 不允许
 
 
 
 
 
 -------------------------------------
 
 [locationManager requestAlwaysAuthorization];
 不管是否正在使用该应用程序，均请求用户的许可以使用位置服务。 要调用此方法，您的应用的Info.plist文件中必须同时具有
 NSLocationAlwaysUsageDescription和NSLocationWhenInInUseUsageDescription键。
 
 
 
 
 
 
 
 
 -------------------------------------
 // 这个是精准定位
 CLAccuracyAuthorizationFullAccuracy,
 // 这个是模糊定位
 CLAccuracyAuthorizationReducedAccuracy,  误差大约5km/时间误差大约20分钟
 
 requestTemporaryFullAccuracyAuthorizationWithPurposeKey 该方法是请求进行精准定位
 调用次方法会弹出 允许”APP名字“使用您的精准位置一次？
 1. 允许一次
 2. 不允许
 
 选择后，下次再调用这个方法，依然会弹出这个弹框让用户选择
 
 
 初次安装APP，locationManager.accuracyAuthorization，默认是精准定位
 启动APP，   初次获取locationManager.accuracyAuthorization为是在设置，如果是精准那就是精准，如果是模糊那就是模糊，
 
 
 */



- (void)getLocation:(void(^)(CLLocation *location))location {
    
    self.getLocationBlock = location;
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    
    
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    locationManager.distanceFilter = kCLDistanceFilterNone; // 设备至少移动n米,才通知委托更新， 这里不需要移动更新
    locationManager.pausesLocationUpdatesAutomatically = YES; // 设置iOS设备是否可暂停定位来节省电池的电量。如果该属性设为“YES”，则当iOS设备不再需要定位数据时，iOS设备可以自动暂停定位
    
    locationManager.activityType = CLActivityTypeOther; // 普通用途
    
    
    if (@available(iOS 9.0, *)) {
        locationManager.allowsBackgroundLocationUpdates = NO; // 不允许app在后台更新位置， 只有在allowsBackgroundLocationUpdates为true和Capabilities页开启Background Modes，选择了Location updates，才能在后台运行，并在delegate执行相应的逻辑
    }
    
    [locationManager requestWhenInUseAuthorization];
    
    
    self.locationManager = locationManager;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusNotDetermined) {
        //        NSLog(@"等待用户授权");
    } else if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        //        NSLog(@"授权成功");
        [self.locationManager startUpdatingLocation];
    } else {
        //        NSLog(@"授权失败");
    }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = locations.lastObject;
    
//    NSString *longitude = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
//    NSString *latitude = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    
    //    NSLog(@"经纬度  %@  %@ ", longitude, latitude);
    
    [manager stopUpdatingLocation];
    if (self.getLocationBlock) {
        self.getLocationBlock(location);
    }
}



@end
