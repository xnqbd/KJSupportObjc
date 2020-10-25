//
//  CKJUpdateView.h
//  MobileManage
//
//  Created by admin2 on 2020/9/11.
//  Copyright © 2020 admin2. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CKJUpdateView;

typedef void(^CKJUpdateViewTapUpdate)(CKJUpdateView *_v);



@interface CKJUpdateModel : NSObject


/// 是否强制更新
@property (assign, nonatomic) BOOL isMustUpdate;

@property (nonatomic, strong) NSString *content;


@end

@interface CKJUpdateView : UIView

- (void)showUpdateView:(CKJUpdateModel *)model tapUpdate:(CKJUpdateViewTapUpdate)tapUpdate;


/// 从视图移除
- (void)exeRemoveAction;

@end

NS_ASSUME_NONNULL_END
