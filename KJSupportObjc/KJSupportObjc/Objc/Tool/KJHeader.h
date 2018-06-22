//
//  KJHeader.h
//  KJSupportObjc
//
//  Created by chenkaijie on 2018/6/22.
//  Copyright © 2018年 uback. All rights reserved.
//

#ifndef KJHeader_h
#define KJHeader_h



/*********** 判空 *************/

#define KJ_IsNull(obj) ([obj isKindOfClass:[NSNull class]] || obj == nil)

#define KJ_IsNull_Str(String)  ([String isKindOfClass:[NSNull class]] || String == nil|| [String isEqualToString:@""])

#define KJ_ConfirmString(String) (KJ_IsNull_Str(String) ? @"" : String)
#define KJ_SpaceString(String) (KJ_IsNull_Str(String) ? @" " : String)

#define KJ_ConfirmObject(object)  KJ_IsNull(object) ? nil : object

#define KJ_IsNull_Num(Number)  ([Number isKindOfClass:[NSNull class]] || Number == nil)
#define KJ_IsNull_Array(array)  ([array isKindOfClass:[NSNull class]] || array == nil)

#define KJ_ConfirmNumber(Number) (KJ_IsNull_Num(Number) ? @0 : Number)
#define KJ_ConfirmDic(Dic) (([data isKindOfClass:[NSDictionary class]] == NO) ? [NSDictionary dictionary] : (NSDictionary *)data)


/** a 到 b 之间的随机数 */
#define KJ_RandomNum(a, b) ((arc4random() % b) + a)

#define KJ_AppDelegate  [UIApplication sharedApplication].delegate

#define KJ_KeyWindow [UIApplication sharedApplication].keyWindow

#define KJ_Width  [UIScreen mainScreen].bounds.size.width
#define KJ_Height [UIScreen mainScreen].bounds.size.height
#define KJ_Window [UIScreen mainScreen].bounds

#define KJ_typeweakself __weak typeof(self) weakSelf = self;


#endif /* KJHeader_h */
