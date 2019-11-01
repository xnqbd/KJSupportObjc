//
//  CKJLibraryHelper.m
//  MobileHospital_Renji
//
//  Created by xnqbd on 2019/10/24.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJLibraryHelper.h"

@implementation CKJLibraryHelper

+ (void)commomCode1WithTFModel:(CKJTFModel *)tfModel tf:(UITextField *)tf {
    
    NSAttributedString *attributedText = tfModel.attributedText;

    NSAttributedString *attributedPlaceholder = tfModel.attributedPlaceholder;
    
    if (WDKJ_IsEmpty_AttributedStr(attributedText)) {
        tf.attributedText = nil;
    } else {
        tf.attributedText = attributedText;
    }
    
    if (WDKJ_IsEmpty_AttributedStr(attributedPlaceholder)) {
        tf.attributedPlaceholder = nil;
    } else {
        tf.attributedPlaceholder = attributedPlaceholder;
    }
    tf.userInteractionEnabled = tfModel.userInteractionEnabled;
    tf.textAlignment = tfModel.textAlignment;
    tf.borderStyle = tfModel.borderStyle;
    tf.keyboardType = tfModel.keyboardType;
    
}
+ (void)commomCode2WithTFModel:(CKJTFModel *)tfModel tf:(UITextField *)tf {

    //    NSLog(@"tf.attributedText.string  %@", tf.attributedText.string);
        
        if (![tfModel.attributedText.string isEqualToString:tf.attributedText.string]) {
            tfModel.attributedText = tf.attributedText;
            
            SEL sel = @selector(__privateMethod__exeCallBack);
            [NSObject cancelPreviousPerformRequestsWithTarget:tfModel selector:sel object:nil];
            [tfModel performSelector:sel withObject:nil afterDelay:tfModel.seconds];
    //        NSLog(@"后 %@", tf.attributedText.string);
        }
}

@end
