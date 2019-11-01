//
//  CKJCombineCellProtocol.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/13.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@class CKJCommonCellModel;

/**
 此协议用于将几个ACell聚合成一个虚拟的BCell，(本质上还是那几个ACell)
 如果你想要在点击某一行的时候得到BCell的内容，可以使用CKJCommonCellModel.extensionData得到它
 
 注意：此协议仅仅是展示作用，如果虚拟的BCell想要在某一时刻修改内容，那么请自定义Cell!
 */
@protocol CKJCombineCellProtocol <NSObject>

@required;
- (NSMutableArray <__kindof CKJCommonCellModel *>* _Nonnull)combineCellModelsToArray;

@end

NS_ASSUME_NONNULL_END
