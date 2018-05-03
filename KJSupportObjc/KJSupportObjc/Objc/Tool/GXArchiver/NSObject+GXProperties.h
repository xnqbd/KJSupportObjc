//
//  NSObject+GXProperties.h
//
//  Created by garyxuan on 16/6/29.
//  Copyright © 2016年 garyxuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GXProperties)

/**
 *  获取一个类的所有属性的名称和类型
 *
 *  @return @[@{@"name":@"XXX",@"type":@"XXX"},,,,]
 */
- (NSArray *)gx_allProperty:(Class)cla;
@end
