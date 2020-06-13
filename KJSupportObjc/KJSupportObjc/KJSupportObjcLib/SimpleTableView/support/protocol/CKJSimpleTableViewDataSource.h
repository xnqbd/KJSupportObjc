//
//  CKJSimpleTableViewDataSource.h
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/12/6.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CKJSimpleTableViewDataSource <NSObject>

@required;
/**
 一定要匹配匹配正确
 键值对
 OC版本

 - (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues:(CKJSimpleTableView *_Nonnull)s {
     return @{
         NSStringFromClass([CKJCommonCellModel class]) : @{KJPrefix_cellKEY : NSStringFromClass([CKJCommonTableViewCell class]), KJPrefix_isRegisterNibKEY : @YES}
     };
 }     
 

 Swift版本
 return [NSStringFromClass(HZYHFWDYHFPayNotesCell2CellModel.self) : [KJPrefix_cellKEY : NSStringFromClass(HZYHFWDYHFPayNotesCell2Cell.self), KJPrefix_isRegisterNibKEY : false]]

 @return 键值对
 */
- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues:(CKJSimpleTableView *_Nonnull)s;

@optional;

/**
 一定要匹配匹配正确
 键值对     return @{ NSStringFromClass([DemoHeaderModel class]) : NSStringFromClass([DemoHeader class])};
 @return 键值对
 */
- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnHeader_Model_keyValues:(CKJSimpleTableView *_Nonnull)s;
- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnFooter_Model_keyValues:(CKJSimpleTableView *_Nonnull)s;

/**
 保留Plain样式 区头悬浮
 */
- (BOOL)savePlainStyleSectionHeaderSuspension;

@end


NS_ASSUME_NONNULL_END
