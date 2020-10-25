//
//  CKJTool.h
//  MobileManage
//
//  Created by admin2 on 2020/8/25.
//  Copyright © 2020 admin2. All rights reserved.
//

#import "CKJBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CKJTool : CKJBaseModel

+ (void)openCameraWithVC:(UIViewController *)vc finishSelectImage:(void(^)(UIImage *image))finishSelectImage;


@end

NS_ASSUME_NONNULL_END
