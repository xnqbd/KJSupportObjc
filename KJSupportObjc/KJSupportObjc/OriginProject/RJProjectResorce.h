//
//  RJProjectResorce.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/6/17.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CKJStringChooseItem;

NS_ASSUME_NONNULL_BEGIN


@interface RJProjectResorce : NSObject

+ (NSArray <NSString *>*)pwdNoChars;


+ (NSArray <NSDictionary *>*)item1;
+ (NSArray <NSDictionary *>*)item2;
+ (NSArray <NSDictionary *>*)item3;
+ (NSArray <NSDictionary *>*)item4;


+ (NSString *)yuyueXuZHi;
+ (NSString *)guahaoXuZHi;


+ (NSArray <CKJStringChooseItem *>*)Gender;
+ (NSArray <CKJStringChooseItem *>*)CardType;
+ (NSArray <CKJStringChooseItem *>*)Relationship;
+ (NSArray <CKJStringChooseItem *>*)IDCardType;


@end

NS_ASSUME_NONNULL_END
