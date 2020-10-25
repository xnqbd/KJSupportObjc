//
//  KJLocationManager.h
//  MobileManage
//
//  Created by admin2 on 2020/9/27.
//  Copyright © 2020 admin2. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLLocation;

NS_ASSUME_NONNULL_BEGIN

@interface CKJLocationManager : NSObject

- (void)getLocation:(void(^)(CLLocation *location))location;

@end

NS_ASSUME_NONNULL_END
