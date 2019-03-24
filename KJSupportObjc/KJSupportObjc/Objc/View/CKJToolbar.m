//
//  CKJToolbar.m
//  EmptyPodProject
//
//  Created by chenkaijie on 2019/1/10.
//  Copyright © 2019年 chenkaijie. All rights reserved.
//

#import "CKJToolbar.h"
#import "NSObject+WDYHFCategory.h"

@interface CKJToolbarItem ()

@property (strong, nonatomic, readwrite) UIBarButtonItem *item;

@end


@implementation CKJToolbarItem

+ (instancetype)itemWithTitle:(nullable NSString *)title normalTextColor:(nullable UIColor *)normalTextColor normalTextFont:(nullable NSNumber *)normalTextFont callBack:(void(^)(UIBarButtonItem *sender))callBack {
    CKJToolbarItem *toolbarItem = [[self alloc] init];
    UIBarButtonItem *item = [UIBarButtonItem kjwd_itemWithTitle:title style:UIBarButtonItemStyleDone callBack:callBack];
    toolbarItem.item = item;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:normalTextColor forKey:NSForegroundColorAttributeName];
    [dic setValue:normalTextFont forKey:NSFontAttributeName];
    
    [item setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    return toolbarItem;
}

@end

@implementation CKJToolbar


+ (instancetype)toolbarWithLeft:(nullable CKJToolbarItem *)left center:(nullable CKJToolbarItem *)center right:(nullable CKJToolbarItem *)right {
    CKJToolbar *toolbar = [[self alloc] init];
    toolbar.leftItem = left;
    toolbar.centerItem = center;
    toolbar.rightItem = right;
    

    UIBarButtonItem *item1 = left.item;
    UIBarButtonItem *item2 = center.item;
    UIBarButtonItem *item3 = right.item;
    UIBarButtonItem *fix1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:nil action:nil];
    
    NSMutableArray *array = [NSMutableArray array];

    [array kjwd_addObject:item1];
    [array kjwd_addObject:fix1];
    [array kjwd_addObject:item2];
    [array kjwd_addObject:fix1];
    [array kjwd_addObject:item3];

    [toolbar setItems:array];
    
    return toolbar;
}


@end
