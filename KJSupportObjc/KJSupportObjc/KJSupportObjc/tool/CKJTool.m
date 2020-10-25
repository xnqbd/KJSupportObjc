//
//  CKJTool.m
//  MobileManage
//
//  Created by admin2 on 2020/8/25.
//  Copyright © 2020 admin2. All rights reserved.
//

#import "CKJTool.h"
#import <AVFoundation/AVFoundation.h>

@interface CKJTool () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (copy, nonatomic) void (^finishSelectImage)(UIImage *image);

@end

@implementation CKJTool

- (void)dealloc {
    NSLog(@"%@   ", @"CKJTool dealloc");
}

+ (void)openCameraWithVC:(UIViewController *)vc finishSelectImage:(void(^)(UIImage *image))finishSelectImage {
    CKJTool *model = [[CKJTool alloc] init];
    model.finishSelectImage = finishSelectImage;
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera]){
        //权限判断
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted ||
            authStatus ==AVAuthorizationStatusDenied){
            //无权限
            if (@available(iOS 8,*)) {
                UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有相机权限，是否前往设置" preferredStyle:UIAlertControllerStyleAlert];
                //cancel
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                }];
                [alertController addAction:action];
                
                //ok
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [NSURL kjwd_openURLWithString:UIApplicationOpenSettingsURLString options:@{} completionHandler:nil];
                }];
                [alertController addAction:okAction];
                [vc presentViewController:alertController animated:YES completion:nil];
            }
        }else{
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//            imagePickerController.allowsEditing = YES;
            imagePickerController.kjwd_extension_Obj1 = model;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.delegate = model;
            [vc presentViewController:imagePickerController animated:YES completion:nil];
            NSLog(@"点击相机");
        }
    }else{
        NSLog(@"不存在相机");
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (self.finishSelectImage) {
        self.finishSelectImage(image);
    }
    picker.kjwd_extension_Obj1 = nil;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    picker.kjwd_extension_Obj1 = nil;
}



@end
