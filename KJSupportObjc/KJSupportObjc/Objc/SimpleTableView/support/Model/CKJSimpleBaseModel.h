//
//  CKJSimpleBaseModel.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/7/30.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "CKJBaseModel.h"



@interface CKJSimpleBaseModel : CKJBaseModel


/**
 这个extension_Obj1可以作为一个延展数据
 场景1: 可以使用这个extension_Obj1属性聚合一个或者多个cellModel (注意：CKJEmptyCellModel除外)
 场景2: 在KJSupportObjc库自带的CellModel 如果开发者不想自定义，但是还想在携带一些数据，可以使用这个
 */
@property (strong, nonatomic, nullable) id extension_Obj1;
@property (strong, nonatomic, nullable) id extension_Obj2;
@property (weak, nonatomic, nullable) id extension_weakObj;

@property (copy, nonatomic, nullable) NSString *extension_String;


@end

