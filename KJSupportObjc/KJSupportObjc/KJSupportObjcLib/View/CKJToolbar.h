//
//  CKJToolbar.h
//  EmptyPodProject
//
//  Created by chenkaijie on 2019/1/10.
//  Copyright © 2019年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CKJToolbarItem : NSObject

@property (strong, nonatomic, readonly) UIBarButtonItem *item;
@property (copy, nonatomic, nullable) void (^callBack)(UIBarButtonItem *sender);
+ (instancetype)itemWithTitle:(nullable NSString *)title normalTextColor:(nullable UIColor *)normalTextColor normalTextFont:(nullable NSNumber *)normalTextFont callBack:(void(^)(UIBarButtonItem *sender))callBack;

@end



@interface CKJToolbar : UIToolbar

@property (strong, nonatomic, nullable) CKJToolbarItem *leftItem;
@property (strong, nonatomic, nullable) CKJToolbarItem *centerItem;
@property (strong, nonatomic, nullable) CKJToolbarItem *rightItem;


+ (instancetype)toolbarWithLeft:(nullable CKJToolbarItem *)left center:(nullable CKJToolbarItem *)center right:(nullable CKJToolbarItem *)right;

@end


