//
//  CKJCombineCellProtocol.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/4/13.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 用法
 
 
 // 外面使用
 NSArray <NSDictionary *>*result = responseObject;
 
 NSMutableArray <__kindof CKJCommonCellModel *>*cellModels = [NSMutableArray array];
 [NSMutableArray kjwd_arrayWithKeyValuesArray:result modelClass:[RJMedicinePrescriptionQueryDetailModel class] callBack:^(RJMedicinePrescriptionQueryDetailModel *currentModel) {
 [cellModels kjwd_addObjectsFromArray:currentModel.combineCellModelsToArray];
 }];
 [weakSelf.simpleTableView appendCellModelArray:cellModels atLastRow_InAllCellModelArrayOfSection:m.cell.section];
 
 [weakSelf.simpleTableView kjwd_reloadData];
 
 
 
 
 
 // 里面设置
 
 - (NSMutableArray <__kindof CKJCommonCellModel *>* _Nonnull)combineCellModelsToArray {
 NSMutableArray<__kindof CKJCommonCellModel *>*result = [NSMutableArray array];
 CGFloat emptyHeight = 5;
 
 CKJEmptyCellModel *headerEmpty = [CKJEmptyCellModel emptyCellModelWithHeight:emptyHeight showLine:NO];
 CKJEmptyCellModel *footerEmpty = [CKJEmptyCellModel emptyCellModelWithHeight:emptyHeight showLine:YES];
 
 UIColor *color333 = [UIColor kjwd_titleColor333333];
 
 CGFloat margin = 20;
 CGFloat cellH = 0;
 
 CKJLeftRightCellModelRowBlock block = ^(CKJLeftRightCellModel *model) {
 //         model.showLine = YES;
 // model.rightLab_textAlignment = NSTextAlignmentRight;
 model.leftLab_MarginTo_SuperViewLeft = margin;
 model.rightLab_MarginTo_SuperViewRight = margin;
 
 // 如果你需要在点击这些Cell的时候得到Self的信息，可以把下面这行打开
 //        model.extensionData = self;
 };
 
 CKJLeftRightCellModel *model1 = [CKJLeftRightCellModel modelWithCellHeight:cellH cellModel_id:nil detailSettingBlock:^(__kindof CKJLeftRightCellModel * _Nonnull m) {
 m.leftAttStr = WDCKJAttributed2(@"类别名称：", color333, nil);
 m.rightAttStr = WDCKJAttributed2(self.ProjectType, color333, nil);
 block(m);
 } didSelectRowBlock:nil];
 
 CKJLeftRightCellModel *model2 = [CKJLeftRightCellModel modelWithCellHeight:cellH cellModel_id:nil detailSettingBlock:^(__kindof CKJLeftRightCellModel * _Nonnull m) {
 m.leftAttStr = WDCKJAttributed2(@"药品名称：", color333, nil);
 m.rightAttStr = WDCKJAttributed2(self.ProjectName, color333, nil);
 block(m);
 } didSelectRowBlock:nil];
 
 CKJLeftRightCellModel *model3 = [CKJLeftRightCellModel modelWithCellHeight:cellH cellModel_id:nil detailSettingBlock:^(__kindof CKJLeftRightCellModel * _Nonnull m) {
 m.leftAttStr = WDCKJAttributed2(@"药品规格：", color333, nil);
 m.rightAttStr = WDCKJAttributed2(self.Spec, color333, nil);
 block(m);
 } didSelectRowBlock:nil];
 
 CKJLeftRightCellModel *model4 = [CKJLeftRightCellModel modelWithCellHeight:cellH cellModel_id:nil detailSettingBlock:^(__kindof CKJLeftRightCellModel * _Nonnull m) {
 m.leftAttStr = WDCKJAttributed2(@"药品数量：", color333, nil);
 m.rightAttStr = WDCKJAttributed2(self.Unit, color333, nil);
 block(m);
 } didSelectRowBlock:nil];
 
 CKJLeftRightCellModel *model5 = [CKJLeftRightCellModel modelWithCellHeight:cellH cellModel_id:nil detailSettingBlock:^(__kindof CKJLeftRightCellModel * _Nonnull m) {
 m.leftAttStr = WDCKJAttributed2(@"药品单价：", color333, nil);
 m.rightAttStr = WDCKJAttributed2(self.Price, [UIColor redColor], nil);
 block(m);
 } didSelectRowBlock:nil];
 
 [result addObjectsFromArray:@[headerEmpty, model1, model2, model3, model4, model5, footerEmpty]];
 
 return result;
 }

 
 */


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
